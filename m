Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Aug 2012 11:39:04 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64558 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903784Ab2HKJeI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Aug 2012 11:34:08 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq8so2856154pbb.36
        for <multiple recipients>; Sat, 11 Aug 2012 02:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ObtzesAjAdwzQ52MbNwCBBfrKRjdHbig38Fqb8JUtvo=;
        b=Q3gaKKXyIIFzAFSy/cENOubDGGZSyG/BpLdcyUlcHsUPZHMPvPlpbBhwD7BUWqJexI
         tX6GZkbOw+3NEUaIdQqrzisU25xM5XJeqmW8nI/rjfbqGnfDjKkh7hhSeKfgaC2jYSwV
         ksmfNBCphvdijr3m8SHnZT27XPKO3ciBjjH0N7/T0SNp62vvVIEZqxplbp/5MEVOJhMk
         HgGQb5Xr06P8mNVckB9f/Y8P39XCXLsdgTB6AmkrmgCy6GgCuAmvmrURdXZNAQLxVE64
         A/WnZwVe4RF8n/Fl0IwWHS+IGM0vTalIFPtFPcz79CvkXD6qaagWZHDtBziru3MMrAyG
         y3og==
Received: by 10.68.221.3 with SMTP id qa3mr19507172pbc.42.1344677647302;
        Sat, 11 Aug 2012 02:34:07 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nu5sm1079954pbb.53.2012.08.11.02.34.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Aug 2012 02:34:06 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, Jie Chen <chenj@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH V5 14/18] ALSA: HDA: Make hda sound card usable for Loongson.
Date:   Sat, 11 Aug 2012 17:32:19 +0800
Message-Id: <1344677543-22591-15-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Signed-off-by: Jie Chen <chenj@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Cc: alsa-devel@alsa-project.org
---
 include/linux/pci_ids.h        |    2 ++
 sound/pci/hda/patch_conexant.c |   24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index fc35260..b28270e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2918,3 +2918,5 @@
 #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
+
+#define PCI_VENDOR_ID_LEMOTE		0x1c06
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 1436118..b7de368 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -4414,6 +4414,8 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 enum {
 	CXT_PINCFG_LENOVO_X200,
 	CXT_PINCFG_LENOVO_TP410,
+	CXT_PINCFG_LEMOTE_A1004,
+	CXT_PINCFG_LEMOTE_A1205,
 	CXT_FIXUP_STEREO_DMIC,
 };
 
@@ -4441,6 +4443,18 @@ static const struct hda_pintbl cxt_pincfg_lenovo_tp410[] = {
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
@@ -4450,6 +4464,14 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_lenovo_tp410,
 	},
+	[CXT_PINCFG_LEMOTE_A1004] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cxt_pincfg_lemote,
+	},
+	[CXT_PINCFG_LEMOTE_A1205] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cxt_pincfg_lemote,
+	},
 	[CXT_FIXUP_STEREO_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_stereo_dmic,
@@ -4467,6 +4489,8 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x215f, "Lenovo T510", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21ce, "Lenovo T420", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21cf, "Lenovo T520", CXT_PINCFG_LENOVO_TP410),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_LEMOTE, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_LEMOTE, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
 	{}
-- 
1.7.7.3
