Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5NKBbI05808
	for linux-mips-outgoing; Sat, 23 Jun 2001 13:11:37 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5NKBaV05805
	for <linux-mips@oss.sgi.com>; Sat, 23 Jun 2001 13:11:36 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA12168;
	Sat, 23 Jun 2001 13:11:30 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA06427;
	Sat, 23 Jun 2001 13:11:27 -0700 (PDT)
Message-ID: <020c01c0fc21$51256760$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: <linux-mips@oss.sgi.com>
References: <3B34BE3B.B72D40F1@mvista.com> <01ee01c0fc08$66e81e80$0deca8c0@Ulysses> <3B34D6AC.9EACA819@mvista.com>
Subject: Re: CONFIG_MIPS_UNCACHED
Date: Sat, 23 Jun 2001 22:15:49 +0200
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

> > Since the kernel cache attribute is never initialized before
> > ld_mmu_{whatever} is invoked, and since that Config field
> > does not have a well-defined reset state on many MIPS
> > CPUs, it would appear that we are in effect trusting the
> > bootloader to have done something reasonable like
> > set kseg0 to be non-cachable or write-through, either
> > of which would be safe for the current code.
>
> I think you just proposed a fix: check current config register when we
turn
> off cache.  Thanks. :-)

That's a heuristic at best.  If the config register comes up random,
it can appear to be sane even though the cache is in fact uninitialized.

            Kevin K.
