Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 18:21:29 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:5504 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225432AbTLMSV2>; Sat, 13 Dec 2003 18:21:28 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.35 #1 (Debian))
	id 1AVENo-0001Ud-00; Sat, 13 Dec 2003 18:20:52 +0000
Date: Sat, 13 Dec 2003 18:20:52 +0000
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Peter Horton <phorton@bitbox.co.uk>, linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2 - area of problem
Message-ID: <20031213182052.GB480@skeleton-jack>
References: <3FD99C34.9090001@bitbox.co.uk> <20031213170751.GB13271@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213170751.GB13271@linux-mips.org>
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 13, 2003 at 06:07:51PM +0100, Ralf Baechle wrote:
> On Fri, Dec 12, 2003 at 10:45:08AM +0000, Peter Horton wrote:
> 
> > More info on the random segmentation faults and data corruption on my Qube2.
> > 
> > 2.4.21 from CVS is the first kernel to exhibit the problem. I tracked it 
> > down to the cache handling changes that went in between 2.4.20 and 2.4.21.
> > 
> > By (not very scientifically) removing flush_dcache_page() and 
> > re-instating flush_page_to_ram() I managed to get the 2.4.21 kernel 
> > stable (see attached patch). Applying a similiar patch to 2.4.23 (CVS 
> > HEAD) allows me to run 2.4.23 too.
> > 
> > I don't know how to track the problem any further - the kernel's cache 
> > handling is a bit out of my league.
> > 
> > Anyone got a clue stick they can point me in the right direction with ?
> 
> Can you put a printk into c-r4k.c and print the value of the
> shm_align_mask variable?  I want to make sure it's got a sane value on
> your box.  Also the first few lines of your bootup messages with the
> processor and cache stuff would be useful.
> 

See below. All the cache settings and the shm_align_mask look fine
according to the RM5231 data sheet I have here.

At the moment the only change I make from the linux_2_4 HEAD kernel is
to update include/asm-mips/cacheflush.h so:

-#define flush_page_to_ram(page)	do { } while(0)
+#define flush_page_to_ram(page)	flush_dcache_page(page)

This single change gives me a rock solid kernel, so it masks the problem
somehow.

P.

CPU revision is: 000028a0
FPU revision is: 000028a0
D-cache:
  size    32768
  linesz  32
  sets    512
  ways    2
  waysize 16384
  waybit  14
I-cache:
  size    32768
  linesz  32
  sets    512
  ways    2
  waysize 16384
  waybit  14
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB 2-way, linesize 32 bytes.
shm_align_mask 0x3fff
Linux version 2.4.23 (pdh@skeleton-jack) (gcc version 2.95.4 20011002 (Debian prerelease)) #6 Sat Dec 13 18:13:09 GMT 2003
Determined physical RAM map:
 memory: 02000000 @ 00000000 (usable)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 ide1=noprobe root=/dev/hda2 
ide_setup: ide1=noprobe
Calibrating delay loop... 249.03 BogoMIPS
Memory: 30380k/32768k available (1147k kernel code, 2388k reserved, 168k data, 100k init, 0k highmem)
...
