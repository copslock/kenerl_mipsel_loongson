Received:  by oss.sgi.com id <S42235AbQGDLwo>;
	Tue, 4 Jul 2000 04:52:44 -0700
Received: from Cantor.suse.de ([194.112.123.193]:29958 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42203AbQGDLwW>;
	Tue, 4 Jul 2000 04:52:22 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 6A0EA1E0C2; Tue,  4 Jul 2000 13:52:21 +0200 (MEST)
Received: from arthur.inka.de (Maclaurin.suse.de [10.10.1.130])
	by Hermes.suse.de (Postfix) with ESMTP
	id E259E10A028; Tue,  4 Jul 2000 13:52:17 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 139R2g-0006FH-00; Tue, 04 Jul 2000 13:39:06 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 2461A1822; Tue,  4 Jul 2000 13:39:04 +0200 (CEST)
Mail-Copies-To: never
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: FPU Control Word: Initial Value looks wrong
References: <u8sntrm88t.fsf@gromit.rhein-neckar.de>
	<20000704003232.A2112@bacchus.dhis.org>
From:   Andreas Jaeger <aj@suse.de>
Date:   04 Jul 2000 13:39:04 +0200
In-Reply-To: Ralf Baechle's message of "Tue, 4 Jul 2000 00:32:32 +0200"
Message-ID: <u8g0pqjfaf.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Ralf Baechle writes:

Ralf> On Mon, Jul 03, 2000 at 07:30:42PM +0200, Andreas Jaeger wrote:
>> Porting glibc to MIPS I noticed that the initial contents of the fpu
>> control word doesn't seem to be right (at least on the machines I've
>> tried - one with a normal MIPS 2.2.13 and one with 2.2.15 and the
>> MIPS/Algorithmics patches (including FPU emulator).

>> The appended small test program should return a 0 (that's the desired
>> value by glibc for full ISO C99 support) - but it seems to be set to
>> 0x600.
>> 
>> Could the kernel folks fix this, please?  I grepped through the sources
>> and didn't find a place where the FPU gets initialised.:-(

Ralf> Surprise - the kernel initializes this to zero and the libc should do
Ralf> the same afair.  Did this change?

No, that's correct - but I don't get a zero.

Ralf> I tried your program on a Indy running 2.4.0-test2 + glibc 2.2 and it was
Ralf> printing ``0 0''.

Did you try it with a shared program?  Static programs always
initialize the FPU.  Could you run the program on other machines also?

Ralf> Could you check the source of your kernel for the value it's writing to
Ralf> fcr31?  That's the constant FPU_DEFAULT defined in arch/mips/kernel/
Ralf> r4k_switch.S.  Some quite old kernel were using a different value but I
Ralf> was actually assuming those versions have already died out.

The kernels I used have 0 as FPU_DEFAULT - but nevertheless the
returned value is wrong.  When is FPU_DEFAULT written to the FPU?

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
