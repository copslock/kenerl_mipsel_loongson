Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAJeRw13101
	for linux-mips-outgoing; Mon, 10 Dec 2001 11:40:27 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBAJeHo13098;
	Mon, 10 Dec 2001 11:40:17 -0800
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id fBAIe4m09049;
	Mon, 10 Dec 2001 18:40:04 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.0/8.8.7) id fBAIe0H09279;
	Mon, 10 Dec 2001 18:40:00 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15381.384.341974.133229@gladsmuir.algor.co.uk>
Date: Mon, 10 Dec 2001 18:40:00 +0000 (GMT)
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: Why is byteorder removed from /proc/cpuinfo?
In-Reply-To: <20011206155724.A11083@dea.linux-mips.net>
References: <20011206093506.A6496@lucon.org>
	<20011206155724.A11083@dea.linux-mips.net>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Ralf Baechle (ralf@oss.sgi.com) writes:

> (endianess should be considered per _thread_ on MIPS!)

I tried to ignore this, but I can't.  Ralf, what an elegant idea, but
it really doesn't make much sense.  

Ralf is influenced, I think, by the fact that MIPS CPUs have two
endianness switches: a "one-time" select which needs to match some of
the rest of the hardware in your system, and is picked at reset time,
and the very dodgy status register 'RE' bit.  RE ("reverse endianness
in user mode") bit was invented in a fit of madness for the MIPS
R4000.  It was intended to make it possible to run binaries from the
little-endian DECstation on a big-endian MIPS unix system.  As far as
I know, nobody ever did the software work to make such a thing happen,
so nobody really ever found out if it would have worked.

So yes, you could try to change the RE bit between threads... but
threads generally expect to be able to share code and data.  Now:

1. MIPS code is endianness-dependent (your big- and little-endian
   threads would require separate copies of any library function, for
   example);

2. MIPS data is endianness-dependent.  The endianness-switch uses
   cheap and simple hardware and produces particularly nasty effects.
   That's OK when you are just doing a one-time select (effectively,
   the memory system inherits the CPU's endianness, hiding the
   nastiness).

   But a big-endian and little-endian thread sharing data will see
   everything mangled; in fact they'll only show mutual comprehension
   of data consisting of aligned words (either 32-bit or 64-bit,
   according to the underlying CPU).  A feature which allows you to
   tell whether you've got a 64-bit CPU while running 32-bit code is
   not good.

3. The one-time endianness switch also controls some peripheral (chip
   interface) logic.  The memory controller has to know the CPU's
   endianness to decode bus cycles, so the RE bit presumably must
   leave this alone: though on the original R4000 it happened that it
   didn't matter so long as the backward code stayed in cache...  be
   that as it may, it means this whole thing is even more broken for
   64-bit CPUs on a 32-bit bus, for example.

So:

a) Any MIPS system really does have an endianness: the kernel always
   runs in it.  Since the kernel binary is already committed to either
   big- or little-endian, it really is fairly appropriate to have a
   compile-time flag to say which.

b) Dynamic endianness is just plausible on a unix process basis
   (thread + address space), as originally planned: but the amount of
   kernel re-writing involved, plus a complete second set of dynamic
   libraries, plus endless problem in I/O make it easy to see why it
   never got done.

   Dynamic endianness on a per-thread basis would require fantasy
   hardware which operates differently from the way MIPS chips do...

--
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / home: +44 20 7226 0032
http://www.algor.co.uk
