Received:  by oss.sgi.com id <S42304AbQFVQXR>;
	Thu, 22 Jun 2000 09:23:17 -0700
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:47296 "EHLO
        mta03-svc.ntlworld.com") by oss.sgi.com with ESMTP
	id <S42191AbQFVQXK>; Thu, 22 Jun 2000 09:23:10 -0700
Received: from icserver.ichilton.co.uk ([62.252.240.59])
          by mta03-svc.ntlworld.com
          (InterMail vM.4.01.02.27 201-229-119-110) with ESMTP
          id <20000622162300.CIRG290.mta03-svc.ntlworld.com@icserver.ichilton.co.uk>
          for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 17:23:00 +0100
Received: from ian (ian.ichilton.local [192.168.0.8])
	by icserver.ichilton.co.uk (8.10.2/8.10.1) with SMTP id e5MGLJZ00702
	for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 17:22:19 +0100
From:   "Ian Chilton" <mailinglist@ichilton.co.uk>
To:     "Linux-MIPS Mailing List" <linux-mips@oss.sgi.com>
Subject: RE: Bootp Problems
Date:   Thu, 22 Jun 2000 17:21:20 +0100
Message-ID: <NAENLMKGGBDKLPONCDDOAEOMCNAA.mailinglist@ichilton.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4132.2800
In-Reply-To: <NAENLMKGGBDKLPONCDDOEENNCNAA.mailinglist@ichilton.co.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I have just had a thought and tried disabling the firewall on this machine,
and now get I:

[SNIP OK STUFF]
eth0: SGI Seeq8003 08:00:69:08:2c:d1
Sending BOOTP requests.....OK
IP-Config: Got BOOTP Answer from 192.168.0.1, my address is 192.168.0.12
Partition check:
sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
sdb: sdb1 sdb2 sdb3
Looking up port of RPC 100003/2 on 192.168.0.1
Looking up port of RPC 100005/1 on 192.168.0.1
Root-NFS: Unable to get nfsd port number from server, using default
mount: RPC call returned error 146
RPC: talk of released request still queued!
RPC: (task is on xprt_pending)
Root-NFS: Server returned error -146 while mounting /export/simple
VFS: Unable to mount root fs via NFS, trying floppy
VFS: Cannot open root device 02:00
Kernel Panic: VFS: Unable to mount root device on 02:00


Better than before, anyway!


Bye for Now,

Ian


                     \|||/
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
