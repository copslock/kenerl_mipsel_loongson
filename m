Received:  by oss.sgi.com id <S553817AbQJ1Iok>;
	Sat, 28 Oct 2000 01:44:40 -0700
Received: from fte036.mc2.chalmers.se ([129.16.41.199]:15623 "EHLO
        fte036.mc2.chalmers.se") by oss.sgi.com with ESMTP
	id <S553722AbQJ1IoV>; Sat, 28 Oct 2000 01:44:21 -0700
Received: from fte004 (fte004.mc2.chalmers.se [129.16.41.163])
	by fte036.mc2.chalmers.se (8.9.3 (PHNE_18979)/8.9.3) with SMTP id KAA22588;
	Sat, 28 Oct 2000 10:51:37 +0200 (METDST)
Message-ID: <007801c040bb$7fc5def0$a3291081@mc2.chalmers.se>
From:   "Erik Aderstedt" <erik@ic.chalmers.se>
To:     "Joe Berens" <jberens@sgi.com>, <linux-mips@oss.sgi.com>
References: <Pine.SGI.4.10.10010271233390.241075-100000@jberens.americas.sgi.com>
Subject: Re: Installing linux on Indy
Date:   Sat, 28 Oct 2000 10:46:00 +0200
Organization: Solid State Electronics Laboratory
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2014.211
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2014.211
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

The portmapper isn't running on your system. I'm not an expert, 
I just know that I got a lot of RPC-related errors due to
portmap not running.

If you are booting from a RedHat system please note that
due to some misconfiguration (at least in 6.1) portmap will 
not be running after you've booted the system , even though
you may have installed it.

Finally, make sure that nfsd and mountd are both running on
your host.

/Erik
erik@ic.chalmers.se

----- Original Message ----- 
From: Joe Berens <jberens@sgi.com>
To: <linux-mips@oss.sgi.com>
Sent: Friday, October 27, 2000 7:46 PM
Subject: Installing linux on Indy


> Hello,
> 
> I have followed the installation instructions and I think every thing is
> set up right.  When I do "boot -f bootp()<ipaddr of
> server>:/<hardhatdir>/vmlinux", the kernel seems to start booting and
> hangs after:
> 
> Partition check: sda1 sda2 sda3 sda4
> Looking up port of RPC 100003/2 on <ipaddr of server>
> RPC: sendmsg returned error 128
> RPC: sendmsg returned error 128
> RPC: sendmsg returned error 128
> RPC: sendmsg returned error 128
> portmap: server <ip addr of server> not responding, timed out
> Root-Nfs: Unable to get nfsd port number from server, using default
> Looking up port of RPC 100005/1 on <ipaddr of server>
> RPC: sendmsg returned error 128
> 
> 
> Then it seems to hang for ever.
> Any help is greatly appreciated.
> 
> Thank you,
> 
> Joe
> ___________________________________
> 
> Joe Berens
> SGI Customer Support Center
> Operating Systems Group
> Phone: 800-800-4744, Direct: 651-683-3254
> Email: jberens@sgi.com
> 
> ___________________________________
> 
> 
> 
