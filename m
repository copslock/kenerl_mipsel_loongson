Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5H15cY02800
	for linux-mips-outgoing; Sat, 16 Jun 2001 18:05:38 -0700
Received: from boss.zie.pg.gda.pl (boss.zie.pg.gda.pl [153.19.163.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5H15ZZ02796
	for <linux-mips@oss.sgi.com>; Sat, 16 Jun 2001 18:05:36 -0700
Received: from team.pld.org.pl (team.pld.org.pl [153.19.163.20])
	by boss.zie.pg.gda.pl (8.9.1b+Sun/8.8.7) with ESMTP id DAA18503
	for <linux-mips@oss.sgi.com>; Sun, 17 Jun 2001 03:05:29 +0200 (MET DST)
Received: by team.pld.org.pl (Postfix, from userid 1023)
	id 168CF2989E; Sun, 17 Jun 2001 02:58:32 +0200 (CEST)
Date: Sun, 17 Jun 2001 02:58:32 +0200
From: "Maciej Agaran' Pijanka" <agaran@team.pld.org.pl>
To: linux-mips@oss.sgi.com
Subject: kernel 2.2.14 (cvs from oss.sgi.com) and compile problems
Message-ID: <20010617025832.A18403@team.pld.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hello

im trying to recompile 2.2.14 from cvs (khmm 10 h ago cvsed, branch
linux_2_2 )
and have problem with make boot

mipsel-linux-ld -static -N -G 0 -T arch/mips/ld.script.little -Ttext 0x80040000 arch/mips/kernel/head.o arch/mips/kernel/init_task.o
ini
t/main.o init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/mips/dec/dec.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.a drivers/misc/misc.a drivers/net/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a
dr
ivers/video/video.a drivers/tc/tc.a \
        arch/mips/lib/lib.a /home/users/pld/agaran/cvs/linux_2_2/lib/lib.a arch/mips/dec/prom/rexlib.a \
        --end-group \
        -o vmlinux
drivers/char/char.a(tty_io.o): In function `tty_set_ldisc':
tty_io.c(.text.init+0x338): undefined reference to `kbd_init'
tty_io.c(.text.init+0x338): relocation truncated to fit: R_MIPS_26 kbd_init
drivers/char/char.a(console.o): In function `redraw_screen':
console.c(.text+0x1510): undefined reference to `compute_shiftstate'
console.c(.text+0x1510): relocation truncated to fit: R_MIPS_26 compute_shiftstate
drivers/char/char.a(console.o): In function `set_mode':
console.c(.text+0x2ec8): undefined reference to `kbd_table'
console.c(.text+0x2ed0): undefined reference to `kbd_table'


and some info about kernel config and compiler


egrep "^#|^$" .config
CONFIG_EXPERIMENTAL=y
CONFIG_DECSTATION=y
CONFIG_CPU_R3000=y
CONFIG_CPU_LITTLE_ENDIAN=y
CONFIG_ELF_KERNEL=y
CONFIG_BINFMT_ELF=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_TC=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_PARIDE_PARPORT=m
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IPV6=m
CONFIG_IPV6_EUI64=y
CONFIG_IPV6_NO_PB=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_DECNCR=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_PPP=m
CONFIG_DECLANCE=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_ZS=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32
CONFIG_PROC_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_CROSSCOMPILE=y


mipsel-linux-gcc -v
Reading specs from /home/users/pld/agaran/lib/gcc-lib/mipsel-linux/egcs-2.90.27/specs
gcc version egcs-2.90.27 980315 (egcs-1.0.2 release)


-- 
Maciej 'Agaran' Pijanka
agaran@team.pld.org.pl
