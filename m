Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57J5Gm04915
	for linux-mips-outgoing; Thu, 7 Jun 2001 12:05:16 -0700
Received: from debian (adsl-138-89-121-166.nnj.adsl.bellatlantic.net [138.89.121.166])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57J5Fh04912
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 12:05:16 -0700
Received: by debian (Postfix, from userid 1000)
	id D68122FD0; Thu,  7 Jun 2001 15:05:14 -0400 (EDT)
X-Draft-From: ("nnimap+dberlin.org:gdb" 2978)
To: Stan Shebs <shebs@apple.com>
Cc: "H . J . Lu" <hjl@lucon.org>, GDB <gdb@sourceware.cygnus.com>,
   binutils@lucon.org, linux-mips@oss.sgi.com
Subject: Re: stabs or ecoff for Linux/mips
References: <20010607093149.B13198@lucon.org> <3B1FCAC9.2110A024@apple.com>
From: Daniel Berlin <dan@cgsoftware.com>
Date: 07 Jun 2001 15:05:14 -0400
In-Reply-To: <3B1FCAC9.2110A024@apple.com> (Stan Shebs's message of "Thu, 07 Jun 2001 11:41:13 -0700")
Message-ID: <873d9cnmad.fsf@cgsoftware.com>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.5 (anise)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Stan Shebs <shebs@apple.com> writes:

> "H . J . Lu" wrote:
>> 
>> What is the better debug format for Linux/mips in the terms of gdb
>> and binutils, stabs or ecoff? I know the future is dwarf2. But I need
>> something stable now. Since Linux/x86 uses stabs, I lean toward to
>> stabs. Any comments?
> 
> Go with stabs and ELF.  Neither ecoff's base file format nor the debug
> info were particularly well-documented (I remember some of the bits in
> GNU being figured out by reverse engineering!), perpetuating it will
> just make your life more difficult in the long run.  It will also be
> easier to move to dwarf2 when the opportunity arises.

mdebugread is also an evil piece of code. 
It duplicates almost all of buildsym.  I've had to perform *major*
surgery (and am still not done yet) to do the block hash table thing.

> 
> Stan

-- 
"I looked out my apartment window, and I saw a bird wearing
sneakers and a button saying, "I ain't flying no where."  I
said, "What's your problem buddy?"  He said, "I'm sick of this
stuff -- winter here, summer there, winter here, summer there.
I don't know who thought this stuff up, but it certainly wasn't
a bird."  I said, "Well, I was just making breakfast, come on
in.  Want some eggs?  Sorry."
"-Steven Wright
