Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TKu1nC028954
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 13:56:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TKu1Ro028953
	for linux-mips-outgoing; Wed, 29 May 2002 13:56:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TKtonC028948;
	Wed, 29 May 2002 13:55:50 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id NAA13994;
	Wed, 29 May 2002 13:57:10 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA07058;
	Wed, 29 May 2002 13:57:09 -0700 (PDT)
Message-ID: <01cb01c20754$4c14e400$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Justin Carlson" <justinca@cs.cmu.edu>, <linux-mips@oss.sgi.com>
Cc: <ralf@oss.sgi.com>
References: <1022691053.7644.16.camel@ldt-sj3-022.sj.broadcom.com> <1022700389.7644.155.camel@ldt-sj3-022.sj.broadcom.com>
Subject: Re: __flush_cache_all() miscellany
Date: Wed, 29 May 2002 23:03:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> While doing this, I've noticed that the whole mips tree is horribly
> inconsistent in terms of the cache flushing syscalls (sys_cacheflush and
> sys_sysmips->CACHE_FLUSH).  
> 
> Here's what the different ports appear to flush given one of these
> syscall:
> 
> andes:  l1 and l2
> lexra:  l1 icache
> mips32: l1 icache/dcache
> r3k:    l1 icache
> r4k:    l1 icache/dcache
> r5432:  l1 icache/dcache
> r5900:  l1 icache/dcache
> rm7k:   l1 icache/dcache
> sb1:    l1 icache/dcache
> sr7100: l1 and l2
> tx39:   l1 icache
> tx49:   li icache/dcache
> 
> Some of these are blatantly wrong with respect to the cacheflush
> syscall; it defines flags for flushing the icache, dcache, or both.  In
> the latter two cases, the lexra, r3k, and tx39 are not doing what was
> requested.  I doubt this matters for any significant userspace app, but
> it would be nice to at least be consistent.
> 
> As for the sysmips system call, I've  not been able to dig up the
> semantics.  (Actually, I don't really see why we have both ways of
> flushing the cache at all...some historical cruft?).  Anyone have a
> helpful pointer to docs on the subject?

I agree that things need to be straightened out a bit here,
or at least better documented, but things may not be as bad 
as you think, depending on the actual use of the system calls.  
Specifically, if what one is worried about is ensuring that a 
modification to memory gets picked up by the instruction 
stream, as in setting/clearing a breakpoint or executing a JIT,
one does not need to flush the dcache *if* the dcache
is write-through in the first place - as it is for most if
not all of the processors you list above as flushing the
icache only.  (As a parenthetical note, future MIPS
processors won't need a system call to deal with 
instruction stream modifications, but we need to deal
with the here-and-now).

While trampolines, breakpointing and JITing are the main 
uses of user-mode cache manipulation (drivers are a whole 
'nother story), we really should have distinct capabilities for 
I-stream modification and for explicit synchronizations of 
the data storage hierarchy, for non-coherent multiprocessors
and user-manipulated DMA buffers.  As to whether
those capabilities should be distinguished by system
call (sysmips vs. cacheflush) or by parameter to the
same system call, I don't have enough data to form
an opinion at this point.

            Kevin K.
