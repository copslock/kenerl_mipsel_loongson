Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 23:58:12 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:17938 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122987AbSIQV6L>; Tue, 17 Sep 2002 23:58:11 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g8HLw0603428;
	Tue, 17 Sep 2002 14:58:00 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Dominic Sweetman" <dom@algor.co.uk>, "Jun Sun" <jsun@mvista.com>
Cc: <linux-mips@linux-mips.org>
Subject: RE: [RFC] FPU context switch
Date: Tue, 17 Sep 2002 14:58:00 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIOEAHCJAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <15751.41516.224075.295052@gladsmuir.algor.co.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

I've got some evidence.

We use both OpenBSD and Linux on our hardware.  Using apps that use
the FPU, we see a _significant_ performance difference.  The problem
appears to be that OpenBSD always save/restores, where Linux doesn't.

The difference is _very_ noticable.  On the order of 10-20% for
FPU-heavy applications.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of
> Dominic Sweetman
> Sent: Tuesday, September 17, 2002 2:44 PM
> To: Jun Sun
> Cc: linux-mips@linux-mips.org
> Subject: Re: [RFC] FPU context switch
>
>
>
> Jun Sun (jsun@mvista.com) writes:
>
> > 1) always blindly save and restore during context switch
> (switch_to())
>
> Just a suggestion...
>
> > Not interesting.  Just list it here for completeness.
>
> Agreed, it's not interesting.
>
> But it would work, every time; while the current scheme has been a
> fertile source of interesting bugs.  How much useful optimisation
> might have been done with the effort required to fix them?
>
> Saving all the FPU registers on a 400MHz CPU takes about a
> tenth of a
> microsecond.  Does anyone reading this list have evidence
> that this is
> ever any kind of problem?
>
> Dominic Sweetman
> MIPS Technologies.
>
>
