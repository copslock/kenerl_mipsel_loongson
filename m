Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 08:43:42 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.201]:57336 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133372AbWAZInW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 08:43:22 +0000
Received: by zproxy.gmail.com with SMTP id l8so316364nzf
        for <linux-mips@linux-mips.org>; Thu, 26 Jan 2006 00:47:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mChQofBDvrP9+orCUExr7TWdWLPR/8LQgU0GJTpE5GpKO4PzvJdVcf84qlsMunFm9bnKERJTSwW2r0gKJa2x+tYLS2HoSFk0uEGcgKL4fxvkddYB2AHlFgWg4YxLgNvZnmpPRrCM2oQSReTSfW6swW6tGraNyjFF7wpXD09I3fQ=
Received: by 10.36.128.5 with SMTP id a5mr1294399nzd;
        Thu, 26 Jan 2006 00:47:51 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 26 Jan 2006 00:47:51 -0800 (PST)
Message-ID: <cda58cb80601260047g78ffb52cr@mail.gmail.com>
Date:	Thu, 26 Jan 2006 09:47:51 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <43D887BB.3030906@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <cda58cb80601250534r5f464fd1v@mail.gmail.com>
	 <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org>
	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
	 <20060125150404.GF3454@linux-mips.org>
	 <cda58cb80601251003m6ba4379w@mail.gmail.com>
	 <43D7C050.5090607@mips.com>
	 <cda58cb80601260011r6136c3fq@mail.gmail.com>
	 <43D887BB.3030906@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/26, Kevin D. Kissell <kevink@mips.com>:
> Franck wrote:
> > Let's say that the 4KSC has "wsbh" instruction which is part of
> > MIPS32R2 instructrion set (I haven't checked it). The question is how
> > the 4KSC would use the SWAB optimizations since it doesn't define
> > CONFIG_CPU_MIPS32_R2  ? The 4KSC might not be the only one case...
>
> The 4KSc happens not to have the MIPS32R2 WSBH (is that pronounced
> "wasabi"? ;o) instruction, but it does have the MIPS32R2 ROTR, because
> it's part of the SmartMIPS ASE.  Our options here include:
>
> * Say "to heck with it" and deny the 4KSc use of the ROTR, and stay
>    with a "#ifdef CONFIG_CPU_MIPS32R2" conditional.
>
> * Define CONFIG_CPU_MIPS4KSC as an additional oddball CPU flag, and
>    make it "#if defined(CONFIG_CPU_MIPS32R2) || defined(CONFIG_CPU_MIPS4KSC)
>
> * Have an ASE-support flag, CONFIG_CPU_SMARTMIPS, which would cover both
>    the 4KSc and 4KSd.  In that case code using ROTR could be conditional on
>    #if defined(CPU_CONFIG_MIPS32R2) || defined(CONFIG_CPU_SMARTMIPS).
>
> I personally think that the third option is the cleanest and most conceptually
> correct, but I'm not the guy operationally responsible for maintaining
> that code.
>

I think we will have to use second _and_ third options. I can't find
out an example, but since 4KSC has some MIPS32_R2 instructions it will
need to use some specific MIPS32_R2 code sometimes.

Anyways I'm going to send to Ralf a new patch for swab optimizations.

Thanks
--
               Franck
