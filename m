Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 12:06:20 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:61169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990511AbdAPLGMsC0Fw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 12:06:12 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Ldhgp-1cu8Rf0VPP-00j197; Mon, 16 Jan 2017 12:05:20 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: mips: avoid potential uninitialized variable use
Date:   Mon, 16 Jan 2017 12:04:56 +0100
Message-Id: <20170116110517.3833976-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:gSTcDrULYkfgWkK4eDeH5TkGbMDsdZf9rPVP0AgdaN96LdtfS1/
 TrjA4Tma3fn+0YyHNpfpamix2Sd9UN6lYWrGuY/w5ycr35XLDbbyLjXWXW28jcIaiMvcc5c
 UquzR/1YbOsDKDsLFsLHpW37fsloWM832xYDy7MX8bfZp638UPcALzV/TAx3U8AH50D7AS0
 /bnxSDNMpNSlvDFZSL3Qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l/EKI0tLrDI=:SHghJuG5fiYRhfpkB436Gm
 51fYIdv4MpmGpTlNrrYfmfYu18pPDEWAr8jAyfBh9jPLUVxHx3lyWkUuYIL0vr4//lVH+/67r
 8ARTCXojMLu2pAjYvaK0alZd9c8nqU2Ub2i3YqDsOZWJap/kRb3j4+8M2fjRltp09NQpW3/C+
 WgnmxjNvCB0MKAZ19oC6gNVjL55eYjcsL3r1j78ElJ+kSgEr0/OnaGn75jgvTpX5mziVuzZcc
 AmDNNSSyDkNnovKq4aWSB5bP5P64/hvocWxO25U5tMxSjZk9tawtE+dxjR216+iwPQTkTSllx
 igKnN6gChVs5YnSZK2OcnGczqS6rC1yhc6oiuRIhOceD+van9IpH/xYKGdn2+mCMGLacnuId4
 x3RnG0MjxrPwA9KtSXBht19Ufd+T/F4XqU+n95vFbjFn+bKZ8OH+TDAFXQIw1YeWXyONJgH2a
 NKpyt4Jo40xcE9c4Q5Z2GZwEj9EMMo3cVN2QwDLBLmGJLpxQG2DeABcoqRlD5nU0oXPc/q0vg
 xEpx2WWRSaP2Fmp5UNDO4jM++2bohjy4aWnj9EjUIZFmzwOOdiyRqQjZDNFvrAVWIK9ttmzy0
 yeCnqQKWTywCCmRO1FoU5JjPI+sJI0crr+lKoLOMHgorflX9tZfRB7ZcVH3jOlQMio2TAzhAU
 A09wq3pxwR+QEntiO6ugyIx3zZQ3Nl/Fciv09FDz94dcsC3cXvz+/A35i17IVJzYFfEA=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

MIPS allmodconfig results in this warning:

sound/mips/hal2.c: In function 'hal2_gain_get':
sound/mips/hal2.c:224:35: error: 'r' may be used uninitialized in this function [-Werror=maybe-uninitialized]
sound/mips/hal2.c:223:35: error: 'l' may be used uninitialized in this function [-Werror=maybe-uninitialized]
sound/mips/hal2.c: In function 'hal2_gain_put':
sound/mips/hal2.c:260:13: error: 'new' may be used uninitialized in this function [-Werror=maybe-uninitialized]
sound/mips/hal2.c:260:13: error: 'old' may be used uninitialized in this function [-Werror=maybe-uninitialized]

It's easy enough to avoid by adding a 'default' clause to the switch
statements here. I assume that in practice no other case can happen,
but adding a default puts us on the safe side and shuts up the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/mips/hal2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index ede449f0b50d..0af4f7a9b3e7 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -219,6 +219,9 @@ static int hal2_gain_get(struct snd_kcontrol *kcontrol,
 		l = (tmp >> H2I_C2_L_GAIN_SHIFT) & 15;
 		r = (tmp >> H2I_C2_R_GAIN_SHIFT) & 15;
 		break;
+	default:
+		l = 0;
+		r = 0;
 	}
 	ucontrol->value.integer.value[0] = l;
 	ucontrol->value.integer.value[1] = r;
@@ -256,6 +259,9 @@ static int hal2_gain_put(struct snd_kcontrol *kcontrol,
 		new |= (r << H2I_C2_R_GAIN_SHIFT);
 		hal2_i_write32(hal2, H2I_ADC_C2, new);
 		break;
+	default:
+		new = 0;
+		old = 0;
 	}
 	return old != new;
 }
-- 
2.9.0
