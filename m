Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 23:35:42 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:61706 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133567AbWAXXfX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 23:35:23 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E0AC464D40; Tue, 24 Jan 2006 23:39:08 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id A177F8D5E; Tue, 24 Jan 2006 23:38:46 +0000 (GMT)
Date:	Tue, 24 Jan 2006 23:38:46 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: check of endianess?
Message-ID: <20060124233846.GA10784@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I just compiled a kernel for SGI IP32 and got some very interesting
results when booting it: 0 MHz CPU, no RAM... Later I found out that
I made a copy&paste typo in my build script and used mipsel-linux-cc
to compile.  Shouldn't this be detected earlier on?

 Linux version 2.6.15 (tbm@deprecation) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #6 Tue Jan 24 22:57:52 GMT 2006
 ARCH: SGI-IP32
 PROMLIB: ARC firmware Version 0 Revision 0
 CRIME id 0 rev 0 at 0x14000000
 CRIME MC: bank 0 base 0x0000000000000000 size 32MiB
 CRIME MC: bank 0 base 0x0000000002000000 size 32MiB
 CRIME MC: bank 0 base 0x0000000004000000 size 32MiB
 CRIME MC: bank 0 base 0x0000000006000000 size 32MiB
 CRIME MC: bank 0 base 0x0000000008000000 size 32MiB
 CRIME MC: bank 0 base 0x000000000a000000 size 32MiB
 CPU revision is: 00000000
 FPU revision is: 00000000
 Determined physical RAM map:
  memory: c000000 @ 0 (usable)
 Built 0 zonelists
 Kernel command line: 
 Primary instruction cache 32kB, physically tagged, 2-way, linesize 0 bytes.
 Primary data cache 32kB, 2-way, linesize 0 bytes.
 R5000 SCACHE size 512kB, linesize 32 bytes.
 Synthesized TLB refill handler (0 instructions).
 Synthesized TLB load handler fastpath (0 instructions).
 Synthesized TLB store handler fastpath (0 instructions).
 Synthesized TLB modify handler fastpath (0 instructions).
 PID hash table entries: 0 (order: 0, 32768 bytes)
 Calibrating system timer... 0 MHz CPU detected
 Using 0.000 MHz high precision timer.
 Console: colour dummy device 0x0
 CRIME memory error at 0x3fffffe0 ST 0x0400a828<INV,RE,REID=0x28,NONFATAL>
 Dentry cache hash table entries: 0 (order: 0, 262144 bytes)
 Inode-cache hash table entries: 0 (order: 0, 131072 bytes)
 Memory: 0k/196608k available (3015k kernel code, 7288k reserved, 737k data, 192k init, 0k highmem)

-- 
Martin Michlmayr
http://www.cyrius.com/
