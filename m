Received:  by oss.sgi.com id <S553791AbQK3Hvp>;
	Wed, 29 Nov 2000 23:51:45 -0800
Received: from natmail2.webmailer.de ([192.67.198.65]:48068 "EHLO
        post.webmailer.de") by oss.sgi.com with ESMTP id <S553787AbQK3Hvc>;
	Wed, 29 Nov 2000 23:51:32 -0800
Received: from scotty.mgnet.de (p3E9B81D9.dip.t-dialin.net [62.155.129.217])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id IAA10718
	for <linux-mips@oss.sgi.com>; Thu, 30 Nov 2000 08:51:33 +0100 (MET)
Received: (qmail 28501 invoked from network); 30 Nov 2000 07:51:29 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 30 Nov 2000 07:51:29 -0000
Date:   Thu, 30 Nov 2000 08:51:30 +0100 (CET)
From:   Klaus Naumann <spock@mgnet.de>
To:     Calvine Chew <calvine@sgi.com>
cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: I'm stuck...
In-Reply-To: <43FECA7CDC4CD411A4A3009027999112267CAA@sgp-apsa001e--n.singapore.sgi.com>
Message-ID: <Pine.LNX.4.21.0011300847440.28990-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 30 Nov 2000, Calvine Chew wrote:

> Hi folks.

Hi there,

 
> I'm trying to get Linux up on an Indy. I'm using an old laptop to act as the
> tftp/bootp/nfs server. I've installed
> SuSE 6.4 on it and I am not sure if I've configured the server properly. I
  ^^^^-- This is your first mistake ... :)))
  .oO(I hope Andreas doesn't read that)

> try tftp'ing and bootp'ing from the server
> side, and both seem to respond to requests, however, when I try from the
> Indy client, the Indy just shoots back
> a "server not found for vmlinux" when I do "boot -f bootp():vmlinux".
> 
> How do I ensure that things on the server side are indeed configured
> properly? Are there proper tests I can do?
> For example, if I run "bootpd -s -d4" then run "bootptest", bootpd reports
> back a large number of things like
> sending the linux kernel I exported via NFS, and something about a magic
> number, then bootptest quits. tftp
> at the server side allows me to download files from the NFS directory.
> 
> I already have numerous copies of readmes teaching me how to install Linux
> on MIPS, but somehow all of them
> vary in many ways, especially the config parts. Is there some install readme
> for super-idiots like myself who need
> to be told word for word what to do?

I have written a HOWTO for Linux on the Indigo2 - it's now more and more
a HOWTO for installing Linux on any SGI box ;)
You can have a look at http://oss.sgi.com/mips/i2-howto.html
I hope this helps a bit. ALso please don't miss the Pitfalls section - 
maybe you're hitting one of the described.


		HTH, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
