Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 13:52:31 +0100 (BST)
Received: from cygnus.izmiran.rssi.ru ([IPv6:::ffff:193.232.24.21]:22440 "EHLO
	cygnus.izmiran.rssi.ru") by linux-mips.org with ESMTP
	id <S8225407AbVEFMwQ>; Fri, 6 May 2005 13:52:16 +0100
Received: from [127.0.0.1] (IDENT:10003@localhost [127.0.0.1])
	by cygnus.izmiran.rssi.ru (8.12.4/8.12.4) with ESMTP id j46Cpwcs014527
	for <linux-mips@linux-mips.org>; Fri, 6 May 2005 16:52:04 +0400
Date:	Fri, 6 May 2005 15:53:22 +0300
From:	"Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: "Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
Organization: Home
X-Priority: 3 (Normal)
Message-ID: <261758805.20050506155322@izmiran.rssi.ru>
To:	linux-mips@linux-mips.org
Subject: dbau1200 ethernet driver?
MIME-Version: 1.0
Content-Type: text/plain; charset=Windows-1251
Content-Transfer-Encoding: 8bit
Return-Path: <jerry@izmiran.rssi.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry@izmiran.rssi.ru
Precedence: bulk
X-list: linux-mips


  Hi!

 I compiled last 2.6 kernel (2-3 weeks ago from cvs@linux-mips) and
trying to start it on DBAu1200 development board. First problem I
discovered with "nfsroot" configuration - is that kernel cannot find
network interface at boot-time.
 There is a smc91c111 network chip on board, so my question is - what
driver is suitable with him? Is it "MIPS AU1000 Ethernet support"
which fails to compile with "error: `NUM_ETH_INTERFACES' undeclared"
(and it must be?) or something different? It seems that I have enabled
all other options for ethernet functionality.


the part of boot log is:

loop: loaded (max 8 devices)
nbd: registered device at major 43
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: No network devices available.
Looking up port of RPC 100003/2 on 192.168.0.30
RPC: sendmsg returned error 128
portmap: RPC call returned error 128
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.0.30
RPC: sendmsg returned error 128
portmap: RPC call returned error 128
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 128
mount: RPC call returned error 128


   ()_()
--( °,° )---[21398845]-[jerry¤wicomtechnologies.com]-
  (") (")                 -<The Bat! 3.0.1.33>- -<06/05/2005 15:35>-
