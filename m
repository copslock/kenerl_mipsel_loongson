Received:  by oss.sgi.com id <S553771AbQLOROn>;
	Fri, 15 Dec 2000 09:14:43 -0800
Received: from router.isratech.ro ([193.226.114.69]:44806 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553767AbQLOROf>;
	Fri, 15 Dec 2000 09:14:35 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eBFHEI609804
	for <linux-mips@oss.sgi.com>; Fri, 15 Dec 2000 19:14:19 +0200
Message-ID: <3A3ABFA9.8608799D@isratech.ro>
Date:   Fri, 15 Dec 2000 20:04:42 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Little endian.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello ,

I have the follwing problem. I setup a HardHat distribution on a mips
machine ( an ATLAS board) and everithing runs fine in big-endian mode.
Now I want to run the board inlittle endian mode so I took the
linux/mipsel distribution , I did the same steps as with big-endian
distribution. I run load tftp:/linux/mipsel/vmlinux-el.srec and it works
fine . Then I issue the command go . root=/dev/sda1 ( I do not install
the HardHat again ???? maybe here it is the problem ) I get the
following error.
==========================================================
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 1020k freed
Freeing unused kernel memory: 68k freed
Kernel panic: No init found.  Try passing init= option to kernel.
==========================================================
So please tell me where did I go wrong ?

Nicu
