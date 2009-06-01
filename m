Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 12:57:47 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.147]:3487 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025120AbZFAL5N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 12:57:13 +0100
Received: by ey-out-1920.google.com with SMTP id 4so386372eyg.54
        for <multiple recipients>; Mon, 01 Jun 2009 04:57:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9jO9s7URUGIRtgsaw4G+EAosg5/XL2zy+XcCCVlhtpI=;
        b=xqUzi7yOA7ybpk9o9OeKMxB9PvxxgQmTO61BwXxvShUWTq5UxegNQR0ua6Q2ltkXNJ
         YSiAhnAxR4UnrXuOYL0GTnDtAOybJ2BgpK/lP23W3Uk4kXxCsvrbcPd+0VgNDZH4d4lP
         qnoFzBIZA1uFHLnezAbeozkHWlhGQmKNTouqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=IDGWa0450o96NOM/9QnpH38usDfTS16RCctdMdFpPTkkzTa6sWGHIp+0UZhGmaHjSL
         jofYC8pNV52Mam9AD94y1CacsXM2JiQraHJZvpskc7AJo3QK0IdY9sQbhs3/yoxe7dxI
         j/rj3pi6c0vO7Rub6791327C66JwKAECI4xNU=
Received: by 10.210.16.10 with SMTP id 10mr3939926ebp.40.1243857432048;
        Mon, 01 Jun 2009 04:57:12 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm143118eyf.48.2009.06.01.04.57.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 04:57:11 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 1 Jun 2009 13:57:09 +0200
Subject: [PATCH 1/9] kernel: export sound/core/pcm_timer.c gcd implementation
MIME-Version: 1.0
X-UID:	173
X-Length: 2484
To:	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	akpm <akpm@linux-foundation.org>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906011357.09966.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch exports the gcd implementation from
sound/core/pcm_timer.c into include/linux/kernel.h.
AR7 uses it in its clock routines.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 883cd44..878a27a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -147,6 +147,22 @@ extern int _cond_resched(void);
 		(__x < 0) ? -__x : __x;		\
 	})
 
+/* Greatest common divisor */
+static inline unsigned long gcd(unsigned long a, unsigned long b)
+{
+        unsigned long r;
+        if (a < b) {
+                r = a;
+                a = b;
+                b = r;
+        }
+        while ((r = a % b) != 0) {
+                a = b;
+                b = r;
+        }
+        return b;
+}
+
 #ifdef CONFIG_PROVE_LOCKING
 void might_fault(void);
 #else
diff --git a/sound/core/pcm_timer.c b/sound/core/pcm_timer.c
index ca8068b..e9dbf62 100644
--- a/sound/core/pcm_timer.c
+++ b/sound/core/pcm_timer.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/time.h>
+#include <linux/kernel.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/timer.h>
@@ -28,22 +29,6 @@
  *  Timer functions
  */
 
-/* Greatest common divisor */
-static unsigned long gcd(unsigned long a, unsigned long b)
-{
-	unsigned long r;
-	if (a < b) {
-		r = a;
-		a = b;
-		b = r;
-	}
-	while ((r = a % b) != 0) {
-		a = b;
-		b = r;
-	}
-	return b;
-}
-
 void snd_pcm_timer_resolution_change(struct snd_pcm_substream *substream)
 {
 	unsigned long rate, mult, fsize, l, post;
