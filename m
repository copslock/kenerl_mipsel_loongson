Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA01031; Thu, 3 Apr 1997 10:13:57 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA27375 for linux-list; Thu, 3 Apr 1997 10:13:18 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA27360 for <linux@relay.engr.SGI.COM>; Thu, 3 Apr 1997 10:13:14 -0800
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id KAA21583 for <linux@relay.engr.SGI.COM>; Thu, 3 Apr 1997 10:13:05 -0800
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id UAA13926
	for <linux@relay.engr.SGI.COM>; Thu, 3 Apr 1997 20:09:00 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id UAA21447 for linux@relay.engr.SGI.COM; Thu, 3 Apr 1997 20:10:35 +0200
Message-Id: <199704031810.UAA21447@kernel.panic.julia.de>
Subject: Re: The Indy has landed...
To: linux@cthulhu.engr.sgi.com
Date: Thu, 3 Apr 1997 20:10:35 +0200 (MET DST)
In-Reply-To: <199704031612.LAA16242@neon.ingenia.ca> from "Mike Shaver" at Apr 3, 97 11:12:26 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> [shaver@neon shaver]$ telnet bogomips
> Trying 205.207.220.72...
> Connected to bogomips.ingenia.com.
> Escape character is '^]'.
> 
> 
> IRIX (bogomips.ingenia.com)

(Hope this is R4600 - otherwise BogoMIPS won't be too impressive ...)

> login: root
> Password:
> IRIX Release 6.2 IP22 bogomips
> Copyright 1987-1996 Silicon Graphics, Inc. All Rights Reserved.
> Last login: Thu Apr  3 07:18:17 PST 1997 on :0
> bogomips 1# w
>   8:07am  up 50 mins,  2 users,  load average: 0.38, 0.25, 0.10
> User     tty from            login@   idle   JCPU   PCPU  what
> demos    q0  :0.0            8:02am      4                -csh
> root     q1  205.207.220.57  8:06am                       w
> bogomips 2# 
> 
> It would seem, ladies and gentlemen, that we're off to the races!
> After the conference sessions tonight I'll see about setting up the
> tftpboot stuff.  (Tips welcome!)

Assuming you're using a Linux box as TFTP Server here are old versions of
my config files.  Iff(OS != Linux) while(1){swear();rtfm(damn);swear()} ;-)

--- /etc/bootptab ------------------------------------------------------------

# /etc/net/bootptab: database for bootp server (/usr/net/in.bootpd)
# Last update Mon 11/7/88 18:03
# Blank lines and lines beginning with '#' are ignored.
#
# Legend:
#
#	first field -- hostname
#			(may be full domain name and probably should be)
#
#	hd -- home directory
#	bf -- bootfile
#	cs -- cookie servers
#	ds -- domain name servers
#	gw -- gateways
#	ha -- hardware address
#	ht -- hardware type
#	im -- impress servers
#	ip -- host IP address
#	lg -- log servers
#	lp -- LPR servers
#	ns -- IEN-116 name servers
#	rl -- resource location protocol servers
#	sm -- subnet mask
#	tc -- template host (points to similar host entry)
#	to -- time offset (seconds)
#	ts -- time servers
#
# Be careful about including backslashes where they're needed.  Weird (bad)
# things can happen when a backslash is omitted where one is intended.
#

# First, define a global entry which specifies the stuff every host uses.
# NOTE: THE VALUES BELOW ARE MEANT AS AN EXAMPLE!
#allhost:hd=/tmp:bf=null:\
#	:ds=145.71.35.1 145.71.32.1:\
#	:sm=255.255.254.0:\
#	:gw=145.71.35.1:\
#	:ts=145.71.35.1:\
#	:lp=145.71.35.1:\
#	:to=-7200:

# Define all individual entries.
#hostname:ht=1:ha=ether_addr_in_hex:ip=ip_addr_in_dec:tc=allhost:

#
#
#
.diskless:bf=null:\
	:sm=255.255.255.0:\
	:to=7200:

mipsy:hd=/tftpboot/193.98.169.17/:\
	:rp=/tftpboot/193.98.169.17/:\
	:ht=ethernet:\
	:ha=004095e11dc2:\
	:ip=193.98.169.17:\
	:tc=.diskless:

#mipsy:hd=/tftpboot/194.121.228.22/:\
#	:rp=/tftpboot/194.121.228.22/:\
#	:ht=ethernet:\
#	:ha=004095e11dc2:\
#	:ip=194.121.228.22:\
#	:tc=.diskless:

-- snipet from /etc/inetd.conf -----------------------------------------------

bootps dgram   udp     wait    root    /usr/sbin/tcpd  /usr/sbin/in.bootpd

(My bootpd (probably from Slackware 2.0 or 3.0) had to be replaced; it
wasn't working at all ...)

------------------------------------------------------------------------------

/tftpboot/193.98.169.17/ is Mipsy's NFS root, 004095e11dc2 it's 48 bit
Ethernet hardware address.  Note that the kernel makes some assumptions
about where the NFS root is on the server (/tftpboot/<ip>); if you
change that you need to pass some kernel options.  My setup is such
that I don't need to pass any options at all.

Does that help?

  Ralf
