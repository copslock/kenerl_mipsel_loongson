Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4PMhHnC005665
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 25 May 2002 15:43:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4PMhH91005664
	for linux-mips-outgoing; Sat, 25 May 2002 15:43:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4PMhFnC005661
	for <linux-mips@oss.sgi.com>; Sat, 25 May 2002 15:43:15 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4PMiQO02501;
	Sat, 25 May 2002 15:44:26 -0700
Date: Sat, 25 May 2002 15:44:26 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: robru <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Executing IRIX binary ?
Message-ID: <20020525154426.A2481@dea.linux-mips.net>
References: <20020525002723.A27302@dea.linux-mips.net> <000701c2041f$4d2ae7f0$0a01a8c0@sohotower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000701c2041f$4d2ae7f0$0a01a8c0@sohotower>; from robru@teknuts.com on Sat, May 25, 2002 at 12:06:29PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, May 25, 2002 at 12:06:29PM -0700, robru wrote:

> How can I find out if I compiled my kernel with the compatibility code?

Make sure you have CONFIG_BINFMT_IRIX set in the kernel configuration.

You'll also need to install IRIX libraries.

  Ralf
