Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2JGDfo02086
	for linux-mips-outgoing; Mon, 19 Mar 2001 08:13:41 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2JGDeM02083
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 08:13:40 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA06666
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 08:13:40 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA03736;
	Mon, 19 Mar 2001 08:13:38 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id RAA09554;
	Mon, 19 Mar 2001 17:13:07 +0100 (MET)
Message-ID: <3AB63012.B2DF9CD6@mips.com>
Date: Mon, 19 Mar 2001 17:13:06 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Bug in the _save_fp_context.
References: <3AB61293.5652407C@mips.com> <00e901c0b08b$50bed400$0deca8c0@Ulysses>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:

> > I think there is a bug in the _save_fp_context function in
> > arch/mips/kernel/r4k_fpu.S
> >
> > The problem is the following piece of code:
> >
> >  jr ra
> >  .set nomacro
> >  EX(sw t0,SC_FPC_EIR(a0))
> >  nop
> >  .set macro
> >
> > First of all what should the ".set nomacro" do?
> > If it means that the EX macro shouldn't be used then this entry wouldn't
> > get into __ex_table, which would be wrong.
> > But it look like it uses the macro anyway, regardless of the ".set
> > nomacro", at least with the compiler I use.
>
> Not surprising, really.  "EX" is presumably a cpp macro
> that gets expanded by gcc from the .S file, based on
> some include file.  .set directives affect only the assembler,
> and would inhibit assembler-level macros only.  I'm not
> sure just what the definition of an assembler macro
> would be - it may or may not include pseudo-instructions
> like "la" or "li 32_bit_constant".  I *think* that what the
> author was trying to do here was to ensure that the
> "sw" instruction in the EX expansion was really and
> truly a single instruction.
>
> > Never the less we do not handle entries in the __ex_table which is
> > located in a branch delay.
> > So we need to handle the situation where we take a page fault on an
> > instruction which is located in a brach delay slot, or we don't put the
> > "potential" faulting instruction in a delay slot.
> >
> > Any ideas, how we should handle this in a nice and clean way?
>
> Is the __ex_table really ending up in the delay slot?
> Just looking at the source, I have the impression
> that the "sw t0,..." instruction should be in the delay
> slot, followed by the __ex_table.

The problem is that the address of the delay slot is put in the __ex_table
and then we take a page fault EPC is pointing at the jr instruction and not
the delay slot.
This result in a miss match when we try to lookup in __ex_table, resulting in
a kernel crash.

The faulting situation look like this:
EPC = address of delay slot
entry in __ex_table = address of delay slot - 4

Hopes that clarify it a bit more.

>
> On another topic, now that I've patched the kernel to
> turn off the stupid stuck interrupt on my Malta board,
> I've realized that I can't just connect my old Atlas SCSI
> disk.  I'm torn between ordering a Tekram 390 PCI
> SCSI card, which should be able to use our "MIPS
> safe" NCR driver as-is (I hope) and buying an IDE
> disk and going through the network install ritual.
> Which do you recommend?  One thing I really never
> knew was just what kernel config options I need to
> select to build a kernel that can do the NFS-root
> bootstrap.  Can you help me there?
>
>             Regards,
>
>             Kevin K.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
