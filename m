Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2005 23:18:46 +0000 (GMT)
Received: from sccrmhc13.comcast.net ([204.127.202.64]:15597 "EHLO
	sccrmhc13.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133631AbVKEXS3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Nov 2005 23:18:29 +0000
Received: from [192.168.1.15] (pcp04414054pcs.nrockv01.md.comcast.net[69.140.185.48])
          by comcast.net (sccrmhc13) with ESMTP
          id <2005110523192001300bf0s1e>; Sat, 5 Nov 2005 23:19:25 +0000
Message-ID: <436D3DF7.5000002@gentoo.org>
Date:	Sat, 05 Nov 2005 18:19:19 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS - 64bit woes
References: <436D0061.5070100@jg555.com>
In-Reply-To: <436D0061.5070100@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Jim Gifford wrote:
> I've been working on getting the RaQ2 to work with the current 2.6.14 
> kernel, but no luck at all. The last success I had was with 2.6.12.x 
> series.
> 
> I'm looking for ideas, patches or whatever to get this working again. I 
> know it has to do with the kernel using 32bit addressing instead of 64 
> bit, but have no clue where to start.
> 
> Here is what I get when I attempt to boot it.
> 
>  > nfs 172.16.0.1 /nfsroot boot/vmlinux-2.6.14.gz
> nfs: mounted "/nfsroot"
> nfs: lookup "boot"
> nfs: lookup "vmlinux-2.6.14.gz"
> nfs: mode <0100755>
> 1349KB loaded (899KB/sec)
> 001512e8 1381096t
> nfs: unmounted "/nfsroot"
>  > execute root=/dev/nfs nfsroot=172.16.0.1:/nfsroot 
> console=ttyS0,115200 ip=dhcp
> elf64: 00080000 - 003b901f (ffffffff.80357000) (ffffffff.80000000)
> elf64: ffffffff.80080000 (80080000) 3170438t + 208794t
> net: interface down
> 
> Thanx for all your assistance.

Hmm, I'm unable to boot a 64bit kernel on either IP27 or IP30 here.  Appears to 
die very early in the kernel code.  It looks like your kernel also dies before 
doing anything meaningful, so I wonder if this is some common thing.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
