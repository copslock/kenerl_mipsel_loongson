Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f74E2bh16878
	for linux-mips-outgoing; Sat, 4 Aug 2001 07:02:37 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f74E2XV16866;
	Sat, 4 Aug 2001 07:02:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA05642;
	Sat, 4 Aug 2001 07:02:21 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA28502;
	Sat, 4 Aug 2001 07:02:17 -0700 (PDT)
Message-ID: <006b01c11cee$b54cfbc0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Carsten Langgaard" <carstenl@mips.com>, <ppopov@mvista.com>,
   "Ralf Baechle" <ralf@oss.sgi.com>
Cc: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
References: <3B53679A.4020809@mvista.com> <3B53D22D.D8913C09@mips.com> <3B53D4DB.2090809@mvista.com> <3B53D895.30D92792@mips.com> <3B53DB71.8040501@mvista.com> <3B53DCDA.ECAB628E@mips.com> <3B53E00F.4070904@mvista.com> <3B53E654.325D030@mips.com> <3B53E79F.80409@mvista.com> <3B53ECA3.2BD2104E@mips.com> <3B53EF8B.8010003@mvista.com> <3B53F42C.6F409B70@mips.com> <3B53F5A7.8020705@mvista.com> <3B53F6E2.FE19F0CA@mips.com>
Subject: FPU Emulation and Signals - An Alternative Fix
Date: Sat, 4 Aug 2001 16:06:37 +0200
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

To recap, Pete found a hole in the FPU emulator code,
wherein a signal delivered between the setup and the
execution of the trampoline code for an instruction in
the delay slot of an emulated floating point branch
would trash the trampoline code and cause Bad
Things to happen.  Adding a more space between
the user stack pointer and the trampoline code 
solves the problem in a particular case, but is 
provably still at risk, since signal handlers can
allocate arbitrary amounts of stack storage.
Carsten and I both developed patches to inhibit
the delivery of signals during the trampoline.
This had the defect of causing processes to block
indefinitely in cases where the instruction being
executed by the trampoline itself causes an exception,
as Carsten was able to demonstrate using "crashme".

My patch used relatively heavyweight high-level
mechanisms, which have the virtue of being easily
configurable to allow certain signals from which the
signal handler is unable or unlikely to return (such
as SIGILL, SIGSEGV, and SIGBUS) to be delivered.
That seems to be OK for both crashme and Pete's
program, but I believe it is still broken for things like
trap instructions in the branch delay slot, and for
ptrace() single-stepping.  So I've got another idea
that I think is much better, and I'm kicking myself for
not having thought of it earlier.

The idea is to simply ensure that signal stack
frames always leave a space between the
current user SP and the stack frame itself.  If no
signals fire, fine.  If a signal is delivered and 
caught, its frame will be beyond the FP emulator
trampoline.  This is a trivial hack to get_sigframe()
that should be completely harmless (aside from
increased memory consumption), since it's
aleady set up to accept signal frames that aren't
on the stack as per Posix signal stacks.

There are, however, a flies in the ointment, as always.
Once we commit that original sin of allowing signals to 
"play through" during the trampoline sequence, we open 
the door to a signal handler containing FP branches itself, 
which would need to be emulated.  Yes, we could create 
another trampoline further up the stack, but the problem is
that the thread-specific data to allow recovery from the first 
trampoline will be overwritten by the second.  Furthermore,
the trampoline mechanism is terminated by catching the
next unaligned access fault for the thread.  A signal handler
could also generate an unaligned access fault.  The former
problem could probably be worked around acceptably by
simply having the FP trap handler notice that it is already
in a delay-slot-emulation sequence, and nail the process
with SIGFPE or SIGILL if it happens to do another one.
Not nice, but at least consistent, and the case is highly 
unlikely to arise.  But we've still got the unaligned access
case to consider.  So I submit the following for your consideration.
In the FP emulator, when we set up the trampoline, we set
up the following above  the user stack:

            Instruction-to-be-executed
            AdELOAD (unaligned load of r0 off of r0)
            Magic-cookie-that-is-an-unimplemented-instruction
            EPC-to-use-on-completion

Rather than use thread.desmul_epc as a flag to indicate
to the unaligned access handler that there is emulation
going on, the unaligned access handler would test to see
if the unaligned access instruction itself was the AdELOAD,
and that it is followed by the magic cookie, and if so, treat 
that as an indication to stuff the value following the sequence
(as indicated by EPC, modulo branch delays) into the EPC 
and return.   This way, one could nest an arbitrary number of 
emulation/signal/emulation sequences, and they should unroll 
correctly.  The further magic cookie is needed since, even though 
it's a completely useless instruction, the AdELOAD could be 
encountered for other reasons, as a misguided attempt
at cache prefetch, or by executing crashme. It's a useless instruction 
to emulate, having r0 as the destination, but the normal Linux semantics 
as I understand them would be to turn it  into a very expensive 
no-op and continue in what might otherwise be safe and sane 
execution.  With the addtional code word after the AdELOAD 
(and before the EPC) on  the dsemul stack that would be (more-or-less) 
guaranteed  to really be an illegal instruction, the only risk we would 
be taking would be to have a  program really containing the 
unaligned nonsense load followed by the  illegal instruction 
blow up, not on the illegal instruction, but by picking up a bogus 
EPC.  Not perfect.  But maybe the lesser of several evils.

I'm working on a prototype, but do you think that this scheme 
is viable?

            Regards,

            Kevin K.
