<?xml version="1.0" encoding="utf-8"?>
<!-- 声明XSL版本和命名空间，atom命名空间必须和Atom XML一致 -->
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:atom="http://www.w3.org/2005/Atom">
  <!-- 输出为HTML，编码UTF-8，开启缩进 -->
  <xsl:output method="html" version="4.01" encoding="utf-8" indent="yes"/>

  <!-- 匹配XML根节点，开始渲染HTML -->
  <xsl:template match="/">
  <html>
  <head>
    <!-- 标题使用RSS源的标题 -->
    <title><xsl:value-of select="atom:feed/atom:title"/> - RSS订阅</title>
    <!-- 样式优化：适配移动端+更美观的排版 -->
    <style>
      * { margin: 0; padding: 0; box-sizing: border-box; }
      body { 
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; 
        max-width: 850px; 
        margin: 0 auto; 
        padding: 2rem 1rem; 
        color: #333; 
        line-height: 1.6; 
        background-color: #f9f9f9;
      }
      h1 { 
        color: #222; 
        margin-bottom: 1.5rem; 
        padding-bottom: 0.5rem; 
        border-bottom: 2px solid #eee;
      }
      .feed-meta { 
        color: #666; 
        margin-bottom: 2rem; 
        font-size: 0.95rem;
      }
      .feed-meta a { color: #0078d7; text-decoration: none; }
      .entry { 
        margin: 2rem 0; 
        padding: 1.5rem; 
        border-radius: 8px; 
        background-color: #fff; 
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
      }
      .entry-title { 
        font-size: 1.3rem; 
        font-weight: 600; 
        margin-bottom: 0.8rem;
      }
      .entry-title a { 
        color: #0078d7; 
        text-decoration: none; 
        transition: color 0.2s;
      }
      .entry-title a:hover { color: #005a9e; }
      .entry-meta { 
        color: #666; 
        font-size: 0.9rem; 
        margin-bottom: 1rem; 
        display: flex; 
        gap: 1.5rem;
      }
      .entry-summary { 
        color: #444; 
        font-size: 1rem; 
        line-height: 1.7;
      }
      .entry-summary p { margin-bottom: 0.5rem; }
      /* 适配移动端 */
      @media (max-width: 600px) {
        .entry-meta { flex-direction: column; gap: 0.5rem; }
        .entry { padding: 1rem; }
      }
    </style>
  </head>
  <body>
    <!-- 显示博客标题 -->
    <h1><xsl:value-of select="atom:feed/atom:title"/></h1>
    <!-- 显示博客作者+RSS源地址 -->
    <div class="feed-meta">
      <p>作者：<xsl:value-of select="atom:feed/atom:author/atom:name"/></p>
      <p>RSS订阅地址：<a href="{atom:feed/atom:link/@href}"><xsl:value-of select="atom:feed/atom:link/@href"/></a></p>
    </div>
    <!-- 遍历所有文章条目 -->
    <xsl:for-each select="atom:feed/atom:entry">
    <div class="entry">
      <!-- 文章标题+链接 -->
      <div class="entry-title">
        <a href="{atom:link/@href}" target="_blank"><xsl:value-of select="atom:title"/></a>
      </div>
      <!-- 文章元信息：发布时间+更新时间 -->
      <div class="entry-meta">
        <span>发布于：<xsl:value-of select="substring(atom:published, 1, 10)"/></span>
        <span>更新于：<xsl:value-of select="substring(atom:updated, 1, 10)"/></span>
      </div>
      <!-- 文章摘要（保留HTML格式） -->
      <div class="entry-summary">
        <xsl:value-of select="atom:summary" disable-output-escaping="yes"/>
      </div>
    </div>
    </xsl:for-each>
  </body>
  </html>
  </xsl:template>
</xsl:stylesheet>