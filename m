Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Sep 2002 22:20:45 +0200 (CEST)
Received: from place.org ([65.163.18.18]:65492 "EHLO zachs.place.org")
	by linux-mips.org with ESMTP id <S1122960AbSIIUUp>;
	Mon, 9 Sep 2002 22:20:45 +0200
Received: by zachs.place.org (Postfix, from userid 1002)
	id D9A6A182F9; Mon,  9 Sep 2002 15:20:36 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by zachs.place.org (Postfix) with ESMTP
	id 5BD3518187; Mon,  9 Sep 2002 15:20:36 -0500 (CDT)
Date: Mon, 9 Sep 2002 15:20:36 -0500 (CDT)
From: Jay Carlson <nop@nop.com>
X-X-Sender: nop@zachs.place.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020904155645.A31893@linux-mips.org>
Message-ID: <Pine.LNX.4.44.0209091445440.9959-100000@zachs.place.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <nop@nop.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nop@nop.com
Precedence: bulk
X-list: linux-mips

On Wed, 4 Sep 2002, Ralf Baechle wrote:

> #define __NR_uselib                     (__NR_Linux +  86)
>
> a.out support.  Do we really want that.

Well, it's support for Linux-a.out-style shared libraries, which are
actually binary-format independent.  Quick summary of how they work in
ELF:

The file argument to uselib must have 1 or 2 program headers.  Exactly
one of them must be PT_LOAD.  That segment is loaded at the fixed
virtual address specified in in the header.  It's marked readable,
writable, executable, and any BSS region is zeroed.

I contemplated using uselib(2) in snow and decided that I wanted
multiple segments to support text and rodata being read-only.  I
figured that attempting to communicate the read-only nature of the
maps to the VM could elicit more efficient behavior.

Anyway, now that we have ELF interpreters you can get one library
loaded into core for you by the kernel.  That library can define a
more reasonable version of uselib in userspace...

I guess my point is that even the tiny set of people doing statically
linked shared libraries will probably avoid this syscall.

Jay
