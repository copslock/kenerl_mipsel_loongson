Received:  by oss.sgi.com id <S553786AbQK3Gro>;
	Wed, 29 Nov 2000 22:47:44 -0800
Received: from mail.netunlimited.net ([208.128.132.4]:53519 "EHLO
        mail.netunlimited.net") by oss.sgi.com with ESMTP
	id <S553780AbQK3GrY>; Wed, 29 Nov 2000 22:47:24 -0800
Received: from localhost (jesse@localhost)
	by mail.netunlimited.net (8.9.3/8.9.3) with ESMTP id BAA02083;
	Thu, 30 Nov 2000 01:48:37 -0500
Date:   Thu, 30 Nov 2000 01:48:36 -0500 (EST)
From:   Jesse Dyson <jesse@winston-salem.com>
X-Sender: jesse@mail.netunlimited.net
To:     linux-mips@oss.sgi.com
cc:     jesse@winston-salem.com
Subject: Indigo2 Kernel Boots!!!
Message-ID: <Pine.LNX.4.10.10011300139280.32603-100000@mail.netunlimited.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
I have an Indigo2.  I have tftp/dhcp(bootp)/nfs configured correctly (I
think).  I am using the hardhat-5.1-sgi.tar.gz distribution and the kernel
vmlinux-2.2.14-r4x00-cvs.ecoff.

I am using the monitor commands:
unsetenv netaddr (dur to DHCP bug)
boot bootp():/vmlinux nfsroot=208.128.132.35:/home/jdyson/sgi-linux/mipseb

/vmlinux is a symbolic link to vmlinux-2.2...

I have the distribution in the mipseb folder (RedHat is a subdirectory of
mipseb).  I think this is right.

When I run this the kernel seems to start up (finds hardware, etc).
Connects to the root filesystem...The last message I get is "Warning:
unable to open an initial console"

I have removed the graphics card from the machine (evidently the vx
frame-buffer card is a problem).  I am connected to the serial port to get
access to command monitor, etc.

Anybody have any suggestions on what to do next or what I am doing wrong.
Thank you in advance for your time; and thanks guys for helping me get to
this point.

Thanks,
Jesse Dyson
