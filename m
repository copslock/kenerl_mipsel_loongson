Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3JCwbq09254
	for linux-mips-outgoing; Thu, 19 Apr 2001 05:58:37 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3JCwUM09242
	for <linux-mips@oss.sgi.com>; Thu, 19 Apr 2001 05:58:33 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3JCvhQ01898;
	Thu, 19 Apr 2001 09:57:43 -0300
Date: Thu, 19 Apr 2001 09:57:43 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Tom Appermont <tea@sonycom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: address translation with TLB
Message-ID: <20010419095743.B1257@bacchus.dhis.org>
References: <20010414102901.A13595@ginger.sonytel.be> <20010417141122.D7177@bacchus.dhis.org> <20010419100147.A467@ginger.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010419100147.A467@ginger.sonytel.be>; from tea@sonycom.com on Thu, Apr 19, 2001 at 10:01:47AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 19, 2001 at 10:01:47AM +0200, Tom Appermont wrote:

> > Sane designs make sure that peripherals are at physical addresses of 512mb
> > or less so can be addressed through KSEG1 without using TLB entries.  So
> > far the only violation of this rule are the Jazz systems.
> 
> In the setup.c file for the jazz board, is written:
> 
>         add_wired_entry (0x02000017, 0x03c00017, 0xe0000000, PM_64K);
>         add_wired_entry (0x02400017, 0x02440017, 0xe2000000, PM_16M);
>         add_wired_entry (0x01800017, 0x01000017, 0xe4000000, PM_4M);
> 
> Why do these physical addresses which are all below 512MB need TLB entries? 

These are not physical addresses but entry[01] entries so actually are
addresses outside the low 512mb.

  Ralf
