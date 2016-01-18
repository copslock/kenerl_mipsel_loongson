Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 20:40:49 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:59620 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011022AbcARTkqv0Y5e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 20:40:46 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0LsMfM-1aAPoe1MEq-011yN8; Mon, 18 Jan
 2016 20:40:00 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Michael Buesch <m@bues.ch>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH, RESEND^2] ssb: mark ssb_bus_register as __maybe_unused
Date:   Mon, 18 Jan 2016 20:39:56 +0100
Message-ID: <6063400.39vor3soEb@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
References: <8128014.DbbgBtKY3z@wuerfel> <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:kkbWlikd0sCkuCWvpWQywNx3u0Nrzm3v9Xcr/c4/b30FF5hcj68
 WZ6rCk7NDykJK7CkE5urUWj/iOW/RXQF6a5SiijRmbk8y5QL7Su7VAAw8QU8uIe3giNJPmo
 It1sCxvp68dQPdzpmmGV/5q2Afkr3uBxGvVtjOpakJdVMmoqXKNoOgAMjL4AB+Ef4w4Ok/+
 T8w+v01icE+LIiWEUCXuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3jVfO0goopA=:neg9Gac9hJ8k92pHpfvpaV
 FVlwJooDFl0Ud1Vn08Nw80fkXDxPdkNtcpU7vUQVB/FJXf6KqIwkIvKXPiNJcqKf7iTD5GDF2
 rxHj4m8tfH65CN1q7bqhxa4mxvCiOCM7vEZ2nDyOLO1vmejPB2leWRU9kbeOh7wzV2Ydkxiqq
 WXwph1pwJOcn5tWmfsmzyiWf6zfr4E9Htry2w12hfc+VtuLVH2Cb1vdP0QMoTNsmeSsZ9uaP3
 mQWlk8BLjt7cO2hFsIQsFxNeag6PKL3v4hk/mY7JDMO5RpFHOx/WO1zkccbpwPOJqlakyn6sT
 vUwtl3uy80Sv4ElLfJfgSsK/3S/osTH9NpD9yAkdWEaWBwa9ZyZcOsTgOmUBl+WBVJBowdYzs
 KIWT+Jc1p3fOZXZDgsgwtjjbv3Adxt1Nl9CEguiTHkTsTutInWMHbjgiaFGdCENu8hrfOX93A
 FsqIGTzlZTXTQWDyUVJPyA7GyMhsJtOdcfse7DAJjOoiYSw9W7NOb7Ps0Fj2l0oL3HOLqZll6
 bZTKOoDguReAUa02scmlmdV1BqKOzBY9P7CRj8GkckhNlb9xzS5LgONDUpNS/MJGj264Wn7sp
 dKfjB5iexKWc8m9pznFr7StWQSG/sOhlQ4X9yiGWotFIU024yUEg2y0WMJpXtoh1MPS7r25/7
 CXLPCEYG9tWBjGlp7XZX0o8k2nML4f61h7U8ACZ6at/rQH63pMd1rx8Hd/8/L0Hf2laKpVh2o
 8Ps3ysE1csftSt97
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51204
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

The SoC variant of the ssb code is now optional like the other
ones, which means we can build the framwork without any
front-end, but that results in a warning:

drivers/ssb/main.c:616:12: warning: 'ssb_bus_register' defined but not used [-Wunused-function]

This annotates the ssb_bus_register function as __maybe_unused to
shut up the warning. A configuration like this will not work on
any hardware of course, but we still want this to silently build
without warnings if the configuration is allowed in the first
place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 845da6e58e19 ("ssb: add Kconfig entry for compiling SoC related code")
Acked-by: Michael Buesch <m@bues.ch>
---
Resent to linux-wireless as requested

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index cde5ff7529eb..d1a750760cf3 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -613,9 +613,10 @@ out:
 	return err;
 }
 
-static int ssb_bus_register(struct ssb_bus *bus,
-			    ssb_invariants_func_t get_invariants,
-			    unsigned long baseaddr)
+static int __maybe_unused
+ssb_bus_register(struct ssb_bus *bus,
+		 ssb_invariants_func_t get_invariants,
+		 unsigned long baseaddr)
 {
 	int err;
 
