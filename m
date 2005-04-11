Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 14:39:03 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:38174 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226114AbVDKNis>; Mon, 11 Apr 2005 14:38:48 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3BDcgNr021821;
	Mon, 11 Apr 2005 14:38:42 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3BDcfB7021820;
	Mon, 11 Apr 2005 14:38:41 +0100
Date:	Mon, 11 Apr 2005 14:38:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mile Davidovic <mile.davidovic@micronasnit.com>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Toolchain question
Message-ID: <20050411133841.GX7038@linux-mips.org>
References: <200504111014.j3BADt1p023510@krt.neobee.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504111014.j3BADt1p023510@krt.neobee.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 11, 2005 at 12:13:50PM +0200, Mile Davidovic wrote:
> From:	"Mile Davidovic" <mile.davidovic@micronasnit.com>
> To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
> Subject: Toolchain question
> Date:	Mon, 11 Apr 2005 12:13:50 +0200
> Content-Type: text/plain;
> 	charset="iso-8859-2"
> 
> Hello all
> I would like to port board (with MIPS 4kec) to latest linux 2.6 kernel.
> Using porting guide 
> from (http://www.linux-mips.org/wiki/index.php/Porting) I successfully made
> console and
> serial driver. But problem appears with first printk (in start_kernel) I got
> exception.  
> 
> I used toolchain which uclibc buildroot script produced (gcc-3.4.2,
> binutils-2.15.91.0.2),
> and I am not sure is this correct combination.
> 
> >From 
> http://www.linux-mips.org/wiki/index.php/Toolchains I saw that next
> recommendations:
> 1. SDE MIPS - unfortunately this is 2.9x compiler.

Which should be perfectly find for the kernel.  And no, SDE isn't really
a 2.96-based compiler with _vastly_ improved code generation for MIPS
processors.

Less than a week ago SDE 5 was released which is based on gcc 3.4 and
similarly contains a large number of mostly MIPS-specific improvments.

> 2. Mr. Rozycki offer only mipsel toolchain

Recompiling is easy.

> 3. Mr. Kegel's crosstool but from
> http://kegel.com/crosstool/crosstool-0.31/buildlogs/ it seems that 
> this toolchain is not good for MIPS.

Plenty of success reports to this list contradict it.

> 4. Toolchain from ucLibc, I tried but I have trouble with.

No idea about this one.

> So my question: which toolchains I have to use? 

Since you have problems with all of these you may want to describe those ...

  Ralf
