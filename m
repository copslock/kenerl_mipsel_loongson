Received:  by oss.sgi.com id <S553863AbQK3Okh>;
	Thu, 30 Nov 2000 06:40:37 -0800
Received: from mail.netunlimited.net ([208.128.132.4]:33039 "EHLO
        mail.netunlimited.net") by oss.sgi.com with ESMTP
	id <S553848AbQK3OkT>; Thu, 30 Nov 2000 06:40:19 -0800
Received: from localhost (jesse@localhost)
	by mail.netunlimited.net (8.9.3/8.9.3) with ESMTP id JAA07661;
	Thu, 30 Nov 2000 09:41:26 -0500
Date:   Thu, 30 Nov 2000 09:41:26 -0500 (EST)
From:   Jesse Dyson <jesse@winston-salem.com>
X-Sender: jesse@mail.netunlimited.net
To:     Klaus Naumann <spock@mgnet.de>
cc:     linux-mips@oss.sgi.com
Subject: Re: Indigo2 Kernel Boots!!!
In-Reply-To: <Pine.LNX.4.21.0011300851400.28990-100000@spock.mgnet.de>
Message-ID: <Pine.LNX.4.10.10011300938100.6504-100000@mail.netunlimited.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
I'm not exactly sure what this means to "link" /dev/console.  Based on the
FAQ (http://foobazco.org/~weslows/Install-HOWTO.html), I shouldn't have to
do the inittab stuff since I am in ser port 1.  I noticed I do not have an
/etc/inittab file in my root fs, but there is a inittabold.  Is there
something with these files I have to fix or do I do an 'ln -s' or
something on the /dev/console and point it to /dev/ttyS0?

Sorry for my ignorance.

Thanks for your help.

Thanks,
Jesse Dyson 

On Thu, 30 Nov 2000, Klaus Naumann wrote:

> On Thu, 30 Nov 2000, Jesse Dyson wrote:
> 
> > Hi,
> > I have an Indigo2.  I have tftp/dhcp(bootp)/nfs configured correctly (I
> > think).  I am using the hardhat-5.1-sgi.tar.gz distribution and the kernel
> > vmlinux-2.2.14-r4x00-cvs.ecoff.
> > 
> > I am using the monitor commands:
> > unsetenv netaddr (dur to DHCP bug)
> > boot bootp():/vmlinux nfsroot=208.128.132.35:/home/jdyson/sgi-linux/mipseb
> > 
> > /vmlinux is a symbolic link to vmlinux-2.2...
> > 
> > I have the distribution in the mipseb folder (RedHat is a subdirectory of
> > mipseb).  I think this is right.
> > 
> > When I run this the kernel seems to start up (finds hardware, etc).
> > Connects to the root filesystem...The last message I get is "Warning:
> > unable to open an initial console"
> 
> If you're booting the kernel with serial console you have to
> link /dev/console to /dev/ttyS0 - see also Pitfalls section in the
> Linux on Indigo2 HOWTO (http://oss.sgi.com/mips/i2-howto.html)
> 
> 		CU, Klaus
> 
> -- 
> Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
> Nickname    : Spock             | Org.: Mad Guys Network
> Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
> PGP Key     : www.mgnet.de/keys/key_spock.txt
> 
