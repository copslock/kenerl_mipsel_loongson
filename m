Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VBTcY19765
	for linux-mips-outgoing; Tue, 31 Jul 2001 04:29:38 -0700
Received: from dea.waldorf-gmbh.de (u-145-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.145])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VBTMV19745
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 04:29:25 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6V9VLu12772;
	Tue, 31 Jul 2001 11:31:21 +0200
Date: Tue, 31 Jul 2001 11:31:21 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: ppopov@pacbell.net, linux-mips@oss.sgi.com
Subject: Re: r4600 flag
Message-ID: <20010731113120.B12409@bacchus.dhis.org>
References: <3B664857.4040100@pacbell.net> <001f01c11997$bf9a4880$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001f01c11997$bf9a4880$0deca8c0@Ulysses>; from kevink@mips.com on Tue, Jul 31, 2001 at 10:06:35AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 31, 2001 at 10:06:35AM +0200, Kevin D. Kissell wrote:

> Using mips-linux-gcc from egcs-2.91.66, I don't see exactly this
> behavior in the test case above.  I *do* see that *if* I have -mcpu=4600
> set *and* I have not otherwise set the ISA level to be MIPS I or
> MIPS II (-mips1, -mips2), 64-bit instructions will be emitted.
> But that's to be expected.

No, it contradict the GCC documentation:

`-mcpu=CPU TYPE'
     Assume the defaults for the machine type CPU TYPE when scheduling
     instructions.  The choices for CPU TYPE are `r2000', `r3000',
     `r3900', `r4000', `r4100', `r4300', `r4400', `r4600', `r4650',
     `r5000', `r6000', `r8000', and `orion'.  Additionally, the
     `r2000', `r3000', `r4000', `r5000', and `r6000' can be abbreviated
     as `r2k' (or `r2K'), `r3k', etc.  While picking a specific CPU
     TYPE will schedule things appropriately for that particular chip,
     the compiler will not generate any code that does not meet level 1
     of the MIPS ISA (instruction set architecture) without a `-mipsX'
     or `-mabi' switch being used.

> To generate 32-bit code for an
> R4600-like platform, you need to specify both the ISA level
> (to deal with issues like the above) and the R4600 pipeline
> (to get the MAD instruction).

No MAD on R4600.  Again it would be in contradiction with above document-
ation.  Mad you get with:

`-mmad'
`-mno-mad'
     Permit use of the `mad', `madu' and `mul' instructions, as on the
     `r4650' chip.

> > Is there a truly correct -mcpu option for a mips32 cpu?
> 
> It's "-mips32", which is sort of a -mips option and a -mcpu
> option rolled into one.  It's supported by several gnu distributions,
> notably those of Algorithmics and Cygnus/Red Hat.  I believe
> that someone at MIPS or Algorithmics succeeded in building
> a Linux kernel of some description using the Algorithmics
> SDE, but I don't know the details.

  Ralf
