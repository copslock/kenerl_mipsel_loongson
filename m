Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g798f9Rw002080
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 01:41:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g798f909002079
	for linux-mips-outgoing; Fri, 9 Aug 2002 01:41:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from cmsoutbound.mx.net (cmsrelay05.mx.net [165.212.11.2])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g798exRw002070
	for <linux-mips@oss.sgi.com>; Fri, 9 Aug 2002 01:40:59 -0700
Received: from uadvg143.cms.usa.net (HELO localhost) (165.212.11.143)
  by cmsoutbound.mx.net with SMTP; 9 Aug 2002 08:42:48 -0000
Received: from uwdvg002.cms.usa.net [165.212.8.2] by uadvg143.cms.usa.net via mtad (CM.0402.2.02C) 
	with ESMTP id 665gHiiQQ0510M43; Fri, 09 Aug 2002 08:42:42 GMT
Message-ID: <20020809084304.20279.qmail@uwdvg002.cms.usa.net>
Received: from 213.84.222.138 [213.84.222.138] by uwdvg002.cms.usa.net 
	(USANET web-mailer CM.0402.1.07D); Fri, 09 Aug 2002 08:43:04 -0000
Date: Fri, 09 Aug 2002 10:43:04 +0200
From: Sander Wichers <wichers@usa.net>
To: <linux-mips@oss.sgi.com>
Subject: What cvs branch to use to compile mips64?
X-Mailer: USANET web-mailer (CM.0402.1.07D)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g798exRw002071
X-Spam-Status: No, hits=-0.1 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, 
 
 
I'm "trying" to compile a mips 64 kernel for a IP28 Indigo 2 R10000 
(using the default binutils and egcs from oss.sgi.com) 
 
 
The default cvs branch will not link (even with minimal config options 
selected). The scsi wd93 driver in that branch will not compile at all.. 
 
 
So I tried the linux_2_5_[1/2] branches which compile completely but 
don't link: 
 
 
arch/mips64/mm/mm.o: In function `local_flush_tlb_mm': 
andes.c(.text+0x11f4): undefined reference to `flush_icache_all' 
arch/mips64/mm/mm.o: In function `local_flush_tlb_range': 
andes.c(.text+0x1374): undefined reference to `flush_icache_all' 
kernel/kernel.o: In function `schedule': 
sched.c(.text+0xfcc): undefined reference to `flush_icache_all' 
kernel/kernel.o: In function `set_cpus_allowed': 
sched.c(.text+0x1a54): undefined reference to `flush_icache_all' 
kernel/kernel.o: In function `end_lazy_tlb': 
exit.c(.text+0x6748): undefined reference to `flush_icache_all' 
fs/fs.o(.text+0xba98):exec.c: more undefined references to 
`flush_icache_all' follow 
fs/fs.o: In function `nfs_read_super': 
inode.c(.text+0x3a244): undefined reference to `nfs_v3_clientops' 
inode.c(.text+0x3a248): undefined reference to `nfs_v3_clientops' 
fs/fs.o: In function `nfs_async_unlink': 
unlink.c(.text+0x40310): undefined reference to `BUG' 
fs/fs.o: In function `unlock_buffer': 
buffer.c(.data+0x2f84): undefined reference to `nfs_version3' 
fs/fs.o: In function `invalidate_bdev': 
buffer.c(.data+0x3eb4): undefined reference to `nlmsvc_procedures4' 
fs/fs.o: In function `balance_dirty_state': 
buffer.c(.data+0x4854): undefined reference to `nlm_version4' 
arch/mips/sgi-ip22/ip22-kern.o: In function `indy_rtc_set_time': 
ip22-time.c(.text.init+0xd84): undefined reference to `bcops' 
ip22-time.c(.text.init+0xd88): undefined reference to `bcops' 
arch/mips64/arc/arclib.a(misc.o): In function `ArcHalt': 
misc.c(.text+0x0): undefined reference to `bcops' 
misc.c(.text+0x4): undefined reference to `bcops' 
arch/mips64/arc/arclib.a(misc.o): In function `ArcPowerDown': 
misc.c(.text+0x6c): undefined reference to `bcops' 
arch/mips64/arc/arclib.a(misc.o)(.text+0x70):misc.c: more undefined 
references to `bcops' follow 
drivers/char/char.o: In function `write_mem': 
mem.c(.text.init+0x138): undefined reference to `serial_console_init' 
net/network.o: In function `move_addr_to_user': 
socket.c(.text.init+0x78): undefined reference to `init_netlink' 
make: *** [vmlinux] Error 1 
 
 
Am I doing something wrong? Do I have the correct branch? Or do I need 
some patches? 
 
 
thanks in advance, 
 
 
Sander 
 
