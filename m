Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 00:13:54 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:60456 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010220AbcANXNw0IfOh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 00:13:52 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue002) with ESMTPSA (Nemesis) id 0LqInx-1ZggdK03If-00e2Sf; Fri, 15 Jan
 2016 00:13:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Michael Buesch <m@bues.ch>,
        netdev@vger.kernel.org
Subject: [PATCH, RESEND] ssb: mark ssb_bus_register as __maybe_unused
Date:   Fri, 15 Jan 2016 00:13 +0100
Message-ID: <4037550.DMaVTE01Aq@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
References: <8128014.DbbgBtKY3z@wuerfel> <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:O5X5MmEB3YAo/M0wdSx9OGVPs/bQnMWMKdj2hn/sQqVJAC4T+xq
 MnRmUG9s8Q98ufdbf/fsQAwGhRsUSk6zWmDkliRlO5g8Qn9YcstzqfD/oCGOLi5I2MbsZsw
 uFvbhYgIP+NJ8FLjfbgReHcTGh076rpNVPCMy5zqE/3qIezugtiz0TbPHO/Vzzq5KaRTUv3
 fjFd+dlI43PKWzdN1eDkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CCh0uex/jiM=:FOjYRKn0/ZGy3Jw22VPgs4
 ajvG2nnaKjU5OTmU9hGzi2NGg8riJpMQHWPYNfejIbp+/7c810WKkc50lr90YAy7nDj/ceD0R
 VB+Tt33ATDxjf0lzuD2r52ljCyhY6WHaBL+o1dObag6hwON7VcCt/gFjDIFaz55Sydkrl/VoN
 TSee23At6PzvMb96kv4Z/D2VXQpoTT1p15SchPEKyhTRwSiyiA3urcv9GD8YmEbGtRlBbGwSp
 n2EyUNkoxBmd7BJhTzwKPtePF3SR3Fx8HRle+LDgyWgkQ+Hz4B9rBd/CACyWTh33lXxqfEkIJ
 DFrZAwf/dUigBAJroFo1CYiUYTGu+7+HKhOdYMSVXaVCwYtSMFSds1rmnC7oG3bFdLK9EKKL2
 +jQV3jsafQM2Cvu0E0OJ0wG1rGI7ts8WZV5ssYoEGAamew5fcHRIanTbWH+6M+uTKCcHbN1Ky
 Xyhm+1Ym1lA0KfNvHSap26y6tStBsavzMdIUgwpqfzrqPGvqJMQy0TGiP71GT80XUSdnVz+KO
 kzav0CZTYOSMsjmdOBy+nNfAPkUjrEAQYnn4rZIR0LUOb7+JESO0YXhTUFwIXm8Cjvor5X4FW
 3kw9FIZSYlHjnbULOPcmPiwMD+Uwe6gUHOJkXtgd0CbiHWjiryTb9mMattUvyXwtmdf3gHfvS
 qGTboPfyE8cmkIz26Rngj3WoMgzI7y0GrbyfQ7Ku9w8nY6Y9H5MBuuekepJcdanHo9LJH6lx+
 WZfqr/bKy9kpS3fw
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51143
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

On Thursday 14 January 2016 08:46:29 Kalle Valo wrote:
> I can take it. For historical reasons ssb patches go through my
> wireless-drivers trees.

I found this in my backlog, and I believe it still applies. Can you take
that one too?

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
 
