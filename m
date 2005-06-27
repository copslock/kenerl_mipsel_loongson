Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 14:18:07 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:22282 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225956AbVF0NRt>; Mon, 27 Jun 2005 14:17:49 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2F062E1C8A; Mon, 27 Jun 2005 15:17:12 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19038-09; Mon, 27 Jun 2005 15:17:12 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BFDB9E1C79; Mon, 27 Jun 2005 15:17:11 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5RDH6Lu018450;
	Mon, 27 Jun 2005 15:17:06 +0200
Date:	Mon, 27 Jun 2005 14:17:13 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Markus Dahms <mad@automagically.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
In-Reply-To: <20050627100757.GA27679@gaspode.automagically.de>
Message-ID: <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl>
References: <20050627100757.GA27679@gaspode.automagically.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/958/Mon Jun 27 00:22:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 27 Jun 2005, Markus Dahms wrote:

> I'm trying to run a current 2.6 kernel (LinuxMIPS CVS) on my
> Indy(s). It should be a 64-bit kernel (just for fun, but I tried
> 32-bit, too). From the mailing list archives some time ago (about
> half a year) I learned that there are known problems.
> 
> My experiments: Indy with R4600PC (133MHz) boots to userspace
> 
> | ...
> | EXT3-fs: mounted filesystem with ordered data mode.
> | atkbd.c: keyboard reset failed on hpc3ps2/serio0
> | VFS: Mounted root (ext3 filesystem) readonly.
> | Freeing unused kernel memory: 204k freed
> | INIT: version 2.86 booting
> 
> and dies then :(. The same machine, but with a R4000PC (100MHz)

 Hmm, it might be a problem with TLB handlers that have been changed to be 
built at the run time.  Perhaps the R4600 isn't handled right as a result.  
What's the CPU revision ID? -- it's printed right at the beginning.

> processor module doesn't even come so far:
> 
> | arcsboot: ARCS Linux ext2fs loader 0.3.8.6
> |
> | Loading 2.6.12-64 from scsi(0)disk(2)rdisk(0)partition(0)
> | Allocated 0x38 bytes for segments
> | Loading 64-bit executable
> | Loading program segment 1 at 0x88004000, offset=0x0 4000, size = \
> | 0x0 3c4086
> | 3c0000      (cache: 95.3%)Zeroing memory at 0x883c8086, size = \
> | 0x42f9a
> | Starting ELF64 kernel
> 
> no more action at this point....

 Strange.  The system should be capable enough for early printk() to be 
trivially implemented using firmware call-backs.  It would be more useful 
to get some feedback from it this way, otherwise it's asking for a crystal 
ball (mine is currently being serviced, if you recall)...  It's probably a 
BUG() or an Oops somewhere.  It might be related to the lack of an S-cache 
on this system -- there's been another report recently about it being a 
problem on a different machine -- try the patch sent there as a test.

  Maciej
