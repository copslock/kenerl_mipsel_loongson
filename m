Received:  by oss.sgi.com id <S553967AbQKFAEo>;
	Sun, 5 Nov 2000 16:04:44 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:29196 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553964AbQKFAEh>;
	Sun, 5 Nov 2000 16:04:37 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id A29C57CF1; Mon,  6 Nov 2000 00:04:35 +0000 (GMT)
Date:   Mon, 6 Nov 2000 00:04:35 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Problem Compiling 2.2.14 CVS after enabling NFSROOT
Message-ID: <20001106000435.A5550@woody.ichilton.co.uk>
Reply-To: ian@ichilton.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am trying to compile 2.2.14 from CVS.

I compiled it serveral times with no problem, and it booted my local system, but would not boot my nfsroot. Then I found the NFSROOT option, so I enabled that, and comipled the kernel again, and this time it failed:

make[1]: Leaving directory `/usr/src/linux-2.2.14/arch/mips/lib'
ld -static -G 0 -T arch/mips/ld.script.big -Ttext 0x88002000 arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.a drivers/misc/misc.a drivers/net/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a drivers/sgi/sgi.a drivers/video/video.a \
        arch/mips/lib/lib.a /usr/src/linux/lib/lib.a arch/mips/sgi/kernel/sgikern.a arch/mips/arc/arclib.a \
        --end-group \
        -o vmlinux
fs/filesystems.a(nfs.o): In function `nfs_read_super':
inode.c(.text.init+0x614): undefined reference to `rpc_getport_external'
inode.c(.text.init+0x614): relocation truncated to fit: R_MIPS_26 rpc_getport_external
make: *** [vmlinux] Error 1
bash-2.04# 


What have I done?  :)
 

Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
