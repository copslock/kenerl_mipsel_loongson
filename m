Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 09:52:23 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.236]:29885 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038877AbXBAJwT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 09:52:19 +0000
Received: by qb-out-0506.google.com with SMTP id p30so36241qba
        for <linux-mips@linux-mips.org>; Thu, 01 Feb 2007 01:51:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h3LWFQG8Ncz1zcOEL0Yvmn4wTKU8W8s+6RDsUNm2egeAHeI9pOa8T9XELOJZacDZx6s9EkCl3HiU9mo8Tv7lmdx2rPWUoZRgjnOeb3x4MR67wt1HnAxic34bO/WQcNHC/awkc8Xa7V/lkbVpig1aSU1ivWdPRl6OMv5/0CY/mhQ=
Received: by 10.114.181.1 with SMTP id d1mr133641waf.1170323475737;
        Thu, 01 Feb 2007 01:51:15 -0800 (PST)
Received: by 10.114.134.16 with HTTP; Thu, 1 Feb 2007 01:51:15 -0800 (PST)
Message-ID: <cda58cb80702010151x62e3b92ap18c63110f7fd4f0c@mail.gmail.com>
Date:	Thu, 1 Feb 2007 10:51:15 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: RFC: Sentosa boot fix
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, dan@debian.org,
	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <Pine.LNX.4.64N.0701301713350.9231@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com>
	 <20070129161450.GA3384@nevyn.them.org>
	 <Pine.LNX.4.64N.0701291833480.26916@blysk.ds.pg.gda.pl>
	 <20070130.234537.126574565.anemo@mba.ocn.ne.jp>
	 <Pine.LNX.4.64N.0701301713350.9231@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/30/07, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Tue, 30 Jan 2007, Atsushi Nemoto wrote:
>
> > Though I do not object to remove "&& !defined(CONFIG_BUILD_ELF64)"
> > from __pa_page_offset(), are there any point of CONFIG_BUILD_ELF64=y
> > if your load address was CKSEG0?
>
>  Checking for code correctness and validation of the toolchain (Linux is
> one of the few non-PIC users of (n)64) without having to chase hardware
> that would support running from XPHYS without serious pain (the firmware
> being the usual offender).
>

This use case was unknown by the time we introduced __pa_page_offset().

Basically this macro assumes that if BUILD_ELF64 is set the load
address is in XKPHYS. This allows to simplify __pa_page_offset()
definition for this case.

However if BUILD_ELF64 is not set then the macro deals with both
CKSEG0 and XKPHYS virtual addresses.

>  That said, I have not checked the every single use of __pa_page_offset(),
> but the sole existence of this condition raises a question about whether
> we are sure __pa_page_offset() is going to be only used on virtual
> addresses in the same segment the kernel is linked to.

Well it all depends if we consider the case with BUILD_ELF64 set and a
load address in CKSEG0 a useful case. If so, then we can remove "&&
!defined(CONFIG_BUILD_ELF64)"
from __pa_page_offset(). It shouldn't hurt the case where BUILD_ELF64
is not set and Atsushi seems to agree.

BTW, maybe we can simply remove BUILD_ELF64 at all, since it's only
used to add '-msym32' switch in the makefile. This switch could be
automatically be added by the makefile instead thanks the following
condition:

if CONFIG_64BITS and ${load-y} in CKSEG0
    cflags-y += -msym32
endif

what do you think ?

> Sometimes
> references to both CKSEG0 and XPHYS may be used in the same kernel, e.g.
> because the the kernel is linked to XPHYS, but the firmware is limited to
> accept CKSEG0 addresses only (and we do call back into firmware on some
> platforms).
>

Please keep these conversions in the platform specific codes before
calling back the firmware.
-- 
               Franck
