Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 09:11:17 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:57538 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133511AbWAZJK6
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 09:10:58 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0Q9FHQF019520;
	Thu, 26 Jan 2006 01:15:18 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id k0Q9FEYr014002;
	Thu, 26 Jan 2006 01:15:15 -0800 (PST)
Message-ID: <000b01c62259$535f0e10$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Franck" <vagabon.xyz@gmail.com>
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com> <cda58cb80601250534r5f464fd1v@mail.gmail.com> <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org> <cda58cb80601250632r3e8f7b9en@mail.gmail.com> <20060125150404.GF3454@linux-mips.org> <cda58cb80601251003m6ba4379w@mail.gmail.com> <43D7C050.5090607@mips.com> <cda58cb80601260011r6136c3fq@mail.gmail.com> <43D887BB.3030906@mips.com> <cda58cb80601260047g78ffb52cr@mail.gmail.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Date:	Thu, 26 Jan 2006 10:17:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> > Franck wrote:
> > > Let's say that the 4KSC has "wsbh" instruction which is part of
> > > MIPS32R2 instructrion set (I haven't checked it). The question is how
> > > the 4KSC would use the SWAB optimizations since it doesn't define
> > > CONFIG_CPU_MIPS32_R2  ? The 4KSC might not be the only one case...
> >
> > The 4KSc happens not to have the MIPS32R2 WSBH (is that pronounced
> > "wasabi"? ;o) instruction, but it does have the MIPS32R2 ROTR, because
> > it's part of the SmartMIPS ASE.  Our options here include:
> >
> > * Say "to heck with it" and deny the 4KSc use of the ROTR, and stay
> >    with a "#ifdef CONFIG_CPU_MIPS32R2" conditional.
> >
> > * Define CONFIG_CPU_MIPS4KSC as an additional oddball CPU flag, and
> >    make it "#if defined(CONFIG_CPU_MIPS32R2) || defined(CONFIG_CPU_MIPS4KSC)
> >
> > * Have an ASE-support flag, CONFIG_CPU_SMARTMIPS, which would cover both
> >    the 4KSc and 4KSd.  In that case code using ROTR could be conditional on
> >    #if defined(CPU_CONFIG_MIPS32R2) || defined(CONFIG_CPU_SMARTMIPS).
> >
> > I personally think that the third option is the cleanest and most conceptually
> > correct, but I'm not the guy operationally responsible for maintaining
> > that code.
> 
> I think we will have to use second _and_ third options. I can't find
> out an example, but since 4KSC has some MIPS32_R2 instructions it will
> need to use some specific MIPS32_R2 code sometimes.

You don't understand. There is nothing in the 4KSc that is not in the SmartMIPS ASE.
The 4KSc implements MIPS32+SmartMIPS.  The 4KSd implementes MIPS32R2+SmartMIPS.
You're getting confused because some elements of SmartMIPS made it into MIPS32R2.
If we have a CONFIG_CPU_SMARTMIPS flag, there would be no need for a
CONFIG_CPU_MIPS4KSC flag.

        Regards,

        Kevin K.
