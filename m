Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14DKSf16032
	for linux-mips-outgoing; Mon, 4 Feb 2002 05:20:28 -0800
Received: from dea.linux-mips.net (a1as01-p54.stg.tli.de [195.252.185.54])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14DKNA15981
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 05:20:24 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1471j719209;
	Mon, 4 Feb 2002 08:01:45 +0100
Date: Mon, 4 Feb 2002 08:01:45 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Hiroyuki Machida <machida@sm.sony.co.jp>, macro@ds2.pg.gda.pl,
   libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
Message-ID: <20020204080145.C13799@dea.linux-mips.net>
References: <20020131123547.A22759@lucon.org> <Pine.GSO.3.96.1020131230104.9069A-100000@delta.ds2.pg.gda.pl> <20020131144100.A24634@lucon.org> <20020201.123523.50041631.machida@sm.sony.co.jp> <20020131231714.E32690@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131231714.E32690@lucon.org>; from hjl@lucon.org on Thu, Jan 31, 2002 at 11:17:14PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 31, 2002 at 11:17:14PM -0800, H . J . Lu wrote:

> > Gas will fill delay slots. Same object codes will be produced, so I
> > think you don't have to do that by hand. 
> 
> It will make the code more readable. We don't have to guess what
> the assembler will do. 

Generally speaking a MIPS assembler is free to do arbitrary reordering.
In the past there have been non-GNU assembler that were doing more massive
reordering than gcc does ...  Using .set noreorder means you dump the
assembler's intelligence and take full responsibility for dealing with
all interlocks (or the lack thereof) and other performance issues
yourself.

  Ralf
