Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g647cjRw010741
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 00:38:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g647cjLS010740
	for linux-mips-outgoing; Thu, 4 Jul 2002 00:38:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sccrmhc03.attbi.com (sccrmhc03.attbi.com [204.127.202.63])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g647cbRw010715;
	Thu, 4 Jul 2002 00:38:37 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by sccrmhc03.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020702210452.VXFA903.sccrmhc03.attbi.com@ocean.lucon.org>;
          Tue, 2 Jul 2002 21:04:52 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 767E8125D3; Tue,  2 Jul 2002 14:04:51 -0700 (PDT)
Date: Tue, 2 Jul 2002 14:04:51 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Always use ll/sc for mips
Message-ID: <20020702140451.A18214@lucon.org>
References: <20020702114045.A16197@lucon.org> <20020702220651.B9566@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020702220651.B9566@dea.linux-mips.net>; from ralf@oss.sgi.com on Tue, Jul 02, 2002 at 10:06:51PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 02, 2002 at 10:06:51PM +0200, Ralf Baechle wrote:
> On Tue, Jul 02, 2002 at 11:40:45AM -0700, H. J. Lu wrote:
> 
> > The ll/sc emulation is implemented in 2.4.0 and above. This patch makes
> > glibc always use ll/sc.
> 
> Which means the overhead of two syscalls instead of one sysmips() call
> for something that is assumed to be dirt cheap.  R3000, R5900 etc.
> users won't this patch you, which'll have significant impact on their
> glibc performance.
> 

Not all ll/sc usages are implemented with sysmips. Does mips care about
those? In case of libstdc++, should mips use ll/sc emulation?


H.J.
