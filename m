Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PDxanC021782
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 06:59:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PDxaDi021781
	for linux-mips-outgoing; Tue, 25 Jun 2002 06:59:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-147.ka.dial.de.ignite.net [62.180.196.147])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PDxVnC021773
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 06:59:33 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5PDxgp18948;
	Tue, 25 Jun 2002 15:59:42 +0200
Date: Tue, 25 Jun 2002 15:59:42 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: LTP testing
Message-ID: <20020625155941.A16445@dea.linux-mips.net>
References: <3D181898.837E864A@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D181898.837E864A@mips.com>; from carstenl@mips.com on Tue, Jun 25, 2002 at 09:15:36AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 25, 2002 at 09:15:36AM +0200, Carsten Langgaard wrote:

> The next LTP failure is:
> mprotect01    1  FAIL  :  unexpected error - 14 : Bad address - expected
> 12
> 
> This has been fixed in the 2.4.19-pre4 patch.
> But here is a local patch that solve the above problem, so we can have
> this fixed before we have merged with kernel.org.

I'm going to merge with -rc1 asap.

  Ralf
