Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 21:06:10 +0200 (CEST)
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:41401 "EHLO
        ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492342Ab0FQTGG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 21:06:06 +0200
Received: from c83-249-211-213.bredband.comhem.se ([83.249.211.213]:43549 helo=honor.jni.nu)
        by ch-smtp03.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.68)
        (envelope-from <jesper@jni.nu>)
        id 1OPKOc-0006Gb-Cb; Thu, 17 Jun 2010 21:05:04 +0200
Received: from honor.jni.nu (localhost [127.0.0.1])
        by honor.jni.nu (8.14.1/8.14.1) with ESMTP id o5HJ50Jc027174;
        Thu, 17 Jun 2010 21:05:00 +0200
Received: (from jesper@localhost)
        by honor.jni.nu (8.14.1/8.13.8/Submit) id o5HJ4uY8027173;
        Thu, 17 Jun 2010 21:04:56 +0200
Date:   Thu, 17 Jun 2010 21:04:56 +0200
From:   Jesper Nilsson <jesper@jni.nu>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: MIPS: return after handling coprocessor 2 exception
Message-ID: <20100617190456.GC24162@jni.nu>
References: <20100617132554.GB24162@jni.nu> <4C1A57AE.9080706@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C1A57AE.9080706@caviumnetworks.com>
User-Agent: Mutt/1.4.2.3i
X-Originating-IP: 83.249.211.213
X-Scan-Result: No virus found in message 1OPKOc-0006Gb-Cb.
X-Scan-Signature: ch-smtp03.sth.basefarm.net 1OPKOc-0006Gb-Cb 09b7bac309e92e6f7a3833d0165c7858
X-archive-position: 27162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper@jni.nu
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12299

On Thu, Jun 17, 2010 at 10:13:18AM -0700, David Daney wrote:
> On 06/17/2010 06:25 AM, Jesper Nilsson wrote:
> >Breaking here dropped us to the default code which always sends
> >a SIGILL to the current process, no matter what the CU2 notifier says.
> >
> >Signed-off-by: Jesper Nilsson<jesper@jni.nu>
> >---
> >  traps.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> >index 8bdd6a6..8527808 100644
> >--- a/arch/mips/kernel/traps.c
> >+++ b/arch/mips/kernel/traps.c
> >@@ -976,7 +976,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
> >
> >  	case 2:
> >  		raw_notifier_call_chain(&cu2_chain, CU2_EXCEPTION, regs);
> >-		break;
> >+		return;
> >
> 
> What happens when the call chain is empty, and the proper action *is* 
> SIGILL?

Well, since there is a default notifier installed at the end, it will
correctly return SIGILL.

See the definition of default_cu2_call in the same file.

> David Daney

/^JN - Jesper Nilsson
--
                  Jesper Nilsson -- jesper_at_jni.nu
