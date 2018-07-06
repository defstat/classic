{**
 * templates/frontend/pages/indexSite.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Template for side-wide index page
 *
 *}
{include file="frontend/components/header.tpl"}

<div class="page_index_site">
	<div class="container-fluid container-page">

		{if $about}
			<div class="about_site">
				{$about|nl2br}
			</div>
		{/if}

		<div class="index-site-journals">
			<h2>
				{translate key="journal.journals"}
			</h2>
			{if !count($journals)}
				{translate key="site.noJournals"}
			{else}
				<div>
					{iterate from=journals item=journal}
						{capture assign="url"}{url journal=$journal->getPath()}{/capture}
						{assign var="thumb" value=$journal->getLocalizedSetting('journalThumbnail')}
						{assign var="description" value=$journal->getLocalizedDescription()}
						<div class="index-site-journal">
							<div class="index-site-journal-header">
								<h3>
									<a href="{$url|escape}" rel="bookmark">
										{$journal->getLocalizedName()}
									</a>
								</h3>
							</div>

							{if $thumb}
								{assign var="altText" value=$journal->getLocalizedSetting('journalThumbnailAltText')}
								<div class="index-site-journal-thumb">
									<a href="{$url|escape}">
										<img src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"{if $altText} alt="{$altText|escape}"{/if}>
									</a>
								</div>
							{/if}

							{if $description}
								<div class="index-site-journal-description{if !$thumb} full-width{/if}">
									{$description|nl2br}
								</div>
							{/if}

							<div class="index-site-journal-links">
								<a class="btn-primary view" href="{$url|escape}">
									{translate key="site.journalView"}
								</a>
								<a class="btn-primary view" href="{url|escape journal=$journal->getPath() page="issue" op="current"}">
									{translate key="site.journalCurrent"}
								</a>
							</div>
						</div>
					{/iterate}
				</div>

				{if $journals->getPageCount() > 0}
					<div class="cmp_pagination">
						{page_info iterator=$journals}
						{page_links anchor="journals" name="journals" iterator=$journals}
					</div>
				{/if}
			{/if}
		</div>
	</div>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
