Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 00:17:12 +0100 (BST)
Received: from jeeves.momenco.com ([IPv6:::ffff:64.169.228.99]:29966 "EHLO 
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S8225204AbTDVXRL>; Wed, 23 Apr 2003 00:17:11 +0100
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by  host099.momenco.com (8.11.6/8.11.6) with SMTP id h3MNH7l18548;
	Tue, 22 Apr 2003 16:17:07 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@linux-mips.org>, "Jun Sun" <jsun@mvista.com>
Cc: "Jeff Baitis" <baitisj@evolution.com>,
	"Pete Popov" <ppopov@mvista.com>, <linux-mips@linux-mips.org>
Subject: RE: Improperly handled case in arch/mips/au1000/common/time.c
Date: Tue, 22 Apr 2003 16:17:06 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIMEAMDAAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030423010727.A8410@linux-mips.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

Umm... I might have some time in a few weeks.  Right now it's not much
of a priority for us (as a corporation).  I just have to hijack the
code from some of our other boards which already implements the new
system.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org]
> Sent: Tuesday, April 22, 2003 4:07 PM
> To: Jun Sun
> Cc: Jeff Baitis; Pete Popov; linux-mips@linux-mips.org;
> Matthew Dharm
> Subject: Re: Improperly handled case in
> arch/mips/au1000/common/time.c
>
>
> On Tue, Apr 22, 2003 at 03:56:25PM -0700, Jun Sun wrote:
>
> > I think this is a good example to show benefit of code sharing.
> > There is no good reason for au1x00 boards of not using new time.c.
> > You get to write less board code, fewer bugs and future proof.
>
> There are just three configurations left using CONFIG_OLD_TIME_C:
>
>  - EV64120 which I guess can be considered abandonded
>  - Momenco Ocelot (Matthew, feel like you have time to take care of
>    this?)
>  - RM200  (semi-maintained, my turn to fix it ...)
>
> Seems like it's time to get rid of CONFIG_OLD_TIME_C.
>
>   Ralf
>
