Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7AIhIn19862
	for linux-mips-outgoing; Fri, 10 Aug 2001 11:43:18 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7AIhGV19859
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 11:43:16 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA09961;
	Fri, 10 Aug 2001 11:43:09 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA17161;
	Fri, 10 Aug 2001 11:43:06 -0700 (PDT)
Received: from copsun17.mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7AIfma13792;
	Fri, 10 Aug 2001 20:41:48 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun17.mips.com (8.9.1/8.9.0) id UAA01339;
	Fri, 10 Aug 2001 20:41:47 +0200 (MET DST)
Message-Id: <200108101841.UAA01339@copsun17.mips.com>
Subject: Re: about mips IDE DMA disk problem
To: ilya@theilya.com, linux-mips@oss.sgi.com
Date: Fri, 10 Aug 2001 20:41:47 +0200 (MET DST)
In-Reply-To: <01081011265403.07543@gateway> from "Ilya Volynets" at Aug 10, 2001 11:26:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

Ilya Volynets writes:

> > They're well aware of that - and working on 2.4
> Great! 'cause questions related to 2.2.12 kernel are becoming FAQ.

You can already find 2.4 kernels on ftp.mips.com:

ftp> pwd
257 "/pub/linux/mips/kernel/2.4" is current directory.
ftp> ls -R
227 Entering Passive Mode (206,31,31,227,157,126)
150 Opening ASCII mode data connection for /bin/ls.
total 4
-rw-r--r--   1 9618     40           1613 Jul  6 04:41 README
drwxr-xr-x   2 9618     40            512 Jul  6 05:26 images
drwxr-xr-x   2 9618     40            512 Jul  6 05:27 src

images:
total 8720
-rw-r--r--   1 9618     40        1103571 Mar 30 05:23 vmlinux-2.4.1.atlas.eb-01.00.srec.gz
-rw-r--r--   1 9618     40        1129920 Mar 30 05:23 vmlinux-2.4.1.atlas.el-01.00.srec.gz
-rw-r--r--   1 9618     40        1061736 Mar 30 05:23 vmlinux-2.4.1.malta.eb-01.00.srec.gz
-rw-r--r--   1 9618     40        1093062 Mar 30 05:23 vmlinux-2.4.1.malta.el-01.00.srec.gz
-rw-r--r--   1 9618     40        1116378 Jul  6 04:35 vmlinux-2.4.3.atlas.eb-01.00.srec.gz
-rw-r--r--   1 9618     40        1144798 Jul  6 04:35 vmlinux-2.4.3.atlas.el-01.00.srec.gz
-rw-r--r--   1 9618     40        1075193 Jul  6 04:35 vmlinux-2.4.3.malta.eb-01.00.srec.gz
-rw-r--r--   1 9618     40        1107586 Jul  6 04:35 vmlinux-2.4.3.malta.el-01.00.srec.gz
 
src:
total 50200
-rw-r--r--   1 9618     40       25100716 Mar 30 05:24 linux-2.4.1.mips-src-01.00.tar.gz
-rw-r--r--   1 9618     40       26239788 Jul  6 04:35 linux-2.4.3.mips-src-01.00.tar.gz
226 Transfer complete.
ftp>

/Hartvig


-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
