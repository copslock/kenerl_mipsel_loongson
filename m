Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Dec 2013 00:58:04 +0100 (CET)
Received: from mail-qc0-f177.google.com ([209.85.216.177]:53361 "EHLO
        mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816642Ab3LFX6Bi3Q8g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Dec 2013 00:58:01 +0100
Received: by mail-qc0-f177.google.com with SMTP id m20so1005986qcx.8
        for <multiple recipients>; Fri, 06 Dec 2013 15:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2fOiDOdaMOIy0MDOyENPIZkbWqx2GCD3UtXeiVsu+3k=;
        b=kemhFFWjX5myTaY2RZbctjUM3/BhfLEBIVTgdV+4jOEv5Z53nYdytjguXHtNzM5A4g
         ymhkUTG/np028lKG+/u4rTacor81e+DV77mUH9MFT61m09uTBHYR4HcfZS4L8RO9jMRM
         fEX8fRwTq9WNT+RFQLZMtLNnRR9WCOSiiSuCvwwoZpvv5BDLAs89fHvSVTg5nE4P2ySe
         yAgNh7TW/a21zyxu4LAQBdDV86XG+6omHBtCOgj7C7iDb9JYxcnzURdFDOQG7gbLg292
         lNykwH+pOwTLySOKV24nlJPEf4hzkr9dwSl3M6UxlBJQY5qsJwaVluK/+EC6ahxhVx/+
         WGMg==
X-Received: by 10.224.16.204 with SMTP id p12mr10023979qaa.26.1386374275422;
        Fri, 06 Dec 2013 15:57:55 -0800 (PST)
Received: from localhost.localdomain (cpe-74-71-31-84.nyc.res.rr.com. [74.71.31.84])
        by mx.google.com with ESMTPSA id n7sm900098qai.1.2013.12.06.15.57.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2013 15:57:55 -0800 (PST)
From:   Ilia Mirkin <imirkin@alum.mit.edu>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        Ilia Mirkin <imirkin@alum.mit.edu>
Subject: [PATCH] MIPS: BCM47XX: Fix some very confused types and data corruption
Date:   Fri,  6 Dec 2013 18:56:53 -0500
Message-Id: <1386374213-25765-1-git-send-email-imirkin@alum.mit.edu>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <ibmirkin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imirkin@alum.mit.edu
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Fix nvram_read_alpha2 copying too many bytes over the ssb_sprom
structure. Also fix the arguments of the read_macaddr, although the code
was technically not wrong before due to an extra dereference.

Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
---

I found this with coccinelle. Looking over the code, I'm pretty sure the below
patch was the original intent. Or it is I that may be very confused. But if
you have an argument like T foo[6], it's essentially equivalent to having an
agument of T *foo. I don't even know what &foo.x does when x is declared as
T[2]. Right now the memcpy is copying sizeof(val), which is char *val[2], and
while I'm not 100% sure how sizeof works in this situation, that will
translate to either sizeof(void*) or 2*sizeof(void*). I believe the intent was
to only copy 2 bytes, since that is the size of the alpha2 field.

The macaddress situation is similar, except that the argument actually gets
dereferenced, so it all works out. But I don't think that's necessary.

All that said, I haven't even build-tested this (no MIPS toolchain handy). But
hopefully this will make sense to someone.

 arch/mips/bcm47xx/sprom.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index ad03c93..a8b5408 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -135,7 +135,7 @@ static void nvram_read_leddc(const char *prefix, const char *name,
 }
 
 static void nvram_read_macaddr(const char *prefix, const char *name,
-			       u8 (*val)[6], bool fallback)
+			       u8 val[6], bool fallback)
 {
 	char buf[100];
 	int err;
@@ -144,11 +144,11 @@ static void nvram_read_macaddr(const char *prefix, const char *name,
 	if (err < 0)
 		return;
 
-	bcm47xx_nvram_parse_macaddr(buf, *val);
+	bcm47xx_nvram_parse_macaddr(buf, val);
 }
 
 static void nvram_read_alpha2(const char *prefix, const char *name,
-			     char (*val)[2], bool fallback)
+			     char val[2], bool fallback)
 {
 	char buf[10];
 	int err;
@@ -162,7 +162,7 @@ static void nvram_read_alpha2(const char *prefix, const char *name,
 		pr_warn("alpha2 is too long %s\n", buf);
 		return;
 	}
-	memcpy(val, buf, sizeof(val));
+	memcpy(val, buf, 2);
 }
 
 static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
@@ -180,7 +180,7 @@ static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
 		      fallback);
 	nvram_read_s8(prefix, NULL, "ag1", &sprom->antenna_gain.a1, 0,
 		      fallback);
-	nvram_read_alpha2(prefix, "ccode", &sprom->alpha2, fallback);
+	nvram_read_alpha2(prefix, "ccode", sprom->alpha2, fallback);
 }
 
 static void bcm47xx_fill_sprom_r12389(struct ssb_sprom *sprom,
@@ -633,20 +633,20 @@ static void bcm47xx_fill_sprom_path_r45(struct ssb_sprom *sprom,
 static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
 					const char *prefix, bool fallback)
 {
-	nvram_read_macaddr(prefix, "et0macaddr", &sprom->et0mac, fallback);
+	nvram_read_macaddr(prefix, "et0macaddr", sprom->et0mac, fallback);
 	nvram_read_u8(prefix, NULL, "et0mdcport", &sprom->et0mdcport, 0,
 		      fallback);
 	nvram_read_u8(prefix, NULL, "et0phyaddr", &sprom->et0phyaddr, 0,
 		      fallback);
 
-	nvram_read_macaddr(prefix, "et1macaddr", &sprom->et1mac, fallback);
+	nvram_read_macaddr(prefix, "et1macaddr", sprom->et1mac, fallback);
 	nvram_read_u8(prefix, NULL, "et1mdcport", &sprom->et1mdcport, 0,
 		      fallback);
 	nvram_read_u8(prefix, NULL, "et1phyaddr", &sprom->et1phyaddr, 0,
 		      fallback);
 
-	nvram_read_macaddr(prefix, "macaddr", &sprom->il0mac, fallback);
-	nvram_read_macaddr(prefix, "il0macaddr", &sprom->il0mac, fallback);
+	nvram_read_macaddr(prefix, "macaddr", sprom->il0mac, fallback);
+	nvram_read_macaddr(prefix, "il0macaddr", sprom->il0mac, fallback);
 }
 
 static void bcm47xx_fill_board_data(struct ssb_sprom *sprom, const char *prefix,
-- 
1.8.3.2
