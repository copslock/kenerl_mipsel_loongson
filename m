Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 14:37:06 +0100 (BST)
Received: from mail.hcrest.com ([12.173.51.131]:40115 "EHLO mail.hcrest.com")
	by ftp.linux-mips.org with ESMTP id S20022795AbXCZNhE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 14:37:04 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: flush_anon_page for MIPS
Date:	Mon, 26 Mar 2007 09:36:33 -0400
Message-ID: <36E4692623C5974BA6661C0B18EE8EDF6CD3FC@MAILSERV.hcrest.com>
In-Reply-To: <20070326.223134.79300616.anemo@mba.ocn.ne.jp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: flush_anon_page for MIPS
Thread-Index: AcdvqxROJrUDX7skTJyNlGAoT3WX3QAAJdOQ
From:	"Ravi Pratap" <Ravi.Pratap@hillcrestlabs.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Cc:	<ralf@linux-mips.org>, <miklos@szeredi.hu>,
	<linux-mips@linux-mips.org>
Return-Path: <Ravi.Pratap@hillcrestlabs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ravi.Pratap@hillcrestlabs.com
Precedence: bulk
X-list: linux-mips

> From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp] 
> Sent: Monday, March 26, 2007 9:32 AM
> To: Ravi Pratap
> Cc: ralf@linux-mips.org; miklos@szeredi.hu; linux-mips@linux-mips.org
> Subject: Re: flush_anon_page for MIPS
> 
> On Sat, 24 Mar 2007 00:50:29 +0900 (JST), Atsushi Nemoto 
> <anemo@mba.ocn.ne.jp> wrote:
> > > The standard FUSE hello program triggers the bug every 
> single time. 
> > > All you have to do is follow the example on the FUSE web page:
> > > http://fuse.sourceforge.net
> > 
> > Thanks!  I'll try it (with Ralf's patch) next week.
> 
> I confirmed current git tree works fine for me.  Thanks.

Great! Pardon my ignorance in asking this question but when will I be
able to grab a stable release that includes this change?


Thanks,

Ravi.
