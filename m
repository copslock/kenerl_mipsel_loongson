Received:  by oss.sgi.com id <S305154AbQDJXr3>;
	Mon, 10 Apr 2000 16:47:29 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:25645 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305157AbQDJXrH>; Mon, 10 Apr 2000 16:47:07 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA02464; Mon, 10 Apr 2000 16:50:59 -0700 (PDT)
	mail_from (owner-linux@sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA42362; Mon, 10 Apr 2000 16:46:36 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA33986
	for linux-list;
	Mon, 10 Apr 2000 16:26:03 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA37604;
	Mon, 10 Apr 2000 16:26:00 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id 07EE2A7904; Mon, 10 Apr 2000 15:22:37 -0700 (PDT)
Date:   Mon, 10 Apr 2000 15:22:36 -0700 (PDT)
From:   Ulf Carlsson <ulfc@sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: gdb cross-debugging for MIPS linux target
In-Reply-To: <38F252A4.21CF13E0@mvista.com>
Message-ID: <Pine.LNX.4.21.0004101517210.18203-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> Does anybody know if I can use gdb to cross-debug a MIPS/Linux target
> with i386/Linux host?
> 
> I downloaded gdb source and tried "./configure --target=mipsel-linux" on
> my i386/Linux host.  I got an error saying "mipsel-unknown-linux-gnu"
> not supported.
> 
> If such a port does not exist, can someone point to me a starting place
> where I can do the port myself?

I think there's a gdb tree in the CVS repository on oss.sgi.com.  Try to check
out the gdb module.  I have been using gdb to cross debug my MIPS machine so
it was at least functional last summer.  I have a patch that adds kdb support
do the MIPS kernel, but I don't think it's finished.  Scott Lurndal was
hacking on it a couple of months ago and I can send it to you if you're
interested.

Ulf
