Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f39JF5B14760
	for linux-mips-outgoing; Mon, 9 Apr 2001 12:15:05 -0700
Received: from dea.waldorf-gmbh.de (u-246-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.246])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f39JF0M14747
	for <linux-mips@oss.sgi.com>; Mon, 9 Apr 2001 12:15:00 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f39JEl718925;
	Mon, 9 Apr 2001 21:14:47 +0200
Date: Mon, 9 Apr 2001 21:14:47 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Shay Deloya <shay@jungo.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: Insmod messages and modules space
Message-ID: <20010409211447.A18894@bacchus.dhis.org>
References: <01040921101605.01025@athena.home.krftech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01040921101605.01025@athena.home.krftech.com>; from shay@jungo.com on Mon, Apr 09, 2001 at 08:10:16PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 09, 2001 at 08:10:16PM +0200, Shay Deloya wrote:

> 1.Should text segment of module after insmod be in KSEG2 or KUSEG ? 
> I've notices that the module address after insmod are c0... instead of 80...
> Is it insmod Bug  ?

It's a sign of insmod working properly :)

> 2. I keep getting in insmod of busybox pkg , "relocation overflow" message 
> especially on printk symbols , when I debug the code, changing some function 
> declaration from static int func () to int func()  , makes the module to 
> insert correctly , anyone ?

Two possibilities, either you're using a too old and broken version of
modutils or you used inapropriate options to compile your module.

  Ralf
