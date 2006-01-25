Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 17:59:39 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.203]:61009 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133456AbWAYR7T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 17:59:19 +0000
Received: by zproxy.gmail.com with SMTP id l8so174353nzf
        for <linux-mips@linux-mips.org>; Wed, 25 Jan 2006 10:03:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VWdbbwiavcJAz25wVoVXn9PPHXFRQa/ms2S/F6FkFifvmLGyLWEciukLHOtsbd7W/dsutnxqUrXpeOlzByyN+MulK3VbcomJNxayGZv2By1GjKr70hw6XZi/IRwfPoxJVz8fTZasOb+51QfX8E8o0SshQdlULVe+ug4uRrP8avU=
Received: by 10.37.13.24 with SMTP id q24mr692279nzi;
        Wed, 25 Jan 2006 10:03:44 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Wed, 25 Jan 2006 10:03:44 -0800 (PST)
Message-ID: <cda58cb80601251003m6ba4379w@mail.gmail.com>
Date:	Wed, 25 Jan 2006 19:03:44 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <20060125150404.GF3454@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <20060125124738.GA3454@linux-mips.org>
	 <cda58cb80601250534r5f464fd1v@mail.gmail.com>
	 <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org>
	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
	 <20060125150404.GF3454@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/25, Ralf Baechle <ralf@linux-mips.org>:
> On Wed, Jan 25, 2006 at 03:32:22PM +0100, Franck wrote:
>
> > > We have CPU_MIPS32_R1, CPU_MIPS32_R2, CPU_MIPS64_R1, CPU_MIPS64_R2.
> > > Based on those we also define CPU_MIPS32, CPU_MIPS64, CPU_MIPSR1,
> > > and CPU_MIPSR2 as short cuts.
> > >
> >
> > hm I should have missed something, but what about CPUs which have
> > their own CPU_XXX (different form CPU_MIPS32_R[12]) and which are a
> > mips32-r2 compliant for example ? (I'm thinking of 4KSD for example)
>
> The 4KSD is still a MIPS32 processor - just one with an ASE.
>
> The real bug here - and what's causing your confusion - is that the
> processor configuration is mixing up all the architecture variants
> (MIPS I - IV, MIPS32 and MIPS64 R1/R2, weirdo variants ...) and the
> processor types.  Example: 4K, 4KE, 24K, 24KE, 34K, AMD Alchemy are all
> MIPS32 (either R1 or R2).  R4000, R4400, R4600 are all MIPS III.  But
> what we actually offer in the processor configuration is R4X00, MIPS32_R1,
>

OK. So the patch I sent to you 3 months ago that adds support for
4ks[cd] cpu and smartmips extension is wrong. It added new
CONFIG_CPU_4KS[CD] macro whereas it must have used MIPS32_R[12] macros
like Kevin suggested...

BTW, any chances to get smartmips support merged into your tree ?

Thanks
--
               Franck
