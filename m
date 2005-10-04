Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 14:10:52 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.205]:51419 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133472AbVJDNKf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 14:10:35 +0100
Received: by zproxy.gmail.com with SMTP id j2so162845nzf
        for <linux-mips@linux-mips.org>; Tue, 04 Oct 2005 06:10:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NjtO6zC9RRvKLp69D0QSG+uwYuPchrTdI4etYzQ0Zg6a/OQEcUxiCrWE+bq6vigIBAvvbgjR6DoILyE8Ch8f2vRQa4Lb2oY6eGDrtgT7f61lsfom2nioqTYd9GVGiQkHFMwI7BxaYpo4JGP29UucgF2M+VId6nIXJaGyxoGQsvI=
Received: by 10.36.97.9 with SMTP id u9mr200135nzb;
        Tue, 04 Oct 2005 06:10:28 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Tue, 4 Oct 2005 06:10:28 -0700 (PDT)
Message-ID: <cda58cb80510040610k1a7f430fn@mail.gmail.com>
Date:	Tue, 4 Oct 2005 15:10:28 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] Add support for 4KS cpu.
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510040149p690397afo@mail.gmail.com>
	 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/10/4, Maciej W. Rozycki <macro@linux-mips.org>:
> On Tue, 4 Oct 2005, Franck wrote:
>
> > This patch adds support for both 4ksc and 4ksd cpus. These cpu are
> > mainly used in embedded system such as smartcard or point of sell
> > devices as they provide some extra security features.
>
>  Please send patches inline.

I can see it inlined...what email viewer are you using ?

>
>  Apart from the change to "arch/mips/kernel/cpu-probe.c", which is useful,
> what's the benefit of the changes?  Specifically how is selecting e.g.
> "CPU_4KSC" meant to be different from "CPU_MIPS32_R2"?  Do you want to
> make GCC tune your code according to a specific's CPU pipeline
> description?  If so, then it should probably be done a bit differently and
> there is actually no need to differentiate between specific members of the
> 4K family.
>

True, but we may have some differences in future. For example, they
both implements smart mips instructions. See options passed to GCC in
mips Makefile, they're different from CPU_MIPS32_R2 ones. They also
have a couple of instructions very useful for cryptographic
algorithms. And have some extra bits in TLB to protect pages from
being execute for example. These are the main differences that I can
remember. Big fat warning: I sent all support I have done for these
cpu, _not_ more, _not_ less. I agree it's almost nothing but it's a
start...

> > Signed-off-by: Franck <vagabon.xyz@gmail.com>
>

Ok I'll change it.

Thanks
--
               Franck
