Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2011 04:33:07 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:51939 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490968Ab1HRCdC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2011 04:33:02 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7I2Wp3j029483
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 17 Aug 2011 19:32:51 -0700 (PDT)
Received: from localhost (128.224.158.133) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Wed, 17 Aug
 2011 19:32:51 -0700
Date:   Thu, 18 Aug 2011 10:32:47 +0800
From:   Yong Zhang <yong.zhang@windriver.com>
To:     David Daney <david.daney@cavium.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: use 32-bit wrapper for compat_sys_futex
Message-ID: <20110818023247.GA3750@windriver.com>
Reply-To: Yong Zhang <yong.zhang@windriver.com>
References: <1313546094-11882-1-git-send-email-yong.zhang@windriver.com>
 <4E4BF7C0.80703@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4E4BF7C0.80703@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [128.224.158.133]
X-archive-position: 30890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12926

On Wed, Aug 17, 2011 at 10:17:52AM -0700, David Daney wrote:
> >diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> >index 46c4763..f48b18e 100644
> >--- a/arch/mips/kernel/scall64-o32.S
> >+++ b/arch/mips/kernel/scall64-o32.S
> >@@ -441,7 +441,7 @@ sys_call_table:
> >  	PTR	sys_fremovexattr		/* 4235 */
> >  	PTR	sys_tkill
> >  	PTR	sys_sendfile64
> >-	PTR	compat_sys_futex
> >+	PTR	sys_32_futex
> 
> This change is redundant, scall64-o32.S already does the right thing

My first virsion(not sent out) doesn't include scall64-o32.S either.

> so additional zero extending is not needed and is just extra
> instructions to execute for no reason.

Why I'm adding it here is for:
1)code consistent, otherwise we must move SYSCALL_DEFINE6(32_futex,...)
  under CONFIG_MIPS32_N32;
2)I'm afraid there may be some other way to touch the high 32-bit of a
  register, so touching scall64-o32.S is also for safety(due to unknown
  reason, fix me if I'm wrong).

Thanks,
Yong
