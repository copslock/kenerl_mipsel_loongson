Received:  by oss.sgi.com id <S553848AbQJNQ1f>;
	Sat, 14 Oct 2000 09:27:35 -0700
Received: from ltc.ltc.com ([38.149.17.171]:46857 "HELO ltc.com")
	by oss.sgi.com with SMTP id <S553842AbQJNQ11>;
	Sat, 14 Oct 2000 09:27:27 -0700
Received: from gw1.ltc.com (gw1.ltc.com [38.149.17.163]) by ltc.com (NTMail 3.03.0017/1.afdd) with ESMTP id ha314243 for <linux-mips@oss.sgi.com>; Sat, 14 Oct 2000 12:33:11 -0400
Message-ID: <005e01c035fb$ef883b40$0701010a@ltc.com>
From:   "Bradley D. LaRonde" <brad@ltc.com>
To:     "Jay Carlson" <nop@nop.com>, "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>,
        "Mike Klar" <mfklar@ponymail.com>
References: <KEEOIBGCMINLAHMMNDJNEECBCAAA.nop@nop.com>
Subject: Re: stable binutils, gcc, glibc ...
Date:   Sat, 14 Oct 2000 12:29:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

----- Original Message -----
From: "Jay Carlson" <nop@nop.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>; "Jay Carlson" <nop@place.org>
Cc: <linux-mips@fnet.fr>; <linux-mips@oss.sgi.com>; "Mike Klar"
<mfklar@ponymail.com>
Sent: Saturday, October 14, 2000 12:11 PM
Subject: RE: stable binutils, gcc, glibc ...


> > RALF: Do your softfp patches somehow cause problems with hardware fp
machines?
> > RALF: If not we could throw all things together.

> No, no problems at all.  They're just conditional on __HAVE_FPU__.
Consider
> ftp://ftp.place.org/pub/nop/linuxce/glibc-2.0.7-mips-softfloat.patch
> submitted for the 2.0.6 branch.
>
> I'm not really the head toolchain builder for linux-vr these days---Mike
> Klar has a set of unified patches he's been working on.

I would prefer to use mipsel tools and libraries from SGI and have the
linux-vr-specific stuff go away (with linux-vr just mirroring the SGI
stuff).


> Could somebody who already has signatures on file with the FSF add
multilib
> softfloat for mips-linux targets?  I mean, we (linux-vr) *think* we're
going
> to be switching over to the FP emulator soon, but it hasn't happened yet.
> Adding multilib is pretty harmless---I can't think of how it could screw
up
> the build for hardfp machines.
>
> The biggest reason I can think of *not* to make such a change is because
> there are already plans in the works to create a mipselnofp-linux target
to
> more closely describe the situation.  But I don't see any momentum behind
> it, and I'd rather have either multilib or mipselnofp than the default
case
> of "linux-vr must ship patches and maintain separate .debs and .rpms that
> contain a proper superset of mainline functionality".

I think that optimal for me would be if the tools from SGI worked for both
hard-float and soft-float, and we didn't have any linux-vr-specific tools.


Regards,
Brad
