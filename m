Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 17:48:42 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64458 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022865AbXHVQsk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Aug 2007 17:48:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7MGmeW3001722
	for <linux-mips@linux-mips.org>; Wed, 22 Aug 2007 17:48:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7MGmeKl001721
	for linux-mips@linux-mips.org; Wed, 22 Aug 2007 17:48:40 +0100
Date:	Wed, 22 Aug 2007 17:48:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH] IP22 console font patch, testing needed.
Message-ID: <20070822164840.GA1648@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Could somebody please test this patch to sort out font handling for the
IP22 Newport console driver?  Thanks,

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 7fa1afe..a2cb77b 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/font.h>
 #include <linux/kd.h>
 #include <linux/selection.h>
 #include <linux/console.h>
@@ -33,7 +34,7 @@
 
 extern unsigned long sgi_gfxaddr;
 
-#define FONT_DATA ((unsigned char *)font_vga_8x16.data)
+static const struct font_desc *default_font;
 
 /* borrowed from fbcon.c */
 #define REFCOUNT(fd)	(((int *)(fd))[-1])
@@ -300,6 +301,10 @@ static const char *newport_startup(void)
 	if (!sgi_gfxaddr)
 		return NULL;
 
+	default_font = find_font("VGA8x16");
+	if (!default_font)
+		return NULL;
+
 	if (!npregs)
 		npregs = (struct newport_regs *)/* ioremap cannot fail */
 			ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
@@ -313,7 +318,7 @@ static const char *newport_startup(void)
 		goto out_unmap;
 
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
-		font_data[i] = FONT_DATA;
+		font_data[i] = (unsigned char *) default_font->data;
 
 	newport_reset();
 	newport_get_revisions();
@@ -522,7 +527,7 @@ static int newport_set_font(int unit, struct console_font *op)
 
 	/* check if font is already used by other console */
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
-		if (font_data[i] != FONT_DATA
+		if (font_data[i] != default_font->data
 		    && FNTSIZE(font_data[i]) == size
 		    && !memcmp(font_data[i], new_data, size)) {
 			kfree(new_data - FONT_EXTRA_WORDS * sizeof(int));
@@ -534,7 +539,7 @@ static int newport_set_font(int unit, struct console_font *op)
 		}
 	}
 	/* old font is user font */
-	if (font_data[unit] != FONT_DATA) {
+	if (font_data[unit] != default_font->data) {
 		if (--REFCOUNT(font_data[unit]) == 0)
 			kfree(font_data[unit] -
 			      FONT_EXTRA_WORDS * sizeof(int));
@@ -547,11 +552,11 @@ static int newport_set_font(int unit, struct console_font *op)
 
 static int newport_set_def_font(int unit, struct console_font *op)
 {
-	if (font_data[unit] != FONT_DATA) {
+	if (font_data[unit] != default_font->data) {
 		if (--REFCOUNT(font_data[unit]) == 0)
 			kfree(font_data[unit] -
 			      FONT_EXTRA_WORDS * sizeof(int));
-		font_data[unit] = FONT_DATA;
+		font_data[unit] = (unsigned char *) default_font->data;
 	}
 
 	return 0;
@@ -740,7 +745,7 @@ static int __init newport_console_init(void)
 {
 
 	if (!sgi_gfxaddr)
-		return NULL;
+		return 0;
 
 	if (!npregs)
 		npregs = (struct newport_regs *)/* ioremap cannot fail */
