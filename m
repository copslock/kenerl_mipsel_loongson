Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2F6C43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 17:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7A720879
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 17:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfAJRXr (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:23:47 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:33261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfAJRXp (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 10 Jan 2019 12:23:45 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1McH1O-1hI4Fh1sui-00clIh; Thu, 10 Jan 2019 18:22:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 03/11] time: fix sys_timer_settime prototype
Date:   Thu, 10 Jan 2019 18:22:08 +0100
Message-Id: <20190110172216.313063-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110172216.313063-1-arnd@arndb.de>
References: <20190110172216.313063-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3gTXRESf+h45Wvylwj9vM5Tda294DtDs8hhcZWgW4vEmMf66/zd
 hIB9vsXzYxRm5RZp35Ogjn6bqTec1vMAcTvQChqgMUCCk4LwBUmbpf4G9T4QoD3ki9A93eN
 nfkWegpv6J8c56JtHNLVhMjiBjGBTG2VcPlkL8lswl45ryU3nIXdFJRuZofh+00SPluw7pB
 Irr3BMn+tj5jjtoJ7fqtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h0tMv83ysn0=:OM4Zv09Xf1B3x0L+/3KO6x
 e04xJJ8iYmGngbOe2nReDYpA4tuZKa+1MerLoy0MrDtVhYnyD/R/DMr1TkPbJ6MVZYzCMtGdB
 x7bWaPYwUDzBW9IX4QooXgWxFSxxCifR6bvcemt6R3g8D/lo3gIXvHZ7NDC8T4lPqBgEVjdUp
 5mGQaFc486H4LzdBb3XVHnulw6TJSiRZm/EioSczE9ZRUyq1LXpL1YntwKStPelMkgoMuCI9I
 4srTCsPoYSNv7a1rzmRy4uhSHNFk5chRt2w04GOQZD6wlRbcWLj7c+0bP9gUHanTiy6k9YYVs
 1I+/gzYw3VNVWqiEU24XGmAVbWGmwqtlSIAnoC1Uzx12MK1RH8CPJhHmsEwxGlHr2EDBVcWuF
 HA+tvdiMxGiCsRnQR9VosZmKFczCJkq3xjcwDml/j8ZBVr6w2njucIHM+295fIp7lbRl/WAIg
 K/p+CbxNOaOjEEZYTcqNj+RpZW7Xe5o2BHoytjTUArg/KIlH/akMbPD1TCvjAh886BP3gQafp
 OX/8TKrMiI6LTW36MfHGMgvRQgxpW4CD+u/lLyBO7uiqMAUESBtaexZkWM4G5UEkbNKOmO24Y
 wXIL/DizPMuoMLMgXzWWrD4iZQ5pbhZ2FmXV3zCbDrRzxpZqhXC63IEnezj/qWZJPybnBUCvy
 VqHVALmlPBbAQLNfc7h3Fv0mi/yW+8fKVxIxvQVSbRN9UL2cckfBt75dWyBM3v3K+yeOt8wD1
 p3EKZTw3ihTagDKn54jsKPyk76ZV1t86nHZnUg==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

A small typo has crept into the y2038 conversion of the timer_settime
system call. So far this was completely harmless, but once we start
using the new version, this has to be fixed.

Fixes: 6ff847350702 ("time: Change types to new y2038 safe __kernel_itimerspec")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 0296772e8fe5..8e86d9623d4e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -591,7 +591,7 @@ asmlinkage long sys_timer_gettime(timer_t timer_id,
 asmlinkage long sys_timer_getoverrun(timer_t timer_id);
 asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
 				const struct __kernel_itimerspec __user *new_setting,
-				struct itimerspec __user *old_setting);
+				struct __kernel_itimerspec __user *old_setting);
 asmlinkage long sys_timer_delete(timer_t timer_id);
 asmlinkage long sys_clock_settime(clockid_t which_clock,
 				const struct __kernel_timespec __user *tp);
-- 
2.20.0

