Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4S6jCnC007763
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 27 May 2002 23:45:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4S6jC6p007762
	for linux-mips-outgoing; Mon, 27 May 2002 23:45:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4S6jAnC007755
	for <linux-mips@oss.sgi.com>; Mon, 27 May 2002 23:45:10 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4S6kOg09470;
	Mon, 27 May 2002 23:46:24 -0700
Date: Mon, 27 May 2002 23:46:24 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Executing IRIX binary ?
Message-ID: <20020527234624.A9392@dea.linux-mips.net>
References: <20020525154426.A2481@dea.linux-mips.net> <000701c205bd$adaeff40$0a01a8c0@sohotower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000701c205bd$adaeff40$0a01a8c0@sohotower>; from robru@teknuts.com on Mon, May 27, 2002 at 01:32:43PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 27, 2002 at 01:32:43PM -0700, Robert Rusek wrote:

> Looks like I have the kernal compiled with the IRIX binary support.  How
> do I go about executing the binaries?  When I try to execute it tells me
> that the file is not found.

The file it didn't find is the dynamic linker /usr/lib/libc.so.1.  You
have to install this file and others in special magic places.  Also the
kernel contains broken code to distinguish IRIX and Linux executables
which you'd have to fix first before the code has any chance of working.

  Ralf
