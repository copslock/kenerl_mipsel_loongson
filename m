Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6V72GRw012760
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 31 Jul 2002 00:02:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6V72Grv012759
	for linux-mips-outgoing; Wed, 31 Jul 2002 00:02:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6V725Rw012750
	for <linux-mips@oss.sgi.com>; Wed, 31 Jul 2002 00:02:05 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6V73QXb020780;
	Wed, 31 Jul 2002 00:03:26 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA10484;
	Wed, 31 Jul 2002 00:03:24 -0700 (PDT)
Message-ID: <004201c23860$85425d10$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Carsten Langgaard" <carstenl@mips.com>,
   "Zajerko-McKee, Nick" <nmckee@telogy.com>
Cc: "Linux-Mips \(E-mail\)" <linux-mips@oss.sgi.com>
References: <37A3C2F21006D611995100B0D0F9B73CBFE213@tnint11.telogy.design.ti.com> <3D477DC3.6C304839@mips.com>
Subject: Re: GAS 4kc question...
Date: Wed, 31 Jul 2002 09:04:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

To try to reconcile some seemingly contradictory responses,
the multiply-accumulate and the 3-operand, or "targeted" multiply 
instruction were first supported by the IDT R4650 as a superset 
of the MIPS III ISA.  As they proved useful and popular, they
were later integrated into the MIPS32 ISA spec.  Prior to MIPS32
standardizing things, there were several variations on the multiply-accumulate
instruction mnemonics (madd, mac, etc.) and even some variants
on the encoding.  MIPS32 adopted "madd" as the standard
mnemonic, and uses the same encoding as the R4650.  I'm 
not sure what you mean by "mulu".  The origininal MIPS mnemonic
for a 2-operand multiply is "mult", and it has an unsigned counterpart
"multu".  The 3-operand multiply was standardized with the mnemonic
"mul". If an "unsigned" version of that instruction existed, it would be 
"mulu", but no such version  exists, and it's not clear to me that it would
make any sense, given that the definition of the targeted multiply is that 
the specified target GPR gets the *least significant* 32 bits of the product.

As Carsten indicates, "madd" and "mul" are enabled by -mips32
in newer assemblers, but it is also true that -m4650 will cause them
to be assembled correctly in older assemblers.  I have run madd code
generated with the 4650 option successfully on a MIPS 4Kc.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Carsten Langgaard" <carstenl@mips.com>
To: "Zajerko-McKee, Nick" <nmckee@telogy.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Sent: Wednesday, July 31, 2002 8:03 AM
Subject: Re: GAS 4kc question...


> I guess you mean madd and mul (not mulu).
> These instructions are MIPS32 instructions and are most likely not recognized
> by your toolchain.
> Try use the compiler option "-mips32" to verify it.
> So for now I'm afraid you need to hardcode these by hand. We are very close to
> release a MIPS32 compiler, so we don't need these hacks in the future.
> 
> /Carsten
> 
> "Zajerko-McKee, Nick" wrote:
> 
> > Hi,
> >
> > I'm trying to write some inline assembler code that needs the madd and mulu
> > op codes found on the 4KC processor.  I've tried setting the cpu to 4650,
> > but it failed to recognize the mulu instruction.  Can someone give me the
> > magic incantation?  I'm running right now GCC 2.95.3 from Montavista.  I
> > guess one way I can attack it for now is to build the op code by hand, but
> > that is quite dirty, IMHO...
> >
> >   ------------------------------------------------------------------------
> >
> >    Nick Zajerko-McKee.vcfName: Nick Zajerko-McKee.vcf
> >                          Type: VCard (text/x-vcard)
> 
> --
> _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark             http://www.mips.com
> 
> 
> 
> 
