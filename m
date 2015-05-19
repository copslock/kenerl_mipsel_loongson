Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 23:15:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33633 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013082AbbESVPIOjACz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 23:15:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DC05E141A8C8E;
        Tue, 19 May 2015 22:15:00 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 19 May
 2015 22:14:02 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 19 May
 2015 22:14:02 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 19 May
 2015 14:13:59 -0700
Subject: [PATCH 2/2] MIPS: MSA: bugfix of keeping MSA live context through
 clone or fork
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <linux-mips@linux-mips.org>, <rusty@rustcorp.com.au>,
        <alexinbeijing@gmail.com>, <paul.burton@imgtec.com>,
        <david.daney@cavium.com>, <alex@alex-smith.me.uk>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <james.hogan@imgtec.com>, <markos.chandras@imgtec.com>,
        <macro@linux-mips.org>, <eunb.song@samsung.com>,
        <manuel.lauss@gmail.com>, <andreas.herrmann@caviumnetworks.com>
Date:   Tue, 19 May 2015 14:13:59 -0700
Message-ID: <20150519211359.35859.24907.stgit@ubuntu-yegoshin>
In-Reply-To: <20150519211222.35859.52798.stgit@ubuntu-yegoshin>
References: <20150519211222.35859.52798.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

It seems the patch 39148e94e3e1f0477ce8ed3fda00123722681f3a

    "MIPS: fork: Fix MSA/FPU/DSP context duplication race"

assumes that DSP/FPU and MSA context should be inherited in child at clone/fork
(look into patch description). It was done on Matthew Fortune request from
toolchain team, I guess.

Well, in this case it should prevent clearing TIF_MSA_CTX_LIVE in copy_thread().

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/kernel/process.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index f2975d4d1e44..a16e62d40210 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -163,7 +163,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	clear_tsk_thread_flag(p, TIF_USEDFPU);
 	clear_tsk_thread_flag(p, TIF_USEDMSA);
-	clear_tsk_thread_flag(p, TIF_MSA_CTX_LIVE);
 
 #ifdef CONFIG_MIPS_MT_FPAFF
 	clear_tsk_thread_flag(p, TIF_FPUBOUND);
