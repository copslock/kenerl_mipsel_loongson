Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NHQK212207
	for linux-mips-outgoing; Mon, 23 Jul 2001 10:26:20 -0700
Received: from dea.waldorf-gmbh.de (u-223-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.223])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NHQGa12204
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 10:26:17 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6NEiOm02121;
	Mon, 23 Jul 2001 16:44:24 +0200
Date: Mon, 23 Jul 2001 16:44:24 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: time_init() enables interrupt.
Message-ID: <20010723164424.A1245@bacchus.dhis.org>
References: <20010723191226D.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010723191226D.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Mon, Jul 23, 2001 at 07:12:26PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 23, 2001 at 07:12:26PM +0900, Atsushi Nemoto wrote:

> There is conflict in cputype values.
> 
> in include/asm-mips/bootinfo.h:
> 
> #define CPU_AU1000              37
> #define CPU_4KEC                37

Thanks, fixed.

  Ralf
