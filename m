Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5QNkBnC025236
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 26 Jun 2002 16:46:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5QNkBs0025235
	for linux-mips-outgoing; Wed, 26 Jun 2002 16:46:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-83.ka.dial.de.ignite.net [62.180.196.83])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5QNk5nC025232
	for <linux-mips@oss.sgi.com>; Wed, 26 Jun 2002 16:46:07 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5QNkKp01498;
	Thu, 27 Jun 2002 01:46:20 +0200
Date: Thu, 27 Jun 2002 01:46:20 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ladislav Michl <ladis@psi.cz>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Guido Guenther <agx@sigxcpu.org>, linux-mips@oss.sgi.com
Subject: Re: [patch] GIO bus support
Message-ID: <20020627014620.A1484@dea.linux-mips.net>
References: <20020626140552.F19858@dea.linux-mips.net> <Pine.GSO.3.96.1020626150538.23599D-100000@delta.ds2.pg.gda.pl> <20020626205956.GA2079@kopretinka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020626205956.GA2079@kopretinka>; from ladis@psi.cz on Wed, Jun 26, 2002 at 10:59:56PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 26, 2002 at 10:59:56PM +0200, Ladislav Michl wrote:

> I'd like to hear optinion from someone more experienced to make it as
> well parseable as possible - it will be used by XFree driver.
> 
> Please see ip22_baddr() function, i did my best, but it still looks
> ungly :-(
> 
> 	ladis
> 
> Following patch is generated against linux_2_4 brach a while ago
> 
> --- /dev/null	Mon Mar  4 10:32:31 2002
> +++ linux/include/asm/sgi/sgigio.h	Wed Jun 26 02:12:23 2002
                   ^^^^

*whap* :-)

  Ralf
