Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2JFxro01724
	for linux-mips-outgoing; Mon, 19 Mar 2001 07:59:53 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2JFxqM01721
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 07:59:52 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA06507
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 07:59:52 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA03322
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 07:59:50 -0800 (PST)
Message-ID: <00f901c0b08e$3099bc00$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@oss.sgi.com>
References: <3AB61293.5652407C@mips.com> <00e901c0b08b$50bed400$0deca8c0@Ulysses>
Subject: Re: Bug in the _save_fp_context.
Date: Mon, 19 Mar 2001 17:03:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Oops!  I hadn't noticed that Carsten had copied the
Linux-MIPS mailing list on this, so I treated it as a
point-to-point communication.  The rest of you can
ignore my last paragraph!

            Kevin K.

----- Original Message -----
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Carsten Langgaard" <carstenl@mips.com>; <linux-mips@oss.sgi.com>
Sent: Monday, March 19, 2001 4:43 PM
Subject: Re: Bug in the _save_fp_context.


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
>
