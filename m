Received:  by oss.sgi.com id <S553793AbQK3HxO>;
	Wed, 29 Nov 2000 23:53:14 -0800
Received: from natmail2.webmailer.de ([192.67.198.65]:710 "EHLO
        post.webmailer.de") by oss.sgi.com with ESMTP id <S553789AbQK3HxE>;
	Wed, 29 Nov 2000 23:53:04 -0800
Received: from scotty.mgnet.de (p3E9B81D9.dip.t-dialin.net [62.155.129.217])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id IAA12324
	for <linux-mips@oss.sgi.com>; Thu, 30 Nov 2000 08:53:06 +0100 (MET)
Received: (qmail 28505 invoked from network); 30 Nov 2000 07:53:02 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 30 Nov 2000 07:53:02 -0000
Date:   Thu, 30 Nov 2000 08:53:03 +0100 (CET)
From:   Klaus Naumann <spock@mgnet.de>
To:     Jesse Dyson <jesse@winston-salem.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Indigo2 Kernel Boots!!!
In-Reply-To: <Pine.LNX.4.10.10011300139280.32603-100000@mail.netunlimited.net>
Message-ID: <Pine.LNX.4.21.0011300851400.28990-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 30 Nov 2000, Jesse Dyson wrote:

> Hi,
> I have an Indigo2.  I have tftp/dhcp(bootp)/nfs configured correctly (I
> think).  I am using the hardhat-5.1-sgi.tar.gz distribution and the kernel
> vmlinux-2.2.14-r4x00-cvs.ecoff.
> 
> I am using the monitor commands:
> unsetenv netaddr (dur to DHCP bug)
> boot bootp():/vmlinux nfsroot=208.128.132.35:/home/jdyson/sgi-linux/mipseb
> 
> /vmlinux is a symbolic link to vmlinux-2.2...
> 
> I have the distribution in the mipseb folder (RedHat is a subdirectory of
> mipseb).  I think this is right.
> 
> When I run this the kernel seems to start up (finds hardware, etc).
> Connects to the root filesystem...The last message I get is "Warning:
> unable to open an initial console"

If you're booting the kernel with serial console you have to
link /dev/console to /dev/ttyS0 - see also Pitfalls section in the
Linux on Indigo2 HOWTO (http://oss.sgi.com/mips/i2-howto.html)

		CU, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
