Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VBahK20285
	for linux-mips-outgoing; Tue, 31 Jul 2001 04:36:43 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VBadV20281;
	Tue, 31 Jul 2001 04:36:39 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA20734;
	Tue, 31 Jul 2001 04:36:26 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA24401;
	Tue, 31 Jul 2001 04:36:20 -0700 (PDT)
Message-ID: <006901c119b5$ac8ecfe0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <ppopov@pacbell.net>, <linux-mips@oss.sgi.com>
References: <3B664857.4040100@pacbell.net> <001f01c11997$bf9a4880$0deca8c0@Ulysses> <20010731113120.B12409@bacchus.dhis.org>
Subject: Re: r4600 flag
Date: Tue, 31 Jul 2001 13:40:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > Using mips-linux-gcc from egcs-2.91.66, I don't see exactly this
> > behavior in the test case above.  I *do* see that *if* I have -mcpu=4600
> > set *and* I have not otherwise set the ISA level to be MIPS I or
> > MIPS II (-mips1, -mips2), 64-bit instructions will be emitted.
> > But that's to be expected.
>
> No, it contradict the GCC documentation:
>
> `-mcpu=CPU TYPE'
>      Assume the defaults for the machine type CPU TYPE when scheduling
>      instructions.  The choices for CPU TYPE are `r2000', `r3000',
>      `r3900', `r4000', `r4100', `r4300', `r4400', `r4600', `r4650',
>      `r5000', `r6000', `r8000', and `orion'.  Additionally, the
>      `r2000', `r3000', `r4000', `r5000', and `r6000' can be abbreviated
>      as `r2k' (or `r2K'), `r3k', etc.  While picking a specific CPU
>      TYPE will schedule things appropriately for that particular chip,
>      the compiler will not generate any code that does not meet level 1
>      of the MIPS ISA (instruction set architecture) without a `-mipsX'
>      or `-mabi' switch being used.

In that case, the tools that I've been using are technically
broken.  Surprise surprise.   Because -mcpu=4600 is
most assuredly setting the ISA level, even if it doesn't
override one explicitly set!

> > To generate 32-bit code for an
> > R4600-like platform, you need to specify both the ISA level
> > (to deal with issues like the above) and the R4600 pipeline
> > (to get the MAD instruction).
>
> No MAD on R4600.  Again it would be in contradiction with above document-
> ation.  Mad you get with:

Right.  Sorry.  I got the 4600 and 4650 confused.  I no longer
understand why "4600" and not "4650" is the model for MIPS32.

            Kevin K.
