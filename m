Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 16:14:34 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:21120 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123397AbSJDOOd>;
	Fri, 4 Oct 2002 16:14:33 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g94EEONf016525;
	Fri, 4 Oct 2002 07:14:24 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA02433;
	Fri, 4 Oct 2002 07:14:51 -0700 (PDT)
Message-ID: <016201c26bb0$b8609a30$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-mips@linux-mips.org>
References: <3D9D484B.4C149BD8@mips.com><200210041153.MAA12052@mudchute.algor.co.uk><3D9D855B.12128FA2@mips.com><1033734968.31839.5.camel@irongate.swansea.linux .org.uk> <00fe01c26ba6$04943480$10eca8c0@grendel><1033737330.31861.30.camel@irongate.swansea.linux.org.uk> <010e01c26ba8$2c9400d0$10eca8c0@grendel> <1033739046.31861.35.camel@irongate.swansea.linux.org.uk>
Subject: Re: Promblem with PREF (prefetching) in memcpy
Date: Fri, 4 Oct 2002 16:17:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> On Fri, 2002-10-04 at 14:15, Kevin D. Kissell wrote:
> > Which is excatly the point that Carsten was raising when he started this thread!
> > 
> > The question is how, i.e. throttle memcpy or thow away a "guard band" of RAM?
> 
> 
> The x86 code basically says
> 
> while(over 320 bytes left)
> {
> prefetch ahead
> copy bits
> }
> while(bytes left)
> copy bits

Which is safe, simple, and efficient, but does seem to have the property
that there's a "cursed" page in the system that can be randomly allocated
and which will be curiously slow on memcopy().  That might or might not
be a problem in the embedded application space.

            Regards,

            Kevin K.
