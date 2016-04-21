Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 18:42:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12038 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026632AbcDUQmK2wMGP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 18:42:10 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 4DC631B706658;
        Thu, 21 Apr 2016 17:41:57 +0100 (IST)
Received: from [10.20.78.30] (10.20.78.30) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 21 Apr 2016
 17:42:03 +0100
Date:   Thu, 21 Apr 2016 17:41:52 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Michal Toman <michal.toman@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "stable # v4 . 3+" <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Prevent "restoration" of MSA context in non-MSA
 kernels
In-Reply-To: <1461253177-6724-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.00.1604211731030.21846@tp.orcam.me.uk>
References: <1461253177-6724-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.30]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Thu, 21 Apr 2016, Paul Burton wrote:

> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> index bf792e2..a304b70 100644
> --- a/arch/mips/kernel/signal.c
> +++ b/arch/mips/kernel/signal.c
> @@ -195,6 +195,9 @@ static int restore_msa_extcontext(void __user *buf, unsigned int size)
>  	unsigned int csr;
>  	int i, err;
>  
> +	if (!config_enabled(CONFIG_CPU_HAS_MSA))
> +		return SIGSYS;
> +
>  	if (size != sizeof(*msa))
>  		return -EINVAL;

 The priciple of your change looks reasonable itself to me, however its 
call site is ill-formed making it possible to return a nonsensical error 
code:

	if (used & USED_EXTCONTEXT)
		err |= restore_extcontext(sc_to_extcontext(sc));

	return err ?: sig;
}

(`restore_extcontext' takes the result from `restore_msa_extcontext' and 
passes it on) so if an earlier call has set `err' to -EINVAL (which I take 
it is the only value expected here or we'd have a preexisting problem), 
then `protected_restore_fp_context' (which is where this code comes from) 
will return (-EINVAL | SIGSYS).

 So you need to redesign this code somehow I'm afraid, maybe just changing 
the condition to:

	if (!err && (used & USED_EXTCONTEXT))

will do (although while at it I'd double-check that `err' can really only 
be -EINVAL here).

  Maciej
