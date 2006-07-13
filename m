Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2006 17:44:43 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:18595 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133723AbWGMQoe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Jul 2006 17:44:34 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1G146a-00020q-00
	for <linux-mips@linux-mips.org>; Thu, 13 Jul 2006 18:32:00 +0200
Date:	Thu, 13 Jul 2006 18:32:00 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: Problems after merge to 2.6.18-rc1
Message-ID: <20060713163200.GA7186@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

I just finished a (big) merge with linux-mips 2.6.18-rc1 and
my tree and at boot I get:

   Linux version 2.6.18-rc1-g2636fd13-dirty (giometti@gundam) (gcc version 3.4.3) #165 Thu Jul 13 18:13:26 CEST 2006
   CPU revision is: 02030204
   Board WWPC1000 version 1.0
   WWPC-setup: uC=off 
   (PRId 02030204) @ 396MHZ
   BCLK switching enabled!
   Determined physical RAM map:
    memory: 04000000 @ 00000000 (usable)
   Early serial console at AU 0x11100000 (options '115200')
   Determined physical RAM map:
    memory: 04000000 @ 00000000 (usable)
   Built 1 zonelists.  Total pages: 16384
   Kernel command line: wwpc=uc-off console=uart,au,0x11100000,115200 root=/dev/nfs rw nfsroot=192.168.32.254:/homemipsel/distro/debian ip=192.168.32.24:192.168.32.254::255.255.255.0:000:eth0:off
   Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
   Primary data cache 16kB, 4-way, linesize 32 bytes.
   Synthesized TLB refill handler (17 instructions).
   Synthesized TLB load handler fastpath (34 instructions).
   Synthesized TLB store handler fastpath (34 instructions).
   Synthesized TLB modify handler fastpath (33 instructions).
   PID hash table entries: 1024 (order: 10, 4096 bytes)
   calculating r4koff... 00182b80(1584000)
   CPU frequency 396.00 MHz
   Console: colour dummy device 80x25
   Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
   Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
   Bad page state in process 'swapper'
   page:810092a0 flags:0x00000000 mapping:00000000 mapcount:1 count:0
   Trying to fix it up, but a reboot is needed
   Backtrace:
   Call Trace:
    [<8015d91c>] bad_page+0x6c/0xac
    [<8015e4c0>] free_hot_cold_page+0x190/0x1ec
    [<8046099c>] free_all_bootmem_core+0x1ec/0x228
    [<80457110>] mem_init+0x4c/0x218
    [<80462a50>] inode_init_early+0x68/0xbc
    [<804657d8>] console_init+0x48/0x68
    [<80450824>] start_kernel+0x208/0x400
    [<8045081c>] start_kernel+0x200/0x400
    [<80450134>] unknown_bootoption+0x0/0x310

   Bad page state in process 'swapper'
   page:810092c0 flags:0x00000000 mapping:00000000 mapcount:1 count:0
   Trying to fix it up, but a reboot is needed
   ...

Suggestions? :)

Thanks,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
