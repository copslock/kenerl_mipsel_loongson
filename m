Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6CKjgU04186
	for linux-mips-outgoing; Thu, 12 Jul 2001 13:45:42 -0700
Received: from dea.waldorf-gmbh.de (u-43-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.43])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6CKjcV04183
	for <linux-mips@oss.sgi.com>; Thu, 12 Jul 2001 13:45:39 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6CKjKA24015;
	Thu, 12 Jul 2001 22:45:20 +0200
Date: Thu, 12 Jul 2001 22:45:20 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
Message-ID: <20010712224520.C23062@bacchus.dhis.org>
References: <20010712203727.A18294@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010712203727.A18294@lug-owl.de>; from jbglaw@lug-owl.de on Thu, Jul 12, 2001 at 08:37:27PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 12, 2001 at 08:37:27PM +0200, Jan-Benedict Glaw wrote:

> At Linuxtag 2001 in Stuttgart/Germany, I was talking to Karsten about
> completing userspace. He mentioned a patch for ll/sc emulation in
> kernel which was mentioned to be sent some days ago to l-k. I searched
> the archives, but couldn't find it. Any pointers?

There is a bunch of patches for ll/sc and MIPS_ATOMIC_SET floating around.
I came to the conclusion that I don't like any of them so I'm just working
on fixing the thing once and for all.

  Ralf
