Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 10:48:56 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:52501 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903636Ab2HQIoy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 10:44:54 +0200
Received: by mail-pz0-f49.google.com with SMTP id q27so797087daj.36
        for <multiple recipients>; Fri, 17 Aug 2012 01:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=OVsKZwWCsd398VgY5q+JNe+eC7nUSF2uqx8VA7L3QpQ=;
        b=rFUHrwHge3RsIR6amYNpdSS/Bwkbqrmti1Do7qLKLregmABxq6FntRVJj7az+SUNaK
         1OFcaE2EhYGBc/0k7E4Zv3sLHnzBrkcuSivbajc+xPzwGQLUulzgvG6Nvs8OShaJpTi1
         pW5Ex2/gCWiT7iDVdDSIy1PQjGcqw1pWp2Wo7a9lhFG5cuOgRFFtYhQCS0kCmP0AlX65
         zsQkEqvm9vJ/kJIwokbDox0ltbA08dnTrO4CN9dF+sDf0PhxnRJKb/rcRmHz1zN/DejP
         CWcnF7Qz2u6oS2wZhjJz/w5vDqTFVw1NJd7T47dgbZ2sNX97Bz0pxWfZeQEkrbRWibYm
         97sA==
Received: by 10.66.78.99 with SMTP id a3mr8046033pax.22.1345193093504;
        Fri, 17 Aug 2012 01:44:53 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id sz3sm4503572pbc.21.2012.08.17.01.44.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 01:44:52 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, Jie Chen <chenj@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH V6 12/15] ALSA: HDA: Make hda sound card usable for Loongson
Date:   Fri, 17 Aug 2012 16:43:32 +0800
Message-Id: <1345193015-3024-13-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1345193015-3024-1-git-send-email-chenhc@lemote.com>
References: <1345193015-3024-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Lemote A1004(Laptop) and A1205(All-In-One) use Conexant's hda codec,
this patch modify patch_conexant.c to add Lemote specific code.

Both A1004 and A1205 use the same pin configurations, but A1004 need
to increase the default boost of internal mic.

Signed-off-by: Jie Chen <chenj@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Cc: alsa-devel@alsa-project.org
---
 sound/pci/hda/patch_conexant.c |   44 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5e22a8f..3cc265e 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -4408,7 +4408,10 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 enum {
 	CXT_PINCFG_LENOVO_X200,
 	CXT_PINCFG_LENOVO_TP410,
+	CXT_PINCFG_LEMOTE_A1004,
+	CXT_PINCFG_LEMOTE_A1205,
 	CXT_FIXUP_STEREO_DMIC,
+	CXT_FIXUP_INC_MIC_BOOST,
 };
 
 static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
@@ -4418,6 +4421,19 @@ static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
 	spec->fixup_stereo_dmic = 1;
 }
 
+static void cxt5066_increase_mic_boost(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	snd_hda_override_amp_caps(codec, 0x17, HDA_OUTPUT,
+				  (0x3 << AC_AMPCAP_OFFSET_SHIFT) |
+				  (0x4 << AC_AMPCAP_NUM_STEPS_SHIFT) |
+				  (0x27 << AC_AMPCAP_STEP_SIZE_SHIFT) |
+				  (0 << AC_AMPCAP_MUTE_SHIFT));
+}
+
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
 	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
@@ -4435,6 +4451,18 @@ static const struct hda_pintbl cxt_pincfg_lenovo_tp410[] = {
 	{}
 };
 
+/* Lemote A1004/A1205 with cxt5066 */
+static const struct hda_pintbl cxt_pincfg_lemote[] = {
+	{ 0x1a, 0x90a10020 }, /* Internal mic */
+	{ 0x1b, 0x03a11020 }, /* External mic */
+	{ 0x1d, 0x400101f0 }, /* Not used */
+	{ 0x1e, 0x40a701f0 }, /* Not used */
+	{ 0x20, 0x404501f0 }, /* Not used */
+	{ 0x22, 0x404401f0 }, /* Not used */
+	{ 0x23, 0x40a701f0 }, /* Not used */
+	{}
+};
+
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -4444,10 +4472,24 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_lenovo_tp410,
 	},
+	[CXT_PINCFG_LEMOTE_A1004] = {
+		.type = HDA_FIXUP_PINS,
+		.chained = true,
+		.chain_id = CXT_FIXUP_INC_MIC_BOOST,
+		.v.pins = cxt_pincfg_lemote,
+	},
+	[CXT_PINCFG_LEMOTE_A1205] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cxt_pincfg_lemote,
+	},
 	[CXT_FIXUP_STEREO_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_stereo_dmic,
 	},
+	[CXT_FIXUP_INC_MIC_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt5066_increase_mic_boost,
+	},
 };
 
 static const struct snd_pci_quirk cxt5051_fixups[] = {
@@ -4463,6 +4505,8 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21cf, "Lenovo T520", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
+	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
 	{}
 };
 
-- 
1.7.7.3
