Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HKiQnC030155
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 13:44:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HKiQ8O030154
	for linux-mips-outgoing; Mon, 17 Jun 2002 13:44:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-76.ka.dial.de.ignite.net [62.180.196.76])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HKiLnC030148
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 13:44:23 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5HKiqJ27026;
	Mon, 17 Jun 2002 22:44:52 +0200
Date: Mon, 17 Jun 2002 22:44:52 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Justin Carlson <justin@cs.cmu.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: system.h asm fixes
Message-ID: <20020617224452.C27009@dea.linux-mips.net>
References: <1024338042.1463.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1024338042.1463.21.camel@localhost.localdomain>; from justin@cs.cmu.edu on Mon, Jun 17, 2002 at 11:20:42AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

In-Reply-To: <1024338042.1463.21.camel@localhost.localdomain>; from justin@cs.cmu.edu on Mon, Jun 17, 2002 at 11:20:42AM -0700

You may consider configuring a hostname for your machine :)

On Mon, Jun 17, 2002 at 11:20:42AM -0700, Justin Carlson wrote:

> Looks to me like we're missing some proper asm clobber markers:

No, as per convention $1 is never used by the compiler per convention,
so clobbering not necessary.  I recently removed all "$1" clobbers to
make the code a bit easier to read.

  Ralf
