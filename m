Received:  by oss.sgi.com id <S553791AbQLSRD0>;
	Tue, 19 Dec 2000 09:03:26 -0800
Received: from mail.ivm.net ([62.204.1.4]:53799 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553783AbQLSRDT>;
	Tue, 19 Dec 2000 09:03:19 -0800
Received: from franz.no.dom (port53.duesseldorf.ivm.de [195.247.65.53])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id SAA21034;
	Tue, 19 Dec 2000 18:02:53 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.001219180300.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20001219134828.A361@katze.cyrius.com>
Date:   Tue, 19 Dec 2000 18:03:00 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Martin Michlmayr <tbm@cyrius.com>
Subject: Re: Kernel Oops when booting on DECstation
Cc:     linux-mips@oss.sgi.com, Florian Lohoff <flo@rfc822.org>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 19-Dec-00 Martin Michlmayr wrote:
[Oops on DECstation boot on a /125]

> I compiled a current CVS kernel (as of 2000-Dec-18) and I still get
> the same problem:
> 
> KN02-BA V5.7e    (PC: 0xbfc00cbc, SP: 0xa000f404)
> ^C
>>>boot 3/rz2/vmlinux root=/dev/sda1 console=ttyS2
>>> NetBSD/pmax Secondary Boot, Revision 1.0
>>> (root@vlad, Sat Mar  4 14:34:30 EST 2000)
[...]

> The config file used to build the kernel is enclosed below.

Strange, I am not able to reproduce this here on a /133 (KN02-BA V5.7j).
My box boots just fine.

>>boot 3/tftp/vmlinux.r3k console=ttyS2 root=/dev/sda7                         
1597440+134048+143008                                                          
This DECstation is a DS5000/1xx                                                
Loading R[23]00 MMU routines.                                                  
CPU revision is: 00000230                                                      
Primary instruction cache 64kb, linesize 4 bytes                               
Primary data cache 128kb, linesize 4 bytes                                     
Linux version 2.4.0-test11 (harry@intel) (gcc version egcs-2.91.66 19990314
Determined physical RAM map:                                               
     memory: 03000000 @ 00000000 (usable)                                      
[...]
VFS: Mounted root (ext2 filesystem) readonly.                                
Freeing unused PROM memory: 124k freed                                       
Freeing unused kernel memory: 60k freed                                      
INIT: version 2.74 booting                                                   
Activating swap partitions
hostname: localhost
Checking root filesystems.                                                     
[...]    

Is anybody else successfully using the NetBSD bootloader with a Linux kernel?

-- 
Regards,
Harald
