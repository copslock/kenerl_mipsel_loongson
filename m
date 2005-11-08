Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 07:02:15 +0000 (GMT)
Received: from web30703.mail.mud.yahoo.com ([68.142.200.136]:27760 "HELO
	web30703.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133364AbVKHHB4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Nov 2005 07:01:56 +0000
Received: (qmail 42613 invoked by uid 60001); 8 Nov 2005 07:03:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bymjyddgbjOQTKLhJLew7a/Uvyqe/vbcfjPnkyAFLVNqUiwbTGA4cp8rwyce/az+Qou8WE8+/n4Npd9Q+2pkcM3w+10MMy8el0fkh2c1VPHEvhoMkmebL3xC/g+szJFnUF3YsP6ET+t6KunElOsG6GR+EHV/OeNmGxh3V6rb9EA=  ;
Message-ID: <20051108070306.42611.qmail@web30703.mail.mud.yahoo.com>
Received: from [203.190.168.9] by web30703.mail.mud.yahoo.com via HTTP; Tue, 08 Nov 2005 07:03:06 GMT
Date:	Tue, 8 Nov 2005 07:03:06 +0000 (GMT)
From:	Nguyen Thanh Binh <n_tbinh@yahoo.com>
Subject: Re: Booting with NFS fails
To:	Manish Lachwani <m_lachwani@yahoo.com>, linux-mips@linux-mips.org
Cc:	mlachwani@mvista.com
In-Reply-To: <20051105090852.27444.qmail@web30904.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <n_tbinh@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n_tbinh@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I do not know if you could receive the complete boot
log. I am resending that as follows:

====================================================
loaded at:     00400000 004A01E4
board data at: 0049D13C 0049D154
relocated to:  00405650 00405668
zimage at:     00405C1B 0049C4F1
avail ram:     004A1000 04000000
                                                      
                         
Linux/PPC load: console=ttyS0,9600 ip=on
nfsroot=192.168.114.27:/home/memec/MyDwUncompressing
Linux...done.
Now booting the kernel
Linux version 2.4.20_mvl31-ml300 (memec@TTT) (gcc
version 3.3.1 (MontaVista 3.35Xilinx Virtex-II Pro
port (C) 2002 MontaVista Software, Inc.
(source@mvista.com)On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 ip=on
nfsroot=192.168.114.27:/home/memewXilinx INTC #0 at
0x41200000 mapped to 0xFDFFE000
Calibrating delay loop... 97.48 BogoMIPS
Memory: 63264k available (1068k kernel code, 368k
data, 60k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536
bytes)
Inode cache hash table entries: 4096 (order: 3, 32768
bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192
bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384
bytes)
Page-cache hash table entries: 16384 (order: 4, 65536
bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
OCP uart ver 1.6.2 init complete
LSP Revision 42
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
devfs: v1.12c (20020818) Richard Gooch
(rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no
serial options enabled
ttyS00 at 0xfdfff003 (irq = 26) is a 16450
RAMDISK driver initialized: 16 RAM disks of 8192K size
1024 blocksize
loop: loaded (max 8 devices)
eth0: using fifo mode.
eth0: Xilinx EMAC #0 at 0x80400000 mapped to
0xC500D000, irq=31
eth0: id 2.0a; block id 0, type 8
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
8192)
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.114.27, my
address is 192.168.114.30
IP-Config: Complete:
      device=eth0, addr=192.168.114.30,
mask=255.255.255.0, gw=192.168.114.27,
     host=192.168.114.30, domain=, nis-domain=(none),
     bootserver=192.168.114.27,
rootserver=192.168.114.27, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.114.27
Looking up port of RPC 100005/1 on 192.168.114.27
eth0: Link carrier lost.
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 60k init
eth0: Could not read PHY status register; error 1003
eth0: Terminating link monitoring.
====================================================



Thank you for your help.

Nguyen Binh

--- Manish Lachwani <m_lachwani@yahoo.com> wrote:

> Can you please post the complete boot log?
> 
> Thanks
> Manish Lachwani
> 
> --- Nguyen Thanh Binh <n_tbinh@yahoo.com> wrote:
> 
> > Hello all,
> > 
> > I have installed Red Hat Enterprise 3 on the host
> > (x86) and MontaVista Linux (previewkit) on the
> > target
> > (memec virtex-4 Fx12 LC board). When booting the
> > target using NFS from the host, the following
> error
> > appeared:
> > 
> >    eth0: Link carrier lost.
> >    eth0: Could not read PHY control register;
> error
> > 1003
> >    eth0: Terminating link monitoring.
> > 
> > It is very strange, because ethernet does not work
> > as
> > the error shows but I can ping the target from the
> > host with the IP got with DHCP.
> > 
> > Your help or experience would be appreciated.
> > 
> > Thank you.
> > 
> > Nguyen Binh
> > 
> > 
> > 
> > 		
> >
>
___________________________________________________________
> > 
> > How much free photo storage do you get? Store your
> > holiday 
> > snaps for FREE with Yahoo! Photos
> > http://uk.photos.yahoo.com
> > 
> > 
> 
> 
> 


Nguy&#7877;n Thanh Bình


		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
