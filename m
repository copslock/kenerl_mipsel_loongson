Received:  by oss.sgi.com id <S554051AbQLBKe5>;
	Sat, 2 Dec 2000 02:34:57 -0800
Received: from adsl-61-8-131.mia.bellsouth.net ([208.61.8.131]:44805 "EHLO
        spawn.hockeyfiend.com") by oss.sgi.com with ESMTP
	id <S554048AbQLBKeg>; Sat, 2 Dec 2000 02:34:36 -0800
Received: from localhost ([127.0.0.1] ident=chris)
	by spawn.hockeyfiend.com with esmtp (Exim 3.16 #1 (Debian))
	id 1429zm-0006lr-00; Sat, 02 Dec 2000 05:34:18 -0500
Date:   Sat, 2 Dec 2000 05:34:13 -0500 (EST)
From:   "Christopher C. Chimelis" <chris@debian.org>
X-Sender: chris@spawn.hockeyfiend.com
To:     Jamie Fifield <fifield@amirix.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: cross-compile tools made easy ...
In-Reply-To: <00Nov29.094316ast.7303@dragon.appliedmicro.ns.ca>
Message-ID: <Pine.LNX.4.21.0012020530010.25986-100000@spawn.hockeyfiend.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Wed, 29 Nov 2000, Jamie Fifield wrote:

> Chris: Any chance I could persuade you to upload a binutils-mips to Woody? :)

Ok, I have returned and am considering :-)

What's the state of the toolchain on big-endian MIPS lately?  My indy has
been relegated to other tasks and I've been unable to boot to Linux
because of it :-(   Are any patches needed against my 2.10.1.0.2-1 package
for it to work properly as a native assembler?  (in other words, are those
branch errors still popping up while bootstrapping gcc?).

There are STILl a ton of MIPS-related changes going into binutils CVS, so
I'm hesitant to enable it until the submitter(s) slow down a bit.

Would an experimental package due that targets only mips and mipsel as
cross targets in the meantime?

C
