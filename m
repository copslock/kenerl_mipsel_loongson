Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA1ChUS07752
	for linux-mips-outgoing; Thu, 1 Nov 2001 04:43:30 -0800
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA1ChM007746
	for <linux-mips@oss.sgi.com>; Thu, 1 Nov 2001 04:43:23 -0800
Received: (qmail 1628 invoked from network); 1 Nov 2001 12:43:20 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 1 Nov 2001 12:43:20 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 5F4D8300090; Thu,  1 Nov 2001 23:43:15 +1100 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id E4E2E98; Thu,  1 Nov 2001 23:43:15 +1100 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: gdb@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: Stabs and discarded functions (was Re: Old bug with 'gdb/dbxread.c' and screwed up MIPS symbolic debugging...) 
In-reply-to: Your message of "Wed, 31 Oct 2001 17:47:49 CDT."
             <20011031174749.A28985@nevyn.them.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Nov 2001 23:43:10 +1100
Message-ID: <30951.1004618590@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 31 Oct 2001 17:47:49 -0500, 
Daniel Jacobowitz <dan@debian.org> wrote:
>Now, there's two things wrong here.  One of them is the bad value.  I
>think that I've already seen this problem, and that it has something to
>do with the way stabs are and used to be emitted.  packet_exit is
>presumably in the .text.exit section, which is presumably the problem. 
>Before linking, the stab looked like:
>
>2971   FUN    0      1870   0000000000000000 159366 packet_exit:f(0,20)
>
>and had a relocation:
>0000000000008b58 R_MIPS_32         .text.exit
>unless I miss my guess.
>
>So it looks like binutils did not relocate the stabs for .text.exit properly.
>
>Why?  It's pretty simple; there was nothing to relocate it to.  From the
>kernel's linker script:
>
>  /* Sections to be discarded */
>  /DISCARD/ :
>  {
>        *(.text.exit)
>        *(.data.exit)
>        *(.exitcall.exit)
>  }
>
>So instead of the subtle error we get in objfiles containing multiple
>sections, which we'll still need to deal with for the kernel for
>.text.init, we have a completely bogus result.
>
>We need to discard the stabs records for discarded symbols.

The problem is worse than stabs.  If a function is marked __exit _and_
some code in another section refers to that function then :-

* ld resolves the reference as offset xxx from the start of section
  .text.exit which is expected to get a decent start address.
* Section .text.exit is discarded, giving it a zero start address.
* The function call ends up as a branch to _address_ xxx.

This is a silent bug on many architectures, it only bites when the
__exit function is called, usually on a rarely tested error path.  On
architectures that use PC relative branches (such as IA64), the linker
may not be able to fit a PC relative branch from the high kernel
address to the low (and incorrect) xxx address into an instruction so
it gets an error during link.  Section .data.exit is even worse, most
references to data are via full word pointers and the bug is silent
again.

ld should probably discard sections and all symbols in those sections
before resolving external references.
