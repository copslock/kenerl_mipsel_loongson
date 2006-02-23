Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 15:39:23 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:56384 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133762AbWBWPhk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 15:37:40 +0000
Received: from 192.168.1.104 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k1NFiUt16549
	for <linux-mips@linux-mips.org>; Thu, 23 Feb 2006 19:44:30 +0400
Subject: NEC VR5701 support
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-TrXcrVge0OF6kM7XvovN"
Organization: MontaVista
Date:	Thu, 23 Feb 2006 18:44:31 +0300
Message-Id: <1140709471.5741.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-TrXcrVge0OF6kM7XvovN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-TrXcrVge0OF6kM7XvovN
Content-Disposition: attachment; filename=pro_mips_nec_vr5701_sound_recording_fix.patch
Content-Type: text/x-patch; name=pro_mips_nec_vr5701_sound_recording_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Source: MontaVista Software, Inc. Igor Goryachev <igoryachev@ru.mvista.com>
MR: 16114
Type: Defect Fix
Disposition: needs submitting to linuxmips-embedded mailing list
Signed-off-by: Igor Goryachev <igoryachev@ru.mvista.com>
Description:
    Fixes bug with sound recording on NEC vr5701.

Index: linux-2.6.10/include/linux/lsppatchlevel.h
===================================================================
--- linux-2.6.10.orig/include/linux/lsppatchlevel.h
+++ linux-2.6.10/include/linux/lsppatchlevel.h
@@ -6,4 +6,4 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#define LSP_PATCH_LEVEL "10"
+#define LSP_PATCH_LEVEL "11"
Index: linux-2.6.10/mvl_patches/pro-0011.c
===================================================================
--- /dev/null
+++ linux-2.6.10/mvl_patches/pro-0011.c
@@ -0,0 +1,16 @@
+/*
+ * Author: MontaVista Software, Inc. <source@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/init.h>
+#include <linux/mvl_patch.h>
+
+static __init int regpatch(void)
+{
+        return mvl_register_patch(11);
+}
+module_init(regpatch);
Index: linux-2.6.10/sound/pci/vr5701/nec_vr5701_sg2.h
===================================================================
--- linux-2.6.10.orig/sound/pci/vr5701/nec_vr5701_sg2.h
+++ linux-2.6.10/sound/pci/vr5701/nec_vr5701_sg2.h
@@ -138,7 +138,7 @@ static snd_pcm_hardware_t snd_vr5701_pla
 /* hardware definition */
 static snd_pcm_hardware_t snd_vr5701_capture_hw = {
 	.info = (SNDRV_PCM_INFO_MMAP |
-                   SNDRV_PCM_INFO_INTERLEAVED |
+                   SNDRV_PCM_INFO_NONINTERLEAVED |
                    SNDRV_PCM_INFO_BLOCK_TRANSFER |
                    SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =          SNDRV_PCM_FMTBIT_S16_LE,

--=-TrXcrVge0OF6kM7XvovN--
