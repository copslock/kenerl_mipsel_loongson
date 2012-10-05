Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2012 15:32:28 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:61823 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870329Ab2JEN1E4B6KH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Oct 2012 15:27:04 +0200
Received: by mail-pb0-f49.google.com with SMTP id xa7so1955044pbc.36
        for <multiple recipients>; Fri, 05 Oct 2012 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=OVsKZwWCsd398VgY5q+JNe+eC7nUSF2uqx8VA7L3QpQ=;
        b=ZDuiBFxeAve67b1LJtmkpgrK6M1jBRd8yH00GxpIq9EDwDpwo/fBT44N5sS66gIQEi
         pIodMmZEeidC0rWJyIi56Q4FhkPheAAK1xk8iBO1kfRUI65BNjTr8YeCLr4EbJzMT2Fk
         Wa9gMzduAwgyZm8cDg6tgDtDV6vWrpQVqk5tRmWSZd6jOcM01rzqKF8bIIGJZ5KnF/69
         2rzT4oEgiLe6d8Jg63H3EVTCBKp88y2Xhap+x94y8DL1EBTAxgd7ZjEcxEH93x50FsvX
         +KFJ0LYynjYEYgTmvRziXD5BsiXb9o3TZTg1k4L3TT1LKtIcowACofZmdvhOSkTm1Mmq
         qijg==
Received: by 10.68.222.42 with SMTP id qj10mr30825600pbc.117.1349443624002;
        Fri, 05 Oct 2012 06:27:04 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id op7sm270211pbc.52.2012.10.05.06.26.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 06:27:03 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, Jie Chen <chenj@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH V7 12/15] ALSA: HDA: Make hda sound card usable for Loongson
Date:   Fri,  5 Oct 2012 21:25:09 +0800
Message-Id: <1349443512-18340-13-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1349443512-18340-1-git-send-email-chenhc@lemote.com>
References: <1349443512-18340-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34626
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
