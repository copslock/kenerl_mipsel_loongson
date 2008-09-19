Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 14:26:32 +0100 (BST)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:26635 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S28795841AbYISN02 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 14:26:28 +0100
Received: from [127.0.0.1] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id IAA11418;
	Fri, 19 Sep 2008 08:54:32 -0500
Message-ID: <48D3A909.6020604@paralogos.com>
Date:	Fri, 19 Sep 2008 15:28:41 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Klatt Uwe <U.Klatt@miwe.de>
CC:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Same mipsel binary =?ISO-8859-1?Q?f=FCr_2=2E4_and_2=2E?=
 =?ISO-8859-1?Q?6_kernel_possible=3F?=
References: <A1F06CF959C7E14EAC28F277F368175805686A8D6D@MAS15.arnstein.miwe.de>
In-Reply-To: <A1F06CF959C7E14EAC28F277F368175805686A8D6D@MAS15.arnstein.miwe.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

When you say "float math isn't working", what do you mean?  When you say 
that the new binary
only works with the 2.6 kernel, what do you mean?  Are you getting bad 
answers, or is the program
crashing?  If it's crashing, and you run it under gdb, where is it 
blowing up, and why?  Are you able
to re-create the "old" binary?   If you do a static link of the program 
using the old tools,
does the resulting binary work better under 2.6?

The FPU emulator has bad some minor cleanup over the past few years, but 
it's been pretty
stable, and I can't recall having seen any serious functional or 
compatibility problems in a long
time.  I think it's more likely that you've got a problem with libraries 
and/or build procedures
for the application.

          Regards,

          Kevin K.

Klatt Uwe wrote:
> Hello,
>
> I have a custom hardware (AU1100) with kernel 2.4 and an working binary using floats (compiled with gcc 3.3.5).
> Now I am testing with kernel 2.6.
>
> When I use the old binary, float math isn't working anymore.
> I have to recompile the source with new gcc 4.1.2 but then the new binary is working only on kernel 2.6.
>
> Can somebody give me some hints, how to chage settings for kernel 2.6 creation or compiler settings to generate an universal binary.
>
> Thanks
> Uwe
>
>
>   
