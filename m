Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 00:10:35 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:2788 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8224847AbSLDXKe>;
	Thu, 5 Dec 2002 00:10:34 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB4NANNf025839;
	Wed, 4 Dec 2002 15:10:23 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id PAA12522;
	Wed, 4 Dec 2002 15:10:21 -0800 (PST)
Message-ID: <030801c29bea$e91d76b0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: <linux-mips@linux-mips.org>, <jsun@mvista.com>
References: <20021203224504.B13437@mvista.com> <007501c29b78$f34680e0$10eca8c0@grendel> <20021204135950.T4363@mvista.com>
Subject: Re: possible Malta 4Kc cache problem ...
Date: Thu, 5 Dec 2002 00:14:18 +0100
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
X-archive-position: 760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Wed, Dec 04, 2002 at 10:38:36AM +0100, Kevin D. Kissell wrote:
> > 
> > Which version of the 4Kc manual are you looking at?  I'm looking
> > at a very recent version of the 4Kc Software User's Manual
> > (version 1.17, dated September 25, 2002), and it only shows
> > Hit_Writeback_D to be invalid for *secondary and teritary*
> > caches, which makes sense, since the 4KSc doesn't have any.
> >
> 
> I was looking at rev 1.12, Jan 3, 2001.
> 
> Good to know that 4K family does have Hit_WRiteback_D.  However,
> since it is "recommanded" instead of "required".  Shouldn't we
> still use "Hit_Writeback_Inv_D" just to be on the safe side?

Pardon me, but I thought that you were talking about 
hit-writeback-invalidates to begin with.  Indeed, I had
thought that we had organized things so that Linux always
did writeback-invalidates and never simple writebacks,
just to be on the safe side, as you say, but tampoline code 
is a special case where I can see no possible multiprocessor 
coherence issues with failing to invalidate the local Dcache 
copy. In any case, it would  be100% correct for a pure 
"hit writeback" to be a no-op on a write-through cache, 
since there is never anything dirty to write back.

            Kevin K.
