Received:  by oss.sgi.com id <S553793AbRBHLkX>;
	Thu, 8 Feb 2001 03:40:23 -0800
Received: from mx.mips.com ([206.31.31.226]:21966 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553784AbRBHLkI>;
	Thu, 8 Feb 2001 03:40:08 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA11407;
	Thu, 8 Feb 2001 03:40:07 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA23325;
	Thu, 8 Feb 2001 03:40:05 -0800 (PST)
Message-ID: <005d01c091c4$69940620$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Florian Lohoff" <flo@rfc822.org>, <linux-mips@oss.sgi.com>
References: <20010208122030.A5408@paradigm.rfc822.org>
Subject: Re: [RESUME] fpu emulator
Date:   Thu, 8 Feb 2001 12:43:30 +0100
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
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> Hi,
> just to get it right - As i thought the FPU emulator is not really
> optional - It is even required for fpu-enabled devices which means
> we should clean the code in that way that if the user decides to 
> compile in the fpu emulator into the kernel we do an autodetection 
> upfront and change some of the entry/exit/lazy_fpu stuff.
> If the user decides not to compile in the FPU Emulator he is on his
> own and we ignore the whole FPU stuff and simply send SIGILL/SIGFPE
> to the processes causing all fpu binarys to fail on non-fpu enabled
> kernels.

Not quite.  Unless we create a variant of glibc that neither
initializes the FP control register on program startup, nor
saves/restores the FP registers in setjmp/longjmp, the
model of "simply sending SIGILL/SIGFPE" will result
in *all* processes being terminated with extreme prejudice,
starting with init!

            Regards,

            Kevin K.
