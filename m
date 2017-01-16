Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 14:27:06 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.133]:65199 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990508AbdAPN0snO-Yv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 14:26:48 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MVV8g-1bvY6r08YY-00Yl5t; Mon, 16 Jan 2017 14:25:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: mips: avoid potential uninitialized variable use
Date:   Mon, 16 Jan 2017 14:25:47 +0100
Message-Id: <20170116132557.2178801-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:5a/cIw+KczPQlzqJzmcg/USDlZXFsvO68/zSOrlnBP89INmJaP6
 AbZ4M5gj4v4Yb8GfjN3z9Y4eNpMK21HwBJNCgAxrDSbZb3O4QLhYdLfarHg6lNxs5rEW+lS
 wxAhDxjYp3yUj/ogRWK6SL9v+urFihASXLn4EnMQ76wOjV97+azRPAD9tuLkDs+3TSOI3vT
 qztUJhq5ngRkwIdDrRHjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y/RJH/ewfKo=:dyXNjNihEs8hn1xBJd05DI
 spy7uoSfxKbWZN3oKG/+vtWinIE5CINOPcaAtWUXKuWhQsqMQFYtehn6j1qJBTxmnBvh1x/0T
 mmzVUVREdF6jUb3bvx9Pbt863V9VoYnc6KFA6cSlOT8e9tXTCwd3CSVx/9jibL45wPt0yYVBJ
 cd9V2j8+ScfvopyiVwNH5MrUrx/bmptOslWAPCvjF2w23p38LOf4RP61bEVskbYXsAF8HEFSd
 vse6dOZwX6pKoGb3/pL97aPD/u17kH80h0dUTJ437Xt6Y6MvKGecM4LhC00304IOPWvudrF35
 +nvKkfLivlVZamDXBBSmVqoDgu66vj4jNmeLq8j/hCGbhdOs13YRFmKvo+E3TI3eZhytO5Ut/
 xIDXTo2y5Cu8KICce9WZfDlVJy86MjrvnoOEf++BKi50KVFruQz2RjQepKORdO7n51sFrmDj1
 nYqmUgCkeJ6LFjto7kiVzFGXtpH88JjkmDgRVRrgycQE2JPYTvFadFNNmr3orlS8N9bZynrET
 MGKpf5boPJEC/aoxV2EgMTBPMlE6fqy6siGsp4VXN30iMAS+2OU40uXJWMD4Jcxtbsik5b1fn
 4oI8Mq1XLHk7Ci2YqIHU3co7ahClcaARxkApL4vK04gO0BpP0jrLoX4wZUMCOclHgYefuYS7l
 LHleEjRvIqUJFJsf9/BNxUITVD7U3K8XL6G7AhdA30v1KACXNfr1ugvf4U49UC8/5dCM=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56334
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
v2: return an error instead trying to handle gracefully
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
