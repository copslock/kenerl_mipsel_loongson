Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62K37Rw018968
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 13:03:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62K36En018967
	for linux-mips-outgoing; Tue, 2 Jul 2002 13:03:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-157.ka.dial.de.ignite.net [62.180.196.157])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62K31Rw018943
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 13:03:02 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g62K6pA09827;
	Tue, 2 Jul 2002 22:06:51 +0200
Date: Tue, 2 Jul 2002 22:06:51 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Always use ll/sc for mips
Message-ID: <20020702220651.B9566@dea.linux-mips.net>
References: <20020702114045.A16197@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020702114045.A16197@lucon.org>; from hjl@lucon.org on Tue, Jul 02, 2002 at 11:40:45AM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 02, 2002 at 11:40:45AM -0700, H. J. Lu wrote:

> The ll/sc emulation is implemented in 2.4.0 and above. This patch makes
> glibc always use ll/sc.

Which means the overhead of two syscalls instead of one sysmips() call
for something that is assumed to be dirt cheap.  R3000, R5900 etc.
users won't this patch you, which'll have significant impact on their
glibc performance.

  Ralf
