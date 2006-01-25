Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 14:28:16 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.200]:62261 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133530AbWAYO16 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 14:27:58 +0000
Received: by zproxy.gmail.com with SMTP id l8so116411nzf
        for <linux-mips@linux-mips.org>; Wed, 25 Jan 2006 06:32:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FcPsNVk8OZwrn55d45CljRnkHSY+1dDQcgMwq6dzsbpE7PoHs7eQUDA4ellliWifR3mLsgNX48W/9H4VxO/3DRkMhHnsXiT72/u1/xUWYbvVlPfzO0RNV5/UCYymdwjpvtsiScVOCkIdSQ19NgVHG6dutijRTkRc99EIQzb6rj0=
Received: by 10.36.109.13 with SMTP id h13mr529641nzc;
        Wed, 25 Jan 2006 06:32:22 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Wed, 25 Jan 2006 06:32:22 -0800 (PST)
Message-ID: <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
Date:	Wed, 25 Jan 2006 15:32:22 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <20060125141424.GE3454@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <20060125124738.GA3454@linux-mips.org>
	 <cda58cb80601250534r5f464fd1v@mail.gmail.com>
	 <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/25, Ralf Baechle <ralf@linux-mips.org>:
> On Wed, Jan 25, 2006 at 03:11:49PM +0100, Kevin D. Kissell wrote:
>
> > >>>Comments ?
> > >>Looks good aside of the one issue you've already raised yourself:
> > >>
> > >>>+/* FIXME: MIPS_R2 only */
> > >
> > >I was actually asking for advices :)
> > >
> > >I can see only two simple ways to do that:
> > >(a) we can define a couple of new macro ie CONFIG_MIPS32_ISET_R[12]
> > >that can be set depending on the selected CPU;
> > >(b) define a new macro CONFIG_CPU_HAS_WSBH;
> >
> > Don't we already have CONFIG_CPU_MIPS32R2?
>
> We have CPU_MIPS32_R1, CPU_MIPS32_R2, CPU_MIPS64_R1, CPU_MIPS64_R2.
> Based on those we also define CPU_MIPS32, CPU_MIPS64, CPU_MIPSR1,
> and CPU_MIPSR2 as short cuts.
>

hm I should have missed something, but what about CPUs which have
their own CPU_XXX (different form CPU_MIPS32_R[12]) and which are a
mips32-r2 compliant for example ? (I'm thinking of 4KSD for example)

Thanks
--
               Franck
