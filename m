Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 15:15:52 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:63799 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022682AbZFDOPt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 15:15:49 +0100
Received: by mail-fx0-f223.google.com with SMTP id 23so815046fxm.0
        for <multiple recipients>; Thu, 04 Jun 2009 07:15:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NiMw1omyI95B5he9icaSelXG6iwYpO4gNp9MX35sx8I=;
        b=iSPgbX2xwDldRtetGhr785qM4oydSW4YWZgapOYtdXuGMw5In4h6l3JFOFwM9iCuWw
         ZrzN3NdBjxtHqvK0DMc5GR1CWzMg6+GL6yUm9MHlSeL91ki7YauM0Ifg87l8T0Q6xoHF
         7Y/lDZW72Rh2hUnqyCue+YmwkU4P5nqJ7aOTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=kjKGy03lbNmpwYaH6oCKpYze00Llrw6ZMgplguYuVOGS6nAokikmJTqOKdEiGtZu1p
         1f5p+woszKGMWFyEuRdfXpW0gDGm1hefPT0yZ/4kKG2te7AKXDewEQZNPmi2YZ+aMLgj
         K5kQU3GN7gQU9oEhBjwN1LmwFngb8CnMHHQ94=
Received: by 10.204.58.16 with SMTP id e16mr2077169bkh.43.1244124949044;
        Thu, 04 Jun 2009 07:15:49 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id d13sm11706695fka.2.2009.06.04.07.15.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 07:15:48 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 4 Jun 2009 16:15:46 +0200
Subject: [PATCH 2/8] sound/core/pcm_timer.c: use lib/gcd.c
MIME-Version: 1.0
X-UID:	233
X-Length: 1920
To:	"Linux-MIPS" <linux-mips@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Takashi Iwai <tiwai@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906041615.46679.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes sound/core/pcm_timer.c use lib/gcd.c

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 7bbdda0..0ae2485 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -5,6 +5,7 @@ config SND_TIMER
 config SND_PCM
 	tristate
 	select SND_TIMER
+	select GCD
 
 config SND_HWDEP
 	tristate
diff --git a/sound/core/pcm_timer.c b/sound/core/pcm_timer.c
index ca8068b..b01d948 100644
--- a/sound/core/pcm_timer.c
+++ b/sound/core/pcm_timer.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/time.h>
+#include <linux/gcd.h>
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
