Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g13I2xt11590
	for linux-mips-outgoing; Sun, 3 Feb 2002 10:02:59 -0800
Received: from dea.linux-mips.net (a1as04-p166.stg.tli.de [195.252.186.166])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g13I2tA11587
	for <linux-mips@oss.sgi.com>; Sun, 3 Feb 2002 10:02:56 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g13H1pl05691;
	Sun, 3 Feb 2002 18:01:51 +0100
Date: Sun, 3 Feb 2002 18:01:51 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: gcc 3.x, -ansi and "static inline"
Message-ID: <20020203180151.A5371@dea.linux-mips.net>
References: <20020201115206.A18085@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201115206.A18085@mvista.com>; from jsun@mvista.com on Fri, Feb 01, 2002 at 11:52:06AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 01, 2002 at 11:52:06AM -0800, Jun Sun wrote:

> BTW, the inclusion of "mipsregs.h" file in bitops.h seems unnecessary
> and caused a bunch of similar errors.

Indeed, it was pointless and I therefore removed it.

  Ralf
