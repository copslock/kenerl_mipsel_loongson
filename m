Received:  by oss.sgi.com id <S554046AbRBBPC4>;
	Fri, 2 Feb 2001 07:02:56 -0800
Received: from bastion.power-x.co.uk ([62.232.19.201]:49166 "EHLO
        bastion.power-x.co.uk") by oss.sgi.com with ESMTP
	id <S554024AbRBBPCo>; Fri, 2 Feb 2001 07:02:44 -0800
Received: from springhead.px.uk.com (IDENT:dg@springhead.px.uk.com [172.16.18.41])
	by bastion.power-x.co.uk (8.9.3/8.9.3) with ESMTP id PAA06849;
	Fri, 2 Feb 2001 15:02:25 GMT
Date:   Fri, 2 Feb 2001 15:03:11 +0000 (GMT)
From:   "Dr. David Gilbert" <gilbertd@treblig.org>
X-Sender:  <dg@springhead.px.uk.com>
To:     Carsten Langgaard <carstenl@mips.com>
cc:     <linux-mips@oss.sgi.com>
Subject: Re: Cross build applications
In-Reply-To: <3A7AC901.4BD0F4E0@mips.com>
Message-ID: <Pine.LNX.4.30.0102021502170.1654-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 2 Feb 2001, Carsten Langgaard wrote:

> I'm trying to cross build a small test program on a linux PC, but it
> fails.
>
> mips-linux-gcc -o test test.c
> /usr/mips-linux/bin/ld: cannot open crt1.o: No such file or directory

Yep - you need to obtain a copy of this - just copy it out of Linux/mips
installation and put it in one of the lib directories under your
/usr/mips-linux.

(That let me get "hello world" crossing from Linux/Alpha last week)

Dave
-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/
