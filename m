Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FDiNc17882
	for linux-mips-outgoing; Fri, 15 Feb 2002 05:44:23 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FDiK917878
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 05:44:20 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA11123;
	Fri, 15 Feb 2002 04:44:14 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA11277;
	Fri, 15 Feb 2002 04:44:11 -0800 (PST)
Message-ID: <008601c1b61e$ff4d88b0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Atsushi Nemoto" <nemoto@toshiba-tops.co.jp>, <mdharm@momenco.com>,
   <ralf@uni-koblenz.de>, <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1020215130906.29773C-100000@delta.ds2.pg.gda.pl>
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
Date: Fri, 15 Feb 2002 13:47:12 +0100
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

> On Fri, 15 Feb 2002, Kevin D. Kissell wrote:
> 
> > So I think that the Linux code was perfectly correct in considering
> > the TX39 to be without SYNC, just as a Vr4101 must be
> > consdered to be without LL/SC.  They decode the instructions,
> > but they don't actually implement them as specified.
> 
>  The code is not correct if "bc0f" is needed to be sure a write-back
> happened.  If that is the case, the processors need their own wbflush() 
> implementation like R2k/R3k configurations in older DECstations. 

Note that I did not say that "the code is correct", only that it
is correct *in considering the TX39 to be effectively SYNC-less*.
I'm sure that the code is anyway broken six ways from Wednesday,
as usual.  ;-)

            Kevin K.
