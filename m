Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4G9hcm02156
	for linux-mips-outgoing; Wed, 16 May 2001 02:43:38 -0700
Received: from woody.ichilton.co.uk (woody.ichilton.co.uk [216.29.174.40])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4G9hbF02153
	for <linux-mips@oss.sgi.com>; Wed, 16 May 2001 02:43:37 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id DF06B80B3; Wed, 16 May 2001 10:43:35 +0100 (BST)
Date: Wed, 16 May 2001 10:43:35 +0100
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: Jason Brock <sho@ev1.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: Mips cross-compiler
Message-ID: <20010516104335.D25720@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <3B0030FA.AE9B334C@ev1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <3B0030FA.AE9B334C@ev1.net>; from sho@ev1.net on Mon, May 14, 2001 at 02:24:42PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

> When is there going to be a Linux version Mips Cross-Compiler for the
> VR4122 (Casio EM-500)?

Funny you should mention this, but I have just got such a device
yesturday.

I am planning to use it for a month or so, then try Linux on it.

>From what I have read, the kernel should not be too much of a problem
because the EM1XX is already supported.

The problem seems to be the bootloader. Aparently Microsoft removed the
vital funtions which the bootloaders used from WinCE 3, so none of the
bootloaders work anymore.


As for the cross compiler, you can build your own from source.


Ian
