Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PF2dk08250
	for linux-mips-outgoing; Mon, 25 Feb 2002 07:02:39 -0800
Received: from dea.linux-mips.net (a1as05-p32.stg.tli.de [195.252.187.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PF2Z908237
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 07:02:36 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1PCPx003503;
	Mon, 25 Feb 2002 13:25:59 +0100
Date: Mon, 25 Feb 2002 13:25:59 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carlo Agostini <carlo.agostini@yacme.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Problems compiling . soft-float
Message-ID: <20020225132559.A3500@dea.linux-mips.net>
References: <3C79E588.19C0FE18@yacme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C79E588.19C0FE18@yacme.com>; from carlo.agostini@yacme.com on Mon, Feb 25, 2002 at 08:19:36AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 25, 2002 at 08:19:36AM +0100, Carlo Agostini wrote:

> Then, I tried to pass explicitly -msoft-float to gcc as an argument
> .....

Not supported.  Use the kernel fp emulation.

  Ralf
