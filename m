Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 14:33:44 +0100 (BST)
Received: from mail.hcrest.com ([12.173.51.131]:7603 "EHLO mail.hcrest.com")
	by ftp.linux-mips.org with ESMTP id S20022788AbXCZNdm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 14:33:42 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: flush_anon_page for MIPS
Date:	Mon, 26 Mar 2007 09:33:10 -0400
Message-ID: <36E4692623C5974BA6661C0B18EE8EDF6CD3FA@MAILSERV.hcrest.com>
In-Reply-To: <46046AC9.5070306@avtrex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: flush_anon_page for MIPS
Thread-Index: Acdtp9aVE1C2IAk4QHOfbmMCsG0W+ACAwYBQ
From:	"Ravi Pratap" <Ravi.Pratap@hillcrestlabs.com>
To:	"David Daney" <ddaney@avtrex.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, <miklos@szeredi.hu>,
	<linux-mips@linux-mips.org>
Return-Path: <Ravi.Pratap@hillcrestlabs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ravi.Pratap@hillcrestlabs.com
Precedence: bulk
X-list: linux-mips

> From: David Daney [mailto:ddaney@avtrex.com] 
> Sent: Friday, March 23, 2007 8:03 PM
> To: Ralf Baechle
> Cc: Ravi Pratap; Atsushi Nemoto; miklos@szeredi.hu; 
> linux-mips@linux-mips.org
> Subject: Re: flush_anon_page for MIPS
> 
> Ralf Baechle wrote:
> > On Fri, Mar 23, 2007 at 06:17:25PM -0400, Ravi Pratap wrote:
> > 
> >>> Yes, that's perfectly reproducable here (running a VSMP 
> kernel on a 
> >>> 34K).
> >>> So the fix I posted earlier was good but I did a few tweaks to it 
> >>> anyway.
> >>> Will commit to all 2.6 -stable branch and master later.
> >>
> >> Thanks so much! Will this go into 2.6.15 by any chance?
> > 
> > I don't recall that there every has been such a kernel release ;-)
> > 
> > But seriously, 2.6.15 is as dead as Tutankhamun.
> 
> Some chip vendors only support that version, so I am assuming 
> that that was the reason for the question.

That's correct, actually :-)

> It is a classic case of what happens when people do ports 
> that are not merged.  They say it is good enough as is and 
> then never move forward or fix bugs.

True, and I don't know why these vendors do it. I wish too that they
didn't.


> The good news I guess is that we have the source, so we could 
> forward port it if we were really motivated.

Yes, but isn't it a lot of work considering the lack of a
flush_anon_page in 2.6.15?


Ravi.
