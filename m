Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6V62eRw011257
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 23:02:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6V62eQb011256
	for linux-mips-outgoing; Tue, 30 Jul 2002 23:02:40 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6V62YRw011244
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 23:02:34 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6V63tXb020648;
	Tue, 30 Jul 2002 23:03:55 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA09131;
	Tue, 30 Jul 2002 23:03:56 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6V63tb11782;
	Wed, 31 Jul 2002 08:03:56 +0200 (MEST)
Message-ID: <3D477DC3.6C304839@mips.com>
Date: Wed, 31 Jul 2002 08:03:54 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Zajerko-McKee, Nick" <nmckee@telogy.com>
CC: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: GAS 4kc question...
References: <37A3C2F21006D611995100B0D0F9B73CBFE213@tnint11.telogy.design.ti.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I guess you mean madd and mul (not mulu).
These instructions are MIPS32 instructions and are most likely not recognized
by your toolchain.
Try use the compiler option "-mips32" to verify it.
So for now I'm afraid you need to hardcode these by hand. We are very close to
release a MIPS32 compiler, so we don't need these hacks in the future.

/Carsten

"Zajerko-McKee, Nick" wrote:

> Hi,
>
> I'm trying to write some inline assembler code that needs the madd and mulu
> op codes found on the 4KC processor.  I've tried setting the cpu to 4650,
> but it failed to recognize the mulu instruction.  Can someone give me the
> magic incantation?  I'm running right now GCC 2.95.3 from Montavista.  I
> guess one way I can attack it for now is to build the op code by hand, but
> that is quite dirty, IMHO...
>
>   ------------------------------------------------------------------------
>
>    Nick Zajerko-McKee.vcfName: Nick Zajerko-McKee.vcf
>                          Type: VCard (text/x-vcard)

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
