Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76NbHf27965
	for linux-mips-outgoing; Mon, 6 Aug 2001 16:37:17 -0700
Received: from dea.waldorf-gmbh.de (u-157-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.157])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76NbEV27954
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 16:37:14 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f76NaLq22997;
	Tue, 7 Aug 2001 01:36:21 +0200
Date: Tue, 7 Aug 2001 01:36:21 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Steven Liu <stevenliu@psdc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: set_bit() function.
Message-ID: <20010807013621.A22966@bacchus.dhis.org>
References: <84CE342693F11946B9F54B18C1AB837B0A21EB@ex2k.pcs.psdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <84CE342693F11946B9F54B18C1AB837B0A21EB@ex2k.pcs.psdc.com>; from stevenliu@psdc.com on Mon, Aug 06, 2001 at 11:04:38AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 11:04:38AM -0700, Steven Liu wrote:

> extern __inline__ void set_bit(int nr, void * addr)
> {
> 	int	mask;
> 	int	*a = addr;
> 	__bi_flags;
> 
> 	a += nr >> 5;                        // <---- why shits right 5
> bits? 
> 	mask = 1 << (nr & 0x1f);
> 	__bi_save_flags(flags);
> 	__bi_cli();
> 	*a |= mask;
> 	__bi_restore_flags(flags);
> }
> 
> In
> 
> extern __inline__ int test_bit(int nr, const void *addr)
> {
> 	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr
> >> 5])) != 0;
> }
> 
> addr is always passed in as a pointer to an integer. Why does it use
> array [nr >>5]?

Linux bitfields can have an arbitrary size, more than a single machine
word.  Bitfields consist of a arrays of unsigned longs - note that this
makes a difference for 32-bit and 64-bit kernels!.

  Ralf
