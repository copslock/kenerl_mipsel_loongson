Received:  by oss.sgi.com id <S553813AbQJ1DOg>;
	Fri, 27 Oct 2000 20:14:36 -0700
Received: from u-162.karlsruhe.ipdial.viaginterkom.de ([62.180.18.162]:35336
        "EHLO u-162.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553682AbQJ1DOQ>; Fri, 27 Oct 2000 20:14:16 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870710AbQJ1DN0>;
        Sat, 28 Oct 2000 05:13:26 +0200
Date:   Sat, 28 Oct 2000 05:13:26 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Joe Berens <jberens@sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Installing linux on Indy
Message-ID: <20001028051326.B5764@bacchus.dhis.org>
References: <Pine.SGI.4.10.10010271233390.241075-100000@jberens.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.SGI.4.10.10010271233390.241075-100000@jberens.americas.sgi.com>; from jberens@sgi.com on Fri, Oct 27, 2000 at 12:46:13PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 27, 2000 at 12:46:13PM -0500, Joe Berens wrote:

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

128 = ENETUNREACH.  Sure your network configuration is correct and both
client and server are on the same subnet?

  Ralf
