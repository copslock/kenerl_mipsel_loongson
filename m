Received:  by oss.sgi.com id <S553827AbQJ0RrX>;
	Fri, 27 Oct 2000 10:47:23 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:33571 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553822AbQJ0RrM>;
	Fri, 27 Oct 2000 10:47:12 -0700
Received: from zeus-fddi.americas.sgi.com (zeus-fddi.americas.sgi.com [128.162.8.103]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA29437
	for <linux-mips@oss.sgi.com>; Fri, 27 Oct 2000 10:39:23 -0700 (PDT)
	mail_from (jberens@sgi.com)
Received: from poppy-e185.americas.sgi.com (poppy.americas.sgi.com [128.162.185.207]) by zeus-fddi.americas.sgi.com (8.9.3/americas-smart-nospam1.1) with ESMTP id MAA7439346 for <linux-mips@oss.sgi.com>; Fri, 27 Oct 2000 12:45:55 -0500 (CDT)
Received: from jberens.americas.sgi.com (jberens.americas.sgi.com [128.162.186.11]) by poppy-e185.americas.sgi.com (980427.SGI.8.8.8/SGI-server-1.7) with ESMTP id MAA08145 for <linux-mips@oss.sgi.com>; Fri, 27 Oct 2000 12:45:55 -0500 (CDT)
Date:   Fri, 27 Oct 2000 12:46:13 -0500
From:   Joe Berens <jberens@sgi.com>
X-Sender: jberens@jberens.americas.sgi.com
To:     linux-mips@oss.sgi.com
Subject: Installing linux on Indy
Message-ID: <Pine.SGI.4.10.10010271233390.241075-100000@jberens.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I have followed the installation instructions and I think every thing is
set up right.  When I do "boot -f bootp()<ipaddr of
server>:/<hardhatdir>/vmlinux", the kernel seems to start booting and
hangs after:

Partition check: sda1 sda2 sda3 sda4
Looking up port of RPC 100003/2 on <ipaddr of server>
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
portmap: server <ip addr of server> not responding, timed out
Root-Nfs: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on <ipaddr of server>
RPC: sendmsg returned error 128


Then it seems to hang for ever.
Any help is greatly appreciated.

Thank you,

Joe
___________________________________

Joe Berens
SGI Customer Support Center
Operating Systems Group
Phone: 800-800-4744, Direct: 651-683-3254
Email: jberens@sgi.com

___________________________________
