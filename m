Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OGlAJ16934
	for linux-mips-outgoing; Wed, 24 Oct 2001 09:47:10 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OGkuD16922;
	Wed, 24 Oct 2001 09:46:56 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA12462;
	Wed, 24 Oct 2001 09:46:49 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA14356;
	Wed, 24 Oct 2001 09:46:46 -0700 (PDT)
Message-ID: <004501c15cab$88055b60$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, "Petko Manolov" <pmanolov@lnxw.com>
Cc: <linux-mips@oss.sgi.com>
References: <200110230102.f9N12kb20443@oss.sgi.com> <3BD5D236.8D0CE33C@lnxw.com> <20011023224718.A6283@dea.linux-mips.net>
Subject: Re: Malta probs
Date: Wed, 24 Oct 2001 18:47:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

A clue - a machine check exception results
when there are two identical values in the
TLB, which is unhealthy for associative RAM
arrays (never mind that synthesized MIPS
4K and 5K cores may or may not actually
have associative RAM for the TLB).  In the
4K cores, this condition results even if the
two identical values are non-Valid, which was
not true in the R4000 and R5000 CPUs, and
which necessitated a tweak to the TLB flush
and invaldate routines to ensure that each entry
is written with a unique invalid value (a function
of the index).

Please double-check that the TLB flush
code that you are using does this.

            Kevin K.

----- Original Message ----- 
From: "Ralf Baechle" <ralf@oss.sgi.com>
To: "Petko Manolov" <pmanolov@lnxw.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Tuesday, October 23, 2001 10:47 PM
Subject: Malta probs


> On Tue, Oct 23, 2001 at 01:25:26PM -0700, Petko Manolov wrote:
> 
> > The theory looks good, but in reality latest kernel crashes
> > with machine check exception in local_flush_tlb_all on malta
> > board.  I tried both egcs-1.1.2 and gcc-3.0.1 and both are
> > crashing at the same place.
> 
> What CPU are you using; can you send me your .config file?
> 
>   Ralf
> 
