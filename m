Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 20:48:58 +0000 (GMT)
Received: from grayson.netsweng.com ([207.235.77.11]:30377 "EHLO
	grayson.netsweng.com") by ftp.linux-mips.org with ESMTP
	id S8135896AbVKHUsj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Nov 2005 20:48:39 +0000
Received: from amavis by grayson.netsweng.com with scanned-ok (Exim 3.36 #1 (Debian))
	id 1EZaPm-0006uV-00
	for <linux-mips@linux-mips.org>; Tue, 08 Nov 2005 15:49:58 -0500
Received: from grayson.netsweng.com ([127.0.0.1])
	by localhost (grayson [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26480-02 for <linux-mips@linux-mips.org>;
	Tue, 8 Nov 2005 15:49:49 -0500 (EST)
Received: from h168.98.28.71.ip.alltel.net ([71.28.98.168] helo=trantor.stuart.netsweng.com)
	by grayson.netsweng.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EZaPa-0006uR-00
	for <linux-mips@linux-mips.org>; Tue, 08 Nov 2005 15:49:47 -0500
Date:	Tue, 8 Nov 2005 15:49:45 -0500 (EST)
From:	Stuart Anderson <anderson@netsweng.com>
X-X-Sender: anderson@trantor.stuart.netsweng.com
To:	linux-mips@linux-mips.org
Subject: Re: Booting with NFS fails
In-Reply-To: <20051108070306.42611.qmail@web30703.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.61.0511081548190.3511@trantor.stuart.netsweng.com>
References: <20051108070306.42611.qmail@web30703.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at netsweng.com
Return-Path: <anderson@netsweng.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anderson@netsweng.com
Precedence: bulk
X-list: linux-mips


This looks consistant with the problem I have been seeing as well.


On Tue, 8 Nov 2005, Nguyen Thanh Binh wrote:

> Hi,
>
> I do not know if you could receive the complete boot
> log. I am resending that as follows:
>
> ====================================================
> loaded at:     00400000 004A01E4
> board data at: 0049D13C 0049D154
> relocated to:  00405650 00405668
> zimage at:     00405C1B 0049C4F1
> avail ram:     004A1000 04000000
>
>
> Linux/PPC load: console=ttyS0,9600 ip=on
> nfsroot=192.168.114.27:/home/memec/MyDwUncompressing
 	.
 	.
 	.
> Sending DHCP requests ., OK
> IP-Config: Got DHCP answer from 192.168.114.27, my
> address is 192.168.114.30
> IP-Config: Complete:
>      device=eth0, addr=192.168.114.30,
> mask=255.255.255.0, gw=192.168.114.27,
>     host=192.168.114.30, domain=, nis-domain=(none),
>     bootserver=192.168.114.27,
> rootserver=192.168.114.27, rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 192.168.114.27
> Looking up port of RPC 100005/1 on 192.168.114.27
> eth0: Link carrier lost.
> VFS: Mounted root (nfs filesystem).
> Mounted devfs on /dev
> Freeing unused kernel memory: 60k init
> eth0: Could not read PHY status register; error 1003
> eth0: Terminating link monitoring.
> ====================================================


                                 Stuart

Stuart R. Anderson                               anderson@netsweng.com
Network & Software Engineering                   http://www.netsweng.com/
1024D/37A79149:                                  0791 D3B8 9A4C 2CDC A31F
                                                  BD03 0A62 E534 37A7 9149
