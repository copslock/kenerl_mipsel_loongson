Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GB9DS24090
	for linux-mips-outgoing; Thu, 16 Aug 2001 04:09:13 -0700
Received: from dea.waldorf-gmbh.de (u-116-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.116])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GB8wj24052
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 04:08:59 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7GB6uD18180;
	Thu, 16 Aug 2001 13:06:56 +0200
Date: Thu, 16 Aug 2001 13:06:56 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: wgowcher@yahoo.com, Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
   linux-mips@oss.sgi.com
Subject: Re: Benchmark performance
Message-ID: <20010816130656.A18050@bacchus.dhis.org>
References: <20010809215522.A1958@lucon.org><20010813173446.61234.qmail@web11901.mail.yahoo.com> <20010816125652N.nemoto@toshiba-tops.co.jp> <005b01c12633$813c8820$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <005b01c12633$813c8820$0deca8c0@Ulysses>; from kevink@mips.com on Thu, Aug 16, 2001 at 11:11:56AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 16, 2001 at 11:11:56AM +0200, Kevin D. Kissell wrote:

> > Current CVS kernel uses FPU emulator unconditionally.  If one floating
> > point intruction causes a 'Unimplemented' exception (denormalized
> > result, etc.) following floating point instructions are also handle by
> > FPU emulator (not only the instruction which raise the exception).
> > 
> > I do not know this is really desired behavior, but here is a patch to
> > change this.  If Unimplemented exception had been occured during the
> > benchmark, aplying this patch may result better performance.
> 
> Not desired behavior, just an artifact.  However, I agree with Carsten
> that changing the API to the emulator for this and using a counter
> as you have done is not appropriate, and that the existing CPU
> configuration flag is a more appriate mechanism.  It's possible
> that Wayne's baseline numbers came from a pre-Algor-emulator
> kernel, and that this "feature" accounts for some of his degraded
> performance.  But I'd be surprised if it accounted for all of it,
> unless his FP test does 10% of its calculations on denormalized
> numbers or something.

As I don't know the exact nature of the calculations involved it may well
be that the broken behaviour of a pre-fpuemu kernel did completly break
the algorithem involved.

As for the hard-fp case I agree with you.  It would be interesting to
know if fp instructions that need emulation appear in groups.  Then it's
the (hopefully) rare case which we don't really care about.

  Ralf
