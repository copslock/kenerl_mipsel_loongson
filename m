Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 07:31:42 +0100 (BST)
Received: from bay1-f19.bay1.hotmail.com ([IPv6:::ffff:65.54.245.19]:9740 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225073AbTEIGbk>;
	Fri, 9 May 2003 07:31:40 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 8 May 2003 23:31:31 -0700
Received: from 4.35.224.219 by by1fd.bay1.hotmail.msn.com with HTTP;
	Fri, 09 May 2003 06:31:31 GMT
X-Originating-IP: [4.35.224.219]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Thu, 08 May 2003 23:31:31 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F19KkLxFjjBsVV00007bcf@hotmail.com>
X-OriginalArrivalTime: 09 May 2003 06:31:31.0864 (UTC) FILETIME=[A1493980:01C315F4]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

more info...

clipping from Linux startup messages:
-----------------------------------------------------
Root-NFS: Server returned error -13 while mounting /tftpboot/4.42.102.6

clipping from /var/log/messages:
--------------------------------------------
May  8 19:54:42 localhost rpc.mountd: refused mount request from 4.42.102.6 
for
/tftpboot/4.42.102.6 (/): no export entry


Why is Linux (running on the MIPS board) trying '/tftpboot/4.42.102.6'. 
Should it not try '/export/RedHat7.1'

Please let me know what is missing or what I should do to get passed this 
issue.

-Mike.


>From: "Michael Anburaj" <michaelanburaj@hotmail.com>
>To: jbglaw@lug-owl.de, linux-mips@linux-mips.org
>Subject: Re: Linux for MIPS Atlas 4Kc board
>Date: Thu, 08 May 2003 22:47:40 -0700
>
>Hi JBG,
>
>I have passed a static IP address as parameter.
>
>YAMON> go . nfsroot=4.42.102.7:/export/RedHat7.1 \
>? ip=4.42.102.6:4.42.102.7:4.42.102.1:255.255.252.0
>
>LINUX started...
>Config serial console: ttyS0,115200
>CPU revision is: 00018001
>Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 
>bytes.
>Primary data cache 16kB 4-way, linesize 16 bytes.
>Linux version 2.4.21-pre4 (root@localhost.localdomain) (gcc version 
>egcs-2.91.63Determined physical RAM map:
>memory: 00001000 @ 00000000 (reserved)
>memory: 000ef000 @ 00001000 (ROM data)
>memory: 00010000 @ 000f0000 (ROM data)
>memory: 001a4000 @ 00100000 (reserved)
>memory: 03d5c000 @ 002a4000 (usable)
>On node 0 totalpages: 16384
>zone(0): 16384 pages.
>zone(1): 0 pages.
>zone(2): 0 pages.
>Kernel command line: nfsroot=4.42.102.7:/export/RedHat7.1 
>ip=4.42.102.6:4.42.100calculating r4koff... 00061a83(400003)
>CPU frequency 80.00 MHz
>Calibrating delay loop... 79.66 BogoMIPS
>Memory: 62120k/62832k available (1308k kernel code, 712k reserved, 164k 
>data, 1)Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
>Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
>Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
>Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
>Checking for 'wait' instruction...  available.
>POSIX conformance testing by UNIFIX
>PCI: Probing PCI hardware on host bus 0.
>PCI: device 01:06.0 has unknown header type 7f, ignoring.
>PCI: device 01:0b.0 has unknown header type 7f, ignoring.
>PCI: device 01:0d.0 has unknown header type 7f, ignoring.
>PCI: device 01:0f.0 has unknown header type 7f, ignoring.
>Linux NET4.0 for Linux 2.4
>Based upon Swansea University Computer Society NET3.039
>Initializing RT netlink socket
>Starting kswapd
>pty: 256 Unix98 ptys configured
>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
>SERIAL_PCI edttyS00 at 0x1f000900 (irq = 0) is a 16550A
>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>loop: loaded (max 8 devices)
>Found SAA9730 (PCI) at 0x10800000, irq 16.
>SCSI subsystem driver Revision: 1.00
>ncr53c8xx: at PCI bus 0, device 16, function 0
>ncr53c8xx: 53c810a detected
>ncr53c810a-0: rev 0x12 on pci bus 0 device 16 function 0 irq 17
>ncr53c810a-0: ID 7, Fast-10, Parity Checking
>scsi0 : ncr53c8xx-3.4.3b-20010512
>NET4: Linux TCP/IP 1.0 for NET4.0
>IP Protocols: ICMP, UDP, TCP, IGMP
>IP: routing cache hash table of 512 buckets, 4Kbytes
>TCP: Hash tables configured (established 4096 bind 4096)
>IP-Config: Complete:
>      device=eth0, addr=4.42.102.6, mask=255.255.252.0, gw=4.42.102.1,
>     host=4.42.102.6, domain=, nis-domain=(none),
>     bootserver=4.42.102.7, rootserver=4.42.102.7, rootpath=
>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>Looking up port of RPC 100003/2 on 4.42.102.7
>Looking up port of RPC 100005/1 on 4.42.102.7
>Root-NFS: Server returned error -13 while mounting /export/RedHat7.1
>VFS: Unable to mount root fs via NFS, trying floppy.
>VFS: Cannot open root device "" or 02:00
>Please append a correct "root=" boot option
>Kernel panic: VFS: Unable to mount root fs on 02:00
>
>Let me why NFS server is returning error -13.
>
>Thanks,
>-Mike.
>
>
>>From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
>>To: linux-mips@linux-mips.org
>>Subject: Re: Linux for MIPS Atlas 4Kc board
>>Date: Thu, 8 May 2003 23:40:57 +0200
>>
>>On Thu, 2003-05-08 10:02:54 -0700, Michael Anburaj 
>><michaelanburaj@hotmail.com>
>>wrote in message <BAY1-F17fJpbi7Phnzi00006011@hotmail.com>:
>> > Hi JBG,
>> >
>> > The MIPS box (Atlas running YAMON) has a fixed IP address assigned by 
>>me.
>> > TFTP boot works fine. But this IP is held within the boot monitor 
>>program
>> > (YAMON).
>> >
>> > YAMON> set
>>[...]
>>
>>That doesn't help you. This is yamon, it's not Linux:)
>>
>> > Apart from the dynamic IP address assignment methods....
>> > Suggest me a method to communicate this value to the RAM resident Linux
>> > kernel. Or can I assign a fixed IP addredd by passing it as a parameter
>>
>>Look at ./linux/net/ipv4/ipconfig.c
>>
>> > when the linux kernel boots up? If so what is the syntax & please point 
>>me
>>
>>Yes.
>>
>> > to the document that has this info. about passed parameter when booting 
>>the
>>
>>The source file is the document, syntax is described there, too.
>>
>> > kernel.
>>
>>Please answer under old emails, not above them.
>>
>>HTH, JBG
>>
>>--
>>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen 
>>Krieg
>>     fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im 
>>Irak!
>>       ret = do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | 
>>TCPA));
>><< attach3 >>
>
>_________________________________________________________________
>Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
>http://join.msn.com/?page=features/junkmail
>
>

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*.  
http://join.msn.com/?page=features/featuredemail
