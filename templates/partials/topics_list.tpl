<ul component="category" class="topics-list list-unstyled" itemscope itemtype="http://www.schema.org/ItemList" data-nextstart="{nextStart}" data-set="{set}">

	{{{ each topics }}}
	<li component="category/topic" class="category-item position-relative w-100 border-bottom py-3 py-lg-4 d-flex flex-column flex-lg-row align-items-start gap-2 gap-lg-3 ps-5 {function.generateTopicClass}" <!-- IMPORT partials/data/category.tpl -->>
		<link itemprop="url" content="{config.relative_path}/topic/{./slug}" />
		<meta itemprop="name" content="{function.stripTags, ./title}" />
		<meta itemprop="itemListOrder" content="descending" />
		<meta itemprop="position" content="{./index}" />
		<a id="{./index}" data-index="{./index}" component="topic/anchor" class="position-absolute"></a>


		<div class="thumb-avatar-box position-absolute top-0 start-0 py-3 py-lg-4">
			{{{ if ./thumbs.length }}}
			<a class="text-decoration-none" href="{./thumbs.0.url}" target="_blank">
				<img class="topic-thumb rounded-1" width="40" style="height: auto;" src="{./thumbs.0.url}"/>
			</a>
			{{{ else }}}
			<a class="text-decoration-none" href="{{{ if ./user.userslug }}}{config.relative_path}/user/{./user.userslug}{{{ else }}}#{{{ end }}}">
				{buildAvatar(./user, "40px", true, "avatar avatar-tooltip")}
			</a>
			{{{ end }}}
		</div>

		<div class="flex-grow-1 d-flex flex-wrap gap-2">

			<h3 component="topic/header" class="title text-break fs-5 fw-semibold m-0 tracking-tight w-100">
				{{{ if topics.noAnchor }}}
				<span>{./title}</span>
				{{{ else }}}
				<a class="text-reset" href="{config.relative_path}/topic/{./slug}{{{ if ./bookmark }}}/{./bookmark}{{{ end }}}">{./title}</a>
				{{{ end }}}
			</h3>

			<span component="topic/labels" class="d-flex flex-wrap gap-1 {{{ if (!./scheduled && (!./pinned && (!./locked && (!./oldCid && !./icons.length)))) }}}hidden{{{ end }}}">
				<span component="topic/scheduled" class="badge border border-gray-300 text-primary {{{ if !./scheduled }}}hidden{{{ end }}}">
					<i class="fa fa-clock-o"></i>
					[[topic:scheduled]]
				</span>
				<span component="topic/pinned" class="badge border border-gray-300 text-primary {{{ if (./scheduled || !./pinned) }}}hidden{{{ end }}}">
					<i class="fa fa-thumb-tack"></i>
					{{{ if !./pinExpiry }}}[[topic:pinned]]{{{ else }}}[[topic:pinned-with-expiry, {./pinExpiryISO}]]{{{ end }}}
				</span>
				<span component="topic/locked" class="badge border border-gray-300 text-primary {{{ if !./locked }}}hidden{{{ end }}}">
					<i class="fa fa-lock"></i>
					[[topic:locked]]
				</span>
				<span class="badge border border-gray-300 text-primary {{{ if !./oldCid }}}hidden{{{ end }}}">
					<i class="fa fa-arrow-circle-right"></i>
					[[topic:moved]]
				</span>
				{{{each ./icons}}}<span class="lh-1">{@value}</span>{{{end}}}
			</span>
			{{{ if !template.category }}}
			<a class="lh-1" href="{config.relative_path}/category/{./category.slug}">{function.buildCategoryLabel, ./category, "border"}</a>
			{{{ end }}}
			{{{ if ./tags.length }}}
			<span class="lh-1 tag-list hidden-xs d-flex flex-wrap gap-1">
				{{{ each ./tags }}}
				<a href="{config.relative_path}/tags/{./valueEncoded}"><span class="badge border border-gray-300 text-xs text-muted fw-normal tag tag-class-{./class}" data-tag="{./value}">{./valueEscaped}</span></a>
				{{{ end }}}
			</span>
			{{{ end }}}
			<span class="hidden-xs badge bg-transparent text-muted text-xs fw-normal timeago" title="{./timestampISO}"></span>
			<!-- <span class="hidden-xs text-xs timeago text-muted" title="{./timestampISO}"></span> -->
		</div>

		<div class="d-flex col-lg-5 gap-3 align-content-stretch">
			<div class="meta stats d-none d-lg-grid col-6 gap-1 text-muted" style="grid-template-columns: 1fr 1fr 1fr;">
				{{{ if !reputation:disabled }}}
				<div class="stats-votes card card-header border-0 px-0 py-2 rounded-1 d-flex flex-row flex-nowrap flex-lg-column gap-1 gap-lg-0 align-items-center" style="min-width:min-content">
					<span class="human-readable-number fs-5 ff-secondary lh-1" title="{./votes}" data-toFixed="0">{./votes}</span>
					<span class="text-lowercase text-xs">[[global:votes]]</span>
				</div>
				{{{ end }}}
				<div class="stats-postcount card card-header border-0 px-0 py-2 rounded-1 d-flex flex-row flex-nowrap flex-lg-column gap-1 gap-lg-0 align-items-center" style="min-width:min-content">
					<span class="human-readable-number fs-5 ff-secondary lh-1" title="{./postcount}" data-toFixed="0">{./postcount}</span>
					<span class="text-lowercase text-xs">[[global:posts]]</span>
				</div>
				<div class="stats-viewcount card card-header border-0 px-0 py-2 rounded-1 d-flex flex-row flex-nowrap flex-lg-column gap-1 gap-lg-0 align-items-center" style="min-width:min-content">
					<span class="human-readable-number fs-5 ff-secondary lh-1" title="{./viewcount}" data-toFixed="0">{./viewcount}</span>
					<span class="text-lowercase text-xs">[[global:views]]</span>
				</div>
			</div>
			<div component="topic/teaser" class="meta teaser col-lg-6">
				<div class="lastpost background-link-container border-start border-2 lh-sm h-100" style="border-color: {./category.bgColor}!important;">
					<a class="background-link" href="{config.relative_path}/topic/{./slug}/{./teaser.index}"></a>
					{{{ if ./unreplied }}}
					<div class="ps-2 text-xs">
						[[category:no_replies]]
					</div>
					{{{ else }}}
					{{{ if ./teaser.pid }}}
					<div class="ps-2">
						<a href="{config.relative_path}/user/{./teaser.user.userslug}" class="text-decoration-none">{buildAvatar(./teaser.user, "18px", true, "avatar-tooltip not-responsive")}</a>
						<a class="permalink text-muted timeago text-xs" href="{config.relative_path}/topic/{./slug}/{./teaser.index}" title="{./teaser.timestampISO}">
						</a>
					</div>
					<div class="post-content text-xs ps-2 line-clamp-2 lh-sm">
						{./teaser.content}
					</div>
					{{{ end }}}
					{{{ end }}}
				</div>
			</div>
		</div>

		{{{ if showSelect }}}
		<div class="checkbox position-absolute top-0 end-0">
			<i component="topic/select" class="fa fa-square-o text-muted pointer"></i>
		</div>
		{{{ end }}}
	</li>
	{{{end}}}

</ul>
