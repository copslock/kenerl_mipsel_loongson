Received:  by oss.sgi.com id <S553739AbQJUWi6>;
	Sat, 21 Oct 2000 15:38:58 -0700
Received: from smtp.screaming.net ([212.49.224.20]:63198 "EHLO
        smtp.screaming.net") by oss.sgi.com with ESMTP id <S553725AbQJUWie>;
	Sat, 21 Oct 2000 15:38:34 -0700
Received: from slitesys.demon.co.uk (root@dyn206-ras23.screaming.net [212.49.246.206])
	by smtp.screaming.net (8.9.3/8.9.3) with ESMTP id WAA10835;
	Sat, 21 Oct 2000 22:41:56 GMT
Received: from localhost (alistair@localhost)
	by slitesys.demon.co.uk (8.8.5/8.8.5) with SMTP id XAA16709;
	Sat, 21 Oct 2000 23:40:11 +0100
Date:   Sat, 21 Oct 2000 23:40:11 +0100 (BST)
From:   Alistair MacDonald <alistair@slitesys.demon.co.uk>
Reply-To: A.MacDonald@slitesys.demon.co.uk
To:     Budgester <budgester@budgester.com>
cc:     "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: Installing Linux on an Indy
In-Reply-To: <000601c03bac$d24a43f0$0300000a@budgester.com>
Message-ID: <Pine.LNX.3.96.1001021233117.26245D-100000@slitesys.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing



On Sat, 21 Oct 2000, Budgester wrote:
> I am trying to Install Linux on an INDY, but due to lack of knowledge and me
> being a bit of a newbie I am having problems.
> 
> I have a i386 server setup and as much documentation as I can find,
> 
> I am using the foobazco docs at the moment.
> 
> Could anyone point me in the right direction to solve the following problem.
> 
> Where do I find base.tar.gz ?

You can find the most recent versions of the code at:

ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/userland-0.2b

There isn't a base.tar.gz in the 'simple' system any more. I found that
for a diskless Indy I could just extract all these packages into one
directory and then mount that. You'll need the most recent kernel from: 

ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/kernels

as well. 

If you plan on running with this setup then you will probably want to
create a /tmp directory and a /var/log which appeared to be missing on
mine.

Alistair
