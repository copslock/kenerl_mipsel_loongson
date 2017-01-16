Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 14:29:07 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:50182 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991129AbdAPN27K26Cv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 14:28:59 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MSYbs-1c1aXz2dr2-00RcUn; Mon, 16 Jan 2017 14:28:07 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ALSA: mips: avoid potential uninitialized variable use
Date:   Mon, 16 Jan 2017 14:27:57 +0100
Message-Id: <20170116132805.2207208-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:/CsUh4t6CBW015iU+KlVbqG1pljavBucwZ7asxq/yp58rZvCt0K
 m4HMiCjo2bSXwl3tNz+hbZna89lfStXE4aW1ItIadbVYjQg2ontaLrXXthlMw/pDVBfiV5C
 sY69Q6lMvwP8GUIPrekMcbkPwIB9V5TuOXRQrphBr2qXOtRz9YJg6vwPagDtQGPYhJbP1DY
 xQ2aTLS4RS3cawyoHzT9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:urySP5nxK1Y=:x1g5B5/PzwZp9qaNS9raF7
 7B08y+TXNuywUVXMuw1A0VLGwMMvVfI/90B+Mr3z5O5raBpZc2lkMcmY4vrT2jkzUTyaqYc0z
 rJCA+Aoz1rqEfrj3rk3WI4E5c+6yPkq/NfRJYNSovHhq5REtkS9xyT7pqFLG1VIBXEFfmiRf4
 U1N9YjEGbp1C1aU+XtGoY+62SK5G+PfzvNQsQw67pbYGEALMIPwJWUbRyg5AAycRCtxGVi5fL
 CK6h1K1n0BtJ/eSh5FrbUIplfFJSeZD6h2tMG/3zYGq71e4ApRbxSLjmocO0kRT9Ltknm7OMO
 jOZP7at7F9DLGgE9mgtYl4+1qt5ddcZ7xUgfvVHN980dgaL5eWRTcHbTITDsHuKaqYmTP5sNL
 CTJN495eu9ioKAjdHrRfXp0ksssTz7ko+vHqud96mjXRFRDeECq58huR40rGfi6kwXhdtmITc
 wfhsZ7mM++7M7tpXtlPgW6ofy0lrszcg1rqg8bVWS3H82I8QK3CGOXYrLeO6FqOLrr5/O/02x
 b7Uf6pklzkUe0LUMjOArwIfkLnF51S61YsLWO6brMhVMt6s02Xezzd3sp9lPlCeP8n5JIqGin
 XWnWfml1osGA/EivQ0C6JsbLz6qBgfwqzsrhHzozjm4ZYy3L4Sb0cq0Hky4EdZ/COmMl+Ub+2
 K5LgmAwGtUGeXEpZSWNDTATWEaBnyvgeAb3j8++1fIVH5j6aaD2dmVn3JPclIrqmXtU8=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56335
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

Returning an error for all unexpected cases shuts up the warning

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: actually send the correct patch, sorry for the mixup
v2: return an error instead trying to handle gracefully

 sound/mips/hal2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index ede449f0b50d..00fc9241d266 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -219,6 +219,8 @@ static int hal2_gain_get(struct snd_kcontrol *kcontrol,
 		l = (tmp >> H2I_C2_L_GAIN_SHIFT) & 15;
 		r = (tmp >> H2I_C2_R_GAIN_SHIFT) & 15;
 		break;
+	default:
+		return -EINVAL;
 	}
 	ucontrol->value.integer.value[0] = l;
 	ucontrol->value.integer.value[1] = r;
@@ -256,6 +258,8 @@ static int hal2_gain_put(struct snd_kcontrol *kcontrol,
 		new |= (r << H2I_C2_R_GAIN_SHIFT);
 		hal2_i_write32(hal2, H2I_ADC_C2, new);
 		break;
+	default:
+		return -EINVAL;
 	}
 	return old != new;
 }
-- 
2.9.0
