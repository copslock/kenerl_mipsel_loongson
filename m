Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA17397; Thu, 29 May 1997 23:47:05 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA15287 for linux-list; Thu, 29 May 1997 23:46:24 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA15277 for <linux@engr.sgi.com>; Thu, 29 May 1997 23:46:21 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id XAA23842
	for <linux@engr.sgi.com>; Thu, 29 May 1997 23:46:20 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id CAA10358 for linux@engr.sgi.com; Fri, 30 May 1997 02:44:23 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705300644.CAA10358@neon.ingenia.ca>
Subject: network troubles
To: linux@cthulhu.engr.sgi.com
Date: Fri, 30 May 1997 02:44:23 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I'm trying to get some sort of non-ping, non-NFS traffic working on
the Indy, and I'm having a lot of trouble doing it.

The interface is properly configured (root is NFS mounted, right?),
and I can ping the machine just fine.

When I start up inetd, though, netstat -an shows the telnet and
echo/tcp services as being _UDP_.  Telnetting to either port results
in a refused connection.

My protocols file looks like:

#
# protocols	This file describes the various protocols that are
#		available from the TCP/IP subsystem.  It should be
#		consulted instead of using the numbers in the ARPA
#		include files, or, worse, just guessing them.
#
# Version:	@(#)/etc/protocols	2.00	04/30/93
#
# Author:	Fred N. van Kempen, <waltje@uwalt.nl.mugnet.org>
#

ip	0	IP	# internet protocol, pseudo protocol number
icmp	1	ICMP	# internet control message protocol
igmp	2	IGMP	# internet group multicast protocol
ggp	3	GGP	# gateway-gateway protocol
tcp	6	TCP	# transmission control protocol
pup	12	PUP	# PARC universal packet protocol
udp	17	UDP	# user datagram protocol
idp	22	IDP	# WhatsThis?
raw	255	RAW	# RAW IP interface

# End of protocols.

inetd.conf is:
telnet	stream  tcp 	nowait  root    /usr/sbin/in.telnetd telnetd
echo	stream	tcp	nowait	root	internal
echo	stream	udp	nowait	root	internal

and the netstat output is:
Active Internet connections (including servers)
Proto Recv-Q Send-Q Local Address           Foreign Address     State      
udp        0      0 bogomips:600            neon:nfs            ESTABLISHED 
udp        0      0 *:23                    *:*                 UNKNOWN     
udp        0      0 *:echo                  *:*                 UNKNOWN     
raw        0      0 *:1                     *:*                             
Active UNIX domain sockets (including servers)
Proto RefCnt Flags       Type       State         I-Node Path

When I try to tftp out to neon (which is how I get my kernel, so in
theory...), I get:
tftp: sendto: Reserved error 136

Any ideas?  I'm using davem's 2.0.12 kernel, but I can't imagine why
the TCP stuff in the kernel wouldn't work, if the NFS-Root stuff
does...

Mike

-- 
#> Mike Shaver (shaver@ingenia.com)      Information Warfare Division  
#> Chief Tactical and Strategic Officer         "Saepe fidelis"        
#>                                                                     
#> "I like your game, but we have to change the rules." -- Anon        
#>                                                                     
