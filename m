Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Nov 2003 12:53:47 +0000 (GMT)
Received: from p508B61C4.dip.t-dialin.net ([IPv6:::ffff:80.139.97.196]:31378
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225367AbTKOMxf>; Sat, 15 Nov 2003 12:53:35 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAFCrUA0001444;
	Sat, 15 Nov 2003 13:53:30 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAFCrToG001443;
	Sat, 15 Nov 2003 13:53:29 +0100
Date: Sat, 15 Nov 2003 13:53:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Teresa Tao <TERESAT@TTI-DM.COM>
Cc: linux-mips@linux-mips.org
Subject: Re: question regarding put data in the specified section
Message-ID: <20031115125329.GA324@linux-mips.org>
References: <92F2591F460F684C9C309EB0D33256FA01B750B8@trid-mail1.tridentmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92F2591F460F684C9C309EB0D33256FA01B750B8@trid-mail1.tridentmicro.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 14, 2003 at 09:42:34AM -0800, Teresa Tao wrote:

> Does anyone know how to put my userland program's data in a specified section?
> 
> I know there is an attribute "section" to put my data inside a specified section, for example, int data __attribute__ ((section("INITDAT"));
> But how do I initialize/setup the INITDAT section? We use the
> commercial toolchain, and we don't have the source code for it, is
> there still a way to specify the postion of the INITDAT section?

If your commercial toolchain understands the __attribute__ syntax then
I suspect it's based on gcc which would mean you have a right to the
sourcecode.

No initialization needed;  Ld will use the flags of the first instance
of an input section for the output section which usually is right.  In
the rare case this isn't suitable you can use a .section pseudo-op
in inline assembler or assembler to setup the section with the right
flags.  Just make sure this section is linked first.

  Ralf
