Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6MBekZ20431
	for linux-mips-outgoing; Sun, 22 Jul 2001 04:40:46 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6MBejV20426
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 04:40:45 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA27510;
	Sun, 22 Jul 2001 04:40:04 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA05843;
	Sun, 22 Jul 2001 04:40:01 -0700 (PDT)
Message-ID: <007d01c112a3$b10134a0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@oss.sgi.com>,
   "Thiemo Seufer" <ica2_ts@csv.ica.uni-stuttgart.de>
References: <20010722131525.L16278@rembrandt.csv.ica.uni-stuttgart.de>
Subject: Re: mips64 linker bug?
Date: Sun, 22 Jul 2001 13:44:37 +0200
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

> Kevin D. Kissell wrote:
> [snip]
> > > An Kernel with 64bit addresses is less compact and likely to run
slower.
> > > OTOH, a 64bit Kernel has certainly some hack value. :-)
> >
> > Note that the 5Kc is one of the new generation of MIPS64 parts
> > that can enable 64-bit integer and floating point instructions without
> > requiring that 64-bit addressing also be enabled in the kernel.
>
> Sorry, but I can't see what's new here. AFAICS this possibility existed
> already in MIPS III.

Sorry if I wasn't clear.  It is only the newer parts that can enable the
use of the 64-bit instructions *in user mode* without also enabling
64-bit addressng.  It's true that MIPS III/IV parts provide access to
those instructions in kernel regardless of the state of the Status.KX
bit,  but in user mode they are only available if the Status.UX bit is set,
enabling 64-bit addressing.  MIPS64 CPU's have an additional
bit in the Status register (Bit 23, "PX") to enable 64-bit instructions
without enabling 64-bit addressing.

            Regards,

            Kevin K.
