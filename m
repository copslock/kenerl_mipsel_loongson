Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JAZDt12268
	for linux-mips-outgoing; Thu, 19 Jul 2001 03:35:13 -0700
Received: from dea.waldorf-gmbh.de (u-233-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.233])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JAZAV12263
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 03:35:11 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6JAZ2g04529;
	Thu, 19 Jul 2001 12:35:02 +0200
Date: Thu, 19 Jul 2001 12:35:02 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Alice Hennessy <ahennessy@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: R3000 and kgdb
Message-ID: <20010719123502.A4434@bacchus.dhis.org>
References: <3B564CE7.2CF85A65@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B564CE7.2CF85A65@mvista.com>; from ahennessy@mvista.com on Wed, Jul 18, 2001 at 07:58:47PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Alice,

On Wed, Jul 18, 2001 at 07:58:47PM -0700, Alice Hennessy wrote:

> Has anyone used kgdb with an R3000 cpu?   There was an obvious problem
> in gdb-low.S (patch below) but I still cannot get kgdb to work.

Your patch looks good, so I've applied it.

In the future please do not send patches using Netscape; it garbles patches
such that they can only applied manually which would force me to refuse any
larger patch.  Some MUA like Mutt or Pine won't trash patches.

  Ralf
