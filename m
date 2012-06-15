Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 10:15:58 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:61586 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901760Ab2FOINa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 10:13:30 +0200
Received: by pbbrq13 with SMTP id rq13so5189101pbb.36
        for <multiple recipients>; Fri, 15 Jun 2012 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4B/e6maDxIVT9SJ4fQJcTmMBBIKqpAcpe4vQJp3aLRw=;
        b=J6KEEkTNdWdx/PoPuU/GeflQtBOaCj5BPEQFwM07VIaL0Ab5tl9pGA9+/wECbBRbik
         acXIbwC1SnhSFNwr6pPvlashHkMfVTrri/giVwvaAzZYnVONxdkDT3viXruxLqwB90ZF
         dHU4cTPpCaBzwkwniG8UWAx4W7NqNnoMNYZ/9BHJ+J99AQ7cT1WWUurvosdWlv28KRcs
         nne0CymZV+hn4gG9Ktk35qS/daqQsmr6oCRVIVB1WeDA5ZX8r1F1T6Icaq5IahR8gEeX
         fKBi2AfAGUCH/Fbps3ui5jsu2C5GK48tfv45ipaC2ZkXQ0BOCY5LE54DTNRr4ckQAQSD
         X87w==
Received: by 10.68.131.10 with SMTP id oi10mr17134728pbb.122.1339748003822;
        Fri, 15 Jun 2012 01:13:23 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nh8sm12437247pbc.60.2012.06.15.01.13.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 01:13:22 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH 11/14] ALSA: Make hda sound card usable for Loongson.
Date:   Fri, 15 Jun 2012 16:09:58 +0800
Message-Id: <1339747801-28691-12-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33649
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
this patch make it usable:
1, Use 32bit DMA as a workaround.
2, Modify patch_conexant.c to add Lemote specific code.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 include/linux/pci_ids.h        |    2 +
 sound/pci/hda/hda_intel.c      |    5 ++++
 sound/pci/hda/patch_conexant.c |   52 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ab741b0..d8b0a52 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2906,3 +2906,5 @@
 #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
+
+#define PCI_VENDOR_ID_LEMOTE		0x1c06
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2b6392b..2b73ed4 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3013,6 +3013,11 @@ static int DELAYED_INIT_MARK azx_first_init(struct azx *chip)
 		gcap &= ~ICH6_GCAP_64OK;
 	}
 
+#ifdef CONFIG_CPU_LOONGSON3
+	/* Workaround: Loongson 3 doesn't support 64-bit DMA */
+	gcap &= ~ICH6_GCAP_64OK;
+#endif
+
 	/* disable buffer size rounding to 128-byte multiples if supported */
 	if (align_buffer_size >= 0)
 		chip->align_buffer_size = !!align_buffer_size;
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 3acb582..1c8dfb9 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -142,6 +142,7 @@ struct conexant_spec {
 	unsigned int thinkpad:1;
 	unsigned int hp_laptop:1;
 	unsigned int asus:1;
+	unsigned int lemote:1;
 	unsigned int pin_eapd_ctrls:1;
 	unsigned int fixup_stereo_dmic:1;
 
@@ -2278,7 +2279,7 @@ static void cxt5066_automic(struct hda_codec *codec)
 		cxt5066_thinkpad_automic(codec);
 	else if (spec->hp_laptop)
 		cxt5066_hp_laptop_automic(codec);
-	else if (spec->asus)
+	else if (spec->asus || spec->lemote)
 		cxt5066_asus_automic(codec);
 }
 
@@ -2911,6 +2912,32 @@ static const struct hda_verb cxt5066_init_verbs_hp_laptop[] = {
 	{ } /* end */
 };
 
+static struct hda_verb cxt5066_init_verbs_lemote[] = {
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x0}, /* ADC1: Connection index: 0 */
+	{0x19, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_MIC_EVENT},
+
+	/* DAC2: unused */
+	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+
+	/* ADC2, ADC3: unused */
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+
+	/* Disable digital microphone port */
+	{0x23, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+
+	/* Disable SPDIF */
+	{0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{ } /* end */
+};
+
 /* initialize jack-sensing, too */
 static int cxt5066_init(struct hda_codec *codec)
 {
@@ -2948,6 +2975,8 @@ enum {
 	CXT5066_THINKPAD,	/* Lenovo ThinkPad T410s, others? */
 	CXT5066_ASUS,		/* Asus K52JU, Lenovo G560 - Int mic at 0x1a and Ext mic at 0x1b */
 	CXT5066_HP_LAPTOP,      /* HP Laptop */
+	CXT5066_LEMOTE_A1004,   /* Lemote Laptop A1004 */
+	CXT5066_LEMOTE_A1205,   /* Lemote All-In-One A1205 */
 	CXT5066_AUTO,		/* BIOS auto-parser */
 	CXT5066_MODELS
 };
@@ -2961,6 +2990,8 @@ static const char * const cxt5066_models[CXT5066_MODELS] = {
 	[CXT5066_THINKPAD]	= "thinkpad",
 	[CXT5066_ASUS]		= "asus",
 	[CXT5066_HP_LAPTOP]	= "hp-laptop",
+	[CXT5066_LEMOTE_A1004]  = "lemote-laptop-a1004",
+	[CXT5066_LEMOTE_A1205]  = "lemote-aio-a1205",
 	[CXT5066_AUTO]		= "auto",
 };
 
@@ -2993,6 +3024,8 @@ static const struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo U350", CXT5066_ASUS),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G560", CXT5066_ASUS),
 	SND_PCI_QUIRK(0x17aa, 0x3938, "Lenovo G565", CXT5066_AUTO),
+	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT5066_LEMOTE_A1004),
+	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT5066_LEMOTE_A1205),
 	SND_PCI_QUIRK(0x1b0a, 0x2092, "CyberpowerPC Gamer Xplorer N57001", CXT5066_AUTO),
 	{}
 };
@@ -3073,7 +3106,22 @@ static int patch_cxt5066(struct hda_codec *codec)
 		spec->port_d_mode = 0;
 		spec->mic_boost = 3; /* default 30dB gain */
 		break;
-
+	case CXT5066_LEMOTE_A1004:
+	case CXT5066_LEMOTE_A1205:
+		codec->patch_ops.init = cxt5066_init;
+		codec->patch_ops.unsol_event = cxt5066_unsol_event;
+		spec->init_verbs[spec->num_init_verbs] =
+			cxt5066_init_verbs_lemote;
+		spec->num_init_verbs++;
+		spec->lemote = 1;
+		spec->mixers[spec->num_mixers++] = cxt5066_mixer_master;
+		spec->mixers[spec->num_mixers++] = cxt5066_mixers;
+		/* no S/PDIF out */
+		/* input source automatically selected */
+		spec->input_mux = NULL;
+		spec->port_d_mode = 0;
+		spec->mic_boost = 3; /* default 30dB gain */
+		break;
 	case CXT5066_OLPC_XO_1_5:
 		codec->patch_ops.init = cxt5066_olpc_init;
 		codec->patch_ops.unsol_event = cxt5066_olpc_unsol_event;
-- 
1.7.7.3
