Received:  by oss.sgi.com id <S553916AbQLQLM3>;
	Sun, 17 Dec 2000 03:12:29 -0800
Received: from mx.mips.com ([206.31.31.226]:8680 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553911AbQLQLMN>;
	Sun, 17 Dec 2000 03:12:13 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA02846;
	Sun, 17 Dec 2000 03:11:59 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA08671;
	Sun, 17 Dec 2000 03:11:56 -0800 (PST)
Received: from mips.com (coppccl [172.17.27.2])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id MAA08859;
	Sun, 17 Dec 2000 12:11:32 +0100 (MET)
Message-ID: <3A3C9EF0.435DA447@mips.com>
Date:   Sun, 17 Dec 2000 12:09:37 +0100
From:   Carsten Langgaard <carstenl@mips.com>
Organization: MIPS
X-Mailer: Mozilla 4.72 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: Little endian.
References: <3A3ABFA9.8608799D@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I guess, what you want to do is to install a little endian system from a
nfs-server, as you probably did with the bigendian system. If this is the
case then you shouldn't issue the 'go . root=/dev/sda1' command, as you
haven't installed the root filesystem yet.
Instead you should use this command: 'go . nfsroot=<ipaddr-of-nfsserver>
....'

/Carsten

Nicu Popovici wrote:

> Hello ,
>
> I have the follwing problem. I setup a HardHat distribution on a mips
> machine ( an ATLAS board) and everithing runs fine in big-endian mode.
> Now I want to run the board inlittle endian mode so I took the
> linux/mipsel distribution , I did the same steps as with big-endian
> distribution. I run load tftp:/linux/mipsel/vmlinux-el.srec and it works
> fine . Then I issue the command go . root=/dev/sda1 ( I do not install
> the HardHat again ???? maybe here it is the problem ) I get the
> following error.
> ==========================================================
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing prom memory: 1020k freed
> Freeing unused kernel memory: 68k freed
> Kernel panic: No init found.  Try passing init= option to kernel.
> ==========================================================
> So please tell me where did I go wrong ?
>
> Nicu
