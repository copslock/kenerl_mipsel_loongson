Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G97aT19770
	for linux-mips-outgoing; Thu, 16 Aug 2001 02:07:36 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G97Zj19765
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 02:07:35 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA29382;
	Thu, 16 Aug 2001 02:07:27 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA14863;
	Thu, 16 Aug 2001 02:07:25 -0700 (PDT)
Message-ID: <005b01c12633$813c8820$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <wgowcher@yahoo.com>, "Atsushi Nemoto" <nemoto@toshiba-tops.co.jp>
Cc: <linux-mips@oss.sgi.com>
References: <20010809215522.A1958@lucon.org><20010813173446.61234.qmail@web11901.mail.yahoo.com> <20010816125652N.nemoto@toshiba-tops.co.jp>
Subject: Re: Benchmark performance
Date: Thu, 16 Aug 2001 11:11:56 +0200
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

> Current CVS kernel uses FPU emulator unconditionally.  If one floating
> point intruction causes a 'Unimplemented' exception (denormalized
> result, etc.) following floating point instructions are also handle by
> FPU emulator (not only the instruction which raise the exception).
> 
> I do not know this is really desired behavior, but here is a patch to
> change this.  If Unimplemented exception had been occured during the
> benchmark, aplying this patch may result better performance.

Not desired behavior, just an artifact.  However, I agree with Carsten
that changing the API to the emulator for this and using a counter
as you have done is not appropriate, and that the existing CPU
configuration flag is a more appriate mechanism.  It's possible
that Wayne's baseline numbers came from a pre-Algor-emulator
kernel, and that this "feature" accounts for some of his degraded
performance.  But I'd be surprised if it accounted for all of it,
unless his FP test does 10% of its calculations on denormalized
numbers or something.

            Kevin K.
