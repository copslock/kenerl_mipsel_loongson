Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2003 14:32:34 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:912 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225193AbTEUNcC>;
	Wed, 21 May 2003 14:32:02 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h4LDViUe026721;
	Wed, 21 May 2003 06:31:44 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id GAA24448;
	Wed, 21 May 2003 06:31:42 -0700 (PDT)
Message-ID: <007a01c31f9e$8a784ee0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc: "Gilad Benjamini" <yaelgilad@myrealbox.com>,
	<linux-mips@linux-mips.org>
References: <Pine.GSO.3.96.1030521115345.2088D-100000@delta.ds2.pg.gda.pl>
Subject: Re: lwl-lwr
Date: Wed, 21 May 2003 15:40:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

>From: "Maciej W. Rozycki" macro@ds2.pg.gda.pl
>

> On Wed, 21 May 2003, Ralf Baechle wrote:
> 
> > > There's really no such thing as "disabling" lwl/lwr.  They are part 
> > > of the base MIPS instruction set.  If one wants to live without them, 
> > > one can either rig a compiler to emit multi-instruction sequences instead 
> > > of lwr/lwl to do the appropriate shifts and masks (which is slower on all 
> > > targets), or you can rig the OS to emulate them, and hope that the processors 
> > > lacking support will take clean reserved instruction traps, where the function 
> > > can be emulated (which is "free" for code running  on CPUs with lwl/lwr, 
> > > but *really* slow for the guys doing emulation).
> > 
> > Technically you're right ...  In reality lwl/lwr are covered by US patent
> > 4,814,976 which would also cover a software implementation.  So unless MIPS
> > grants a license for the purpose of emulation in the Linux kernel ...
> 
>  For practical reasons I believe it can be dealt with without patent
> infringing, but I am not that excited with doing anything at all about it. 

I agree.  I've never read the patent, but now that you mention it, I do
recall having heard that it covers software implementations.  Lets just
leave this one alone...

            Kevin K.
