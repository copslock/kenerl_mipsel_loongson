Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6EBZk912790
	for linux-mips-outgoing; Sat, 14 Jul 2001 04:35:46 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6EBZgV12779;
	Sat, 14 Jul 2001 04:35:42 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA14426;
	Sat, 14 Jul 2001 04:35:34 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA13232;
	Sat, 14 Jul 2001 04:35:31 -0700 (PDT)
Message-ID: <007f01c10c59$bbe8bfa0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Thiemo Seufer" <ica2_ts@csv.ica.uni-stuttgart.de>,
   <linux-mips@oss.sgi.com>
References: <20010713133517.C1378@bacchus.dhis.org> <Pine.GSO.3.96.1010713151359.3193D-100000@delta.ds2.pg.gda.pl> <20010714130448.C6713@bacchus.dhis.org>
Subject: Re: sti() does not work.
Date: Sat, 14 Jul 2001 13:39:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Real wild pig hackers on R3000 were writing code which knows that in the
> load delay slot they still have the old register value available.  So you
> can implement var1++; var2++ as:
> 
> .set noreorder
> lw $reg, var1($gp)
> nop
> addiu $reg, $reg, 1
> lw $reg, var2($gp)
> sw $reg, var1($gp)
> addiu $reg, $reg, 1
> sw $reg, var2($gp)
> 
> .common var1, 4, 4
> .common var2, 4, 4
> 
> Of course only safe with interrupts disabled.  So in a sense introducing
> the load interlock broke semantics of MIPS machine code ;-)

Architecturally, the target register value is UNDEFINED during
the load delay slot on a MIPS I CPU.  Anyone who coded to any
particular assumption regarding its value was coding to a 
specific CPU implementation.  Introducing the load interlock
in later versions of the ISA and later implementations did not
reach backward in time and break the old hardware.  The
implementation-specific code still works for its specific 
implementation.  Refining the spec did not break the code for later
implementations - it was *always* broken for later implementations! ;-)

In a less pedantic tone, there actually is an architecturally
legal case where an assembly coder can justify the use of
noreorder for something other than CP0 pipeline hazards.
If what I want to do is to test a value, branch on the result,
and modify that value regardless of whether the branch is
taken, I can code something like:

    .set noreorder
    bltz    t0,foo
    sra    t0,t0,2
    .set reorder
    <other code>
foo:

Whereas otherwise I need to either consume another
register or replicate the shift both after the branch and
after foo.  If I'm very very lucky, the assembler will "hoist"
such a replicated instruction into the delay slot - a  good
compiler back-end optimiser certainly would.  But I'm not 
aware of any MIPS assembler that would perform that
optimisation - certainly the GNU assembler does not.

            Kevin K.
