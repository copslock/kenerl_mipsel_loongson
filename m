Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Oct 2005 01:05:29 +0100 (BST)
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62729 "HELO
	mailout.stusta.mhn.de") by ftp.linux-mips.org with SMTP
	id S8133697AbVJ3AFJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 30 Oct 2005 01:05:09 +0100
Received: (qmail 10032 invoked from network); 30 Oct 2005 00:05:26 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailout.stusta.mhn.de with SMTP; 30 Oct 2005 00:05:26 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id A9F9B1CE6CD; Sun, 30 Oct 2005 02:05:26 +0200 (CEST)
Date:	Sun, 30 Oct 2005 02:05:26 +0200
From:	Adrian Bunk <bunk@stusta.de>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] OSS MIPS drivers: "extern inline" -> "static inline"
Message-ID: <20051030000526.GP4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/oss/au1000.c      |    6 +++---
 sound/oss/nec_vrc5477.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.14-rc5-mm1-full/sound/oss/au1000.c.old	2005-10-30 02:03:31.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/sound/oss/au1000.c	2005-10-30 02:03:38.000000000 +0200
@@ -563,7 +563,7 @@
 #define DMABUF_DEFAULTORDER (17-PAGE_SHIFT)
 #define DMABUF_MINORDER 1
 
-extern inline void dealloc_dmabuf(struct au1000_state *s, struct dmabuf *db)
+static inline void dealloc_dmabuf(struct au1000_state *s, struct dmabuf *db)
 {
 	struct page    *page, *pend;
 
@@ -667,14 +667,14 @@
 	return 0;
 }
 
-extern inline int prog_dmabuf_adc(struct au1000_state *s)
+static inline int prog_dmabuf_adc(struct au1000_state *s)
 {
 	stop_adc(s);
 	return prog_dmabuf(s, &s->dma_adc);
 
 }
 
-extern inline int prog_dmabuf_dac(struct au1000_state *s)
+static inline int prog_dmabuf_dac(struct au1000_state *s)
 {
 	stop_dac(s);
 	return prog_dmabuf(s, &s->dma_dac);
--- linux-2.6.14-rc5-mm1-full/sound/oss/nec_vrc5477.c.old	2005-10-30 02:03:46.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/sound/oss/nec_vrc5477.c	2005-10-30 02:03:56.000000000 +0200
@@ -435,7 +435,7 @@
 
 /* --------------------------------------------------------------------- */
 
-extern inline void
+static inline void
 stop_dac(struct vrc5477_ac97_state *s)
 {
 	struct dmabuf* db = &s->dma_dac;
@@ -553,7 +553,7 @@
 	spin_unlock_irqrestore(&s->lock, flags);
 }	
 
-extern inline void stop_adc(struct vrc5477_ac97_state *s)
+static inline void stop_adc(struct vrc5477_ac97_state *s)
 {
 	struct dmabuf* db = &s->dma_adc;
 	unsigned long flags;
@@ -652,7 +652,7 @@
 #define DMABUF_DEFAULTORDER (16-PAGE_SHIFT)
 #define DMABUF_MINORDER 1
 
-extern inline void dealloc_dmabuf(struct vrc5477_ac97_state *s,
+static inline void dealloc_dmabuf(struct vrc5477_ac97_state *s,
 				  struct dmabuf *db)
 {
 	if (db->lbuf) {
