Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5ABwjnC005067
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 10 Jun 2002 04:58:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5ABwjQQ005066
	for linux-mips-outgoing; Mon, 10 Jun 2002 04:58:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-56.ka.dial.de.ignite.net [62.180.196.56])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5ABwcnC005053
	for <linux-mips@oss.sgi.com>; Mon, 10 Jun 2002 04:58:40 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5ABxch20688
	for linux-mips@oss.sgi.com; Mon, 10 Jun 2002 13:59:38 +0200
Received: from dea.linux-mips.net (c-180-196-56.ka.dial.de.ignite.net [62.180.196.56])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5ABfanC004792
	for <linux-mips@oss.sgi.com>; Mon, 10 Jun 2002 04:41:37 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5AB6j519865;
	Mon, 10 Jun 2002 13:06:45 +0200
X-Authentication-Warning: dea.linux-mips.net: ralf set sender to ralf@uni-koblenz.de using -f
Subject: Re: R10K speculative store on non-coherent systems workaround
	proposal
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <Pine.LNX.4.21.0206080012470.2120-101000@melkor>
References: <Pine.LNX.4.21.0206080012470.2120-101000@melkor>
Content-Type: multipart/alternative; boundary="=-b/ZucXlTj8M9BXTILjaK"
Message-Id: <1023707152.18634.18.camel@dea.linux-mips.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 10 Jun 2002 13:06:45 +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-b/ZucXlTj8M9BXTILjaK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2002-06-08 at 00:15, Vivien Chappelier wrote:

> 	Here is a proposal for a software workaround to speculative
> execution on a non-coherent system such as the i2 R10k and the o2 R10k.
> 
> 1. Problem:
> ===========
> 
> 	The R10000 processor can (and will) execute intructions ahead.
> These instructions will be cancelled if they're not supposed to execute,
> e.g. if a jump happened. If a load or store instruction is executed
> speculatively, and the accessed memory is not in the cache, the cache
> line will be fetched in main memory and, on a store, be marked dirty.
> These speculative loads and stores can happen anywhere, since there might
> be old values in registers used in a speculative load/store
> instruction that would be cancelled afterwards.
> 
> The problem is:
> 	- on a speculative load, the fetched cache line will remain in the
> cache even if the speculative load is cancelled
> 	- on a speculative store, the *dirty* cache line will remain in
> the cache even if the speculative store is cancelled
> 
> 	On non-coherent systems we need to flush the cache lines to main
> memory before doing DMA to device, so that the device can see them. We
> also need to invalidate lines before reading from a DMA'd buffer to make
> sure the CPU will read main memory and not the cache.
> 	However, if a speculative load or store happens during DMA
> transfer, the cache line will be fetched from memory and, on a store, 
> be marked dirty. That means this cache line could be evicted when the
> line is needed, thus being written back in memory if it was dirty,
> thus overwritting the data a device could have put in the DMA
> buffer. Something we really don't want to happen ;)
> 
> 2. Proposed solution
> ====================
> 
> 	Speculative execution will not happen in the following conditions:
> 		- access to memory is uncached
> 		- the speculated instruction causes an exception: that
> also means a speculative load/store will not happen in a mapped memory
> region which doesn't have a TLB line for it.
> 
> 	This second point means that any mapped space can be made safe by
> removing the DMA'd buffer address translations from the TLB or by marking
> them 'uncached' during DMA transfer.
> 	The remaining unmapped adress spaces are:
> 		- kseg1, which is safe since uncached
> 		- kseg0, which can turned uncached with the K0 bits
> from the CPO Config register
> 		- xkphys which will cause adress error if the KX bit is
> not set, the aborting the speculative load/store before it can do harm ;)
> 
> 	Since we need to turn KX off, xkseg will not be accessible
> either.. and since we need to have KSEG0 uncached, we need to remap the
> kernel elsewhere if we want performance ;). We could use the xsseg
> segment, available in Supervisor mode, which is mapped (safe) and moreover
> allows to access all memory (on o2 it can be up to 2G I think, whereas in
> 32bit mode, only 512Mb would be accessible). So the proposed workaround is
> to permanently map the lower 16MB of memory in xsseg in using a wired TLB
> entry and a page size of 16MB. This memory would not be usable for
> DMA. Everything else would, so we could for example reserve the upper 16Mb
> for DMA (and give them to the DMA zoned memory allocator). On exception or
> error, the handler (in KSEG0) would set CU0 to allow access to CPO, then
> switch to Supervisor mode and jump to the equivalent xsseg location and
> continue execution in Supervisor mode. The code for returning to userland
> would need to clear the CU0 bit, to prevent user access to CP0.
> 	Before DMA transfer, the DMA'd buffer cache lines would be
> flushed, and then it would be remapped 'uncached', thus preventing that
> any speculative load or store to this memory happens during
> transfer. After the DMA transfer, the cache would be invalidated to make
> sure main memory is read, and the DMA buffer would be remapped 'cacheable
> non-coherent'.
> 	A diagram is attached to illustrate the workaround. Comments,
> suggestions (and even flames) are welcome before anyone starts coding
> the workaround ;)

Looks like a good start but unfortunately your concept is ignoring
userspace entirely.  You might have to deal with mmapped pages that are
being written to backing storage.  In such a case you'll have to
trackdown all mappings and disable access to them and that's something
that is pretty hard in the current memory managment code.  The solution
would be Rik's rmap patches which themselves are still under
development..  Intially I guess you can simply avoid this hairy job by
doing all DMA using bounce buffers only.  Expensive but doable ...

  Ralf

(Testing evolution ...)




--=-b/ZucXlTj8M9BXTILjaK
Content-Type: text/html; charset=utf-8

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/1.0.2">
</HEAD>
<BODY>
<PRE>On Sat, 2002-06-08 at 00:15, Vivien Chappelier wrote:

&gt; 	Here is a proposal for a software workaround to speculative
&gt; execution on a non-coherent system such as the i2 R10k and the o2 R10k.
&gt; 
&gt; 1. Problem:
&gt; ===========
&gt; 
&gt; 	The R10000 processor can (and will) execute intructions ahead.
&gt; These instructions will be cancelled if they're not supposed to execute,
&gt; e.g. if a jump happened. If a load or store instruction is executed
&gt; speculatively, and the accessed memory is not in the cache, the cache
&gt; line will be fetched in main memory and, on a store, be marked dirty.
&gt; These speculative loads and stores can happen anywhere, since there might
&gt; be old values in registers used in a speculative load/store
&gt; instruction that would be cancelled afterwards.
&gt; 
&gt; The problem is:
&gt; 	- on a speculative load, the fetched cache line will remain in the
&gt; cache even if the speculative load is cancelled
&gt; 	- on a speculative store, the *dirty* cache line will remain in
&gt; the cache even if the speculative store is cancelled
&gt; 
&gt; 	On non-coherent systems we need to flush the cache lines to main
&gt; memory before doing DMA to device, so that the device can see them. We
&gt; also need to invalidate lines before reading from a DMA'd buffer to make
&gt; sure the CPU will read main memory and not the cache.
&gt; 	However, if a speculative load or store happens during DMA
&gt; transfer, the cache line will be fetched from memory and, on a store, 
&gt; be marked dirty. That means this cache line could be evicted when the
&gt; line is needed, thus being written back in memory if it was dirty,
&gt; thus overwritting the data a device could have put in the DMA
&gt; buffer. Something we really don't want to happen ;)
&gt; 
&gt; 2. Proposed solution
&gt; ====================
&gt; 
&gt; 	Speculative execution will not happen in the following conditions:
&gt; 		- access to memory is uncached
&gt; 		- the speculated instruction causes an exception: that
&gt; also means a speculative load/store will not happen in a mapped memory
&gt; region which doesn't have a TLB line for it.
&gt; 
&gt; 	This second point means that any mapped space can be made safe by
&gt; removing the DMA'd buffer address translations from the TLB or by marking
&gt; them 'uncached' during DMA transfer.
&gt; 	The remaining unmapped adress spaces are:
&gt; 		- kseg1, which is safe since uncached
&gt; 		- kseg0, which can turned uncached with the K0 bits
&gt; from the CPO Config register
&gt; 		- xkphys which will cause adress error if the KX bit is
&gt; not set, the aborting the speculative load/store before it can do harm ;)
&gt; 
&gt; 	Since we need to turn KX off, xkseg will not be accessible
&gt; either.. and since we need to have KSEG0 uncached, we need to remap the
&gt; kernel elsewhere if we want performance ;). We could use the xsseg
&gt; segment, available in Supervisor mode, which is mapped (safe) and moreover
&gt; allows to access all memory (on o2 it can be up to 2G I think, whereas in
&gt; 32bit mode, only 512Mb would be accessible). So the proposed workaround is
&gt; to permanently map the lower 16MB of memory in xsseg in using a wired TLB
&gt; entry and a page size of 16MB. This memory would not be usable for
&gt; DMA. Everything else would, so we could for example reserve the upper 16Mb
&gt; for DMA (and give them to the DMA zoned memory allocator). On exception or
&gt; error, the handler (in KSEG0) would set CU0 to allow access to CPO, then
&gt; switch to Supervisor mode and jump to the equivalent xsseg location and
&gt; continue execution in Supervisor mode. The code for returning to userland
&gt; would need to clear the CU0 bit, to prevent user access to CP0.
&gt; 	Before DMA transfer, the DMA'd buffer cache lines would be
&gt; flushed, and then it would be remapped 'uncached', thus preventing that
&gt; any speculative load or store to this memory happens during
&gt; transfer. After the DMA transfer, the cache would be invalidated to make
&gt; sure main memory is read, and the DMA buffer would be remapped 'cacheable
&gt; non-coherent'.
&gt; 	A diagram is attached to illustrate the workaround. Comments,
&gt; suggestions (and even flames) are welcome before anyone starts coding
&gt; the workaround ;)

Looks like a good start but unfortunately your concept is ignoring
userspace entirely.  You might have to deal with mmapped pages that are
being written to backing storage.  In such a case you'll have to
trackdown all mappings and disable access to them and that's something
that is pretty hard in the current memory managment code.  The solution
would be Rik's rmap patches which themselves are still under
development..  Intially I guess you can simply avoid this hairy job by
doing all DMA using bounce buffers only.  Expensive but doable ...

  Ralf

(Testing evolution ...)


</PRE>
</BODY>
</HTML>

--=-b/ZucXlTj8M9BXTILjaK--
