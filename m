Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77Eikc22584
	for linux-mips-outgoing; Tue, 7 Aug 2001 07:44:46 -0700
Received: from dea.waldorf-gmbh.de (u-87-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.87])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77EigV22569
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 07:44:42 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f77EhSj26642;
	Tue, 7 Aug 2001 16:43:28 +0200
Date: Tue, 7 Aug 2001 16:43:28 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
   "'Keith Wesolows'" <wesolows@foobazco.org>
Subject: Re: MIPS-INDIGO2-KERNEL BUG
Message-ID: <20010807164328.C26419@bacchus.dhis.org>
References: <C1CCF0351229D311BBEB0008C75B9A8A02CAFAB6@ntmsg0080.corpmail.telstra.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C1CCF0351229D311BBEB0008C75B9A8A02CAFAB6@ntmsg0080.corpmail.telstra.com.au>; from Roger.Salisbury@team.telstra.com on Tue, Aug 07, 2001 at 05:38:15PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 07, 2001 at 05:38:15PM +1000, Salisbury, Roger wrote:

> 1.
> make vmlinux
> .................................
> .................................
> .................................
> ld: drivers/media/media.o: uses different e_flags (0x0) fields than previous
> modules (0x100)
> Bad value: failed to merge target specific data of file
> drivers/media/media.o
> make: *** [vmlinux] Error 1

Upgrade your binutils.

  Ralf
