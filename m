Received:  by oss.sgi.com id <S42318AbQFTMXz>;
	Tue, 20 Jun 2000 05:23:55 -0700
Received: from mail.exfo.com ([206.191.88.36]:47370 "EHLO mail.exfo.com")
	by oss.sgi.com with ESMTP id <S42229AbQFTMXj>;
	Tue, 20 Jun 2000 05:23:39 -0700
Received: from exfo.com ([172.16.46.216]) by mail.exfo.com
          (Netscape Messaging Server 3.62)  with ESMTP id 152
          for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 08:21:45 -0400
Message-ID: <394F62E6.50B7F424@exfo.com>
Date:   Tue, 20 Jun 2000 08:26:14 -0400
From:   "Philippe Chauvat" <philippe.chauvat@exfo.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To:     Linux Mips <linux-mips@oss.sgi.com>
Subject: [Kernel Panic]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello there,

I made a mistake. It's not an Challenge but an Indy station. This is a
part of the real message. Please, let me know if some information are
missing. The version of vmlinux is the HardRat one.

>>> Begin

Primary o,struction cache
Primary data cache
Secondary data cache
Linux version 2.1
MC: SG memory controller revision 3
[...]
Partition check
sda: sda1 sda2 sda3
Looking up port RPC 100003/2 on 192.0.2.1
Looking up port on RPC 100005/1 on 192.0.2.1
VFS: mounted root (nfs filesystem)
Adv: done running setup()
Freeing unused kernel memory: 44k freed
pag fault from irq handler: 0000
$0 : 00000000 [...]
$4 : 00000000 [...]
[...]
$20: 00000000 88009d90 0000000e 880e3f38
epc: 880e3e74
Status: 1004fc02
Cause : 0000000
Aiee, killing interrupt handler
Kernel panic: Attempted to kill idle task!
In swapper task - not syncing

<<< End

After that, I've dowloaded a new version of kernel for Indy
(ftp://ftp.foobazco.org/pub/people/wesolows/mips-linux/kernels/,
information found on this list) but now the problem is a /tmp creation
(Create 100Mb partition on ramdisk...)

Thank you for any help.

Philippe
