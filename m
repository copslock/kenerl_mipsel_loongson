Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 16:01:30 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.193]:48340 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133725AbVJaQBL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Oct 2005 16:01:11 +0000
Received: by zproxy.gmail.com with SMTP id j2so883348nzf
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2005 08:01:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ksQNZ35ijZmnzseerMjvVYAjGy63QnJrW3BEi/iZN4SewejDynPSd/ltO6ywLg1s3fFZYLHmL9tpTPCfa/twKRgbWMsNyLjfXgZj2tAUyh3Ee+PuBPU+gUJEwFHQ/b1R9Nk/7XAipM1vn9hnWhbg8WAUBK+1ptzpn2qgvr5givU=
Received: by 10.37.21.8 with SMTP id y8mr3787774nzi;
        Mon, 31 Oct 2005 08:01:42 -0800 (PST)
Received: by 10.36.48.2 with HTTP; Mon, 31 Oct 2005 08:01:42 -0800 (PST)
Message-ID: <cda58cb80510310801v2d60f60bh@mail.gmail.com>
Date:	Mon, 31 Oct 2005 17:01:42 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [RFC] Add 4KSx support (try 2)
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <4365DF22.8060004@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510310034k60b273dfm@mail.gmail.com>
	 <4365DF22.8060004@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks Kevin for responding !

2005/10/31, Kevin D. Kissell <kevink@mips.com>:
> I'm not set up to actually apply and test the patch,
> but for whatever it's worth, the functionality in the patch
> appears to be superficially correct, and more-or-less
> what I would have done.  That having been said, I think
> you're creating more changes than are really required.
>
> Having seperate target call-outs for the Sc/Sd in the
> arch/mips/kernel/Makefile just to avoid having r4k_fpu.o
> linked it creates cruft for a savings of 400-odd bytes
> of kernel image, and I'd either have not bothered or have
> figured out a more generic way to strip out FP support
> for FP-less cores.
>
> There are places, for example arch/mips/mm/cache.c, but
> also some of the other makefiles, where you're using your
> new config flags to drive things where the standard
> CONFIG_CPU_MIPS32 (which I guess has now fragmented into
> CONFIG_CPU_MIPS32_R1 and CONFIG_CPU_MIPS32_R2, which would
> apply to the Sc and Sd respectively) would do the right thing
> while creating fewer source file mods.
>

That's correct but CONFIG_CPU_MIPS32_Rx seems to be a fallback case.
Don't other cpu use their own flags whereas they could just use
CONFIG_CPU_MIPS32_Rx flag instead ?

> Have you thought about what the ACX state would mean for
> kernel debuggers in general and kgdb in particular?
>

no, I didn't. I took a look at arch/mips/kernel/gdb-low.S and it seems
to be required....

Thanks
--
               Franck
