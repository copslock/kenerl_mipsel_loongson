Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 18:03:33 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:63.70.210.59]:35851 "EHLO
	mms2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225211AbTDXRDT>; Thu, 24 Apr 2003 18:03:19 +0100
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.2)); Thu, 24 Apr 2003 10:00:01 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id KAA24260; Thu, 24 Apr 2003 10:02:47 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.4/SSF) with ESMTP id
 h3OH35ml000328; Thu, 24 Apr 2003 10:03:05 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id KAA30042; Thu,
 24 Apr 2003 10:03:05 -0700
Message-ID: <3EA818C9.3E46E560@broadcom.com>
Date: Thu, 24 Apr 2003 10:03:05 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jun Sun" <jsun@mvista.com>
cc: "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [pathch] kernel/sched.c bogon?
References: <3E67EF64.152CFC6C@broadcom.com>
 <20030306174001.K26071@mvista.com>
 <20030310135531.B2206@linux-mips.org>
 <20030310095907.U26071@mvista.com>
X-WSS-ID: 12B6C79B1384662-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:
> 
> On Mon, Mar 10, 2003 at 01:55:31PM +0100, Ralf Baechle wrote:
> > On Thu, Mar 06, 2003 at 05:40:01PM -0800, Jun Sun wrote:
> >
> > > I reported this bug last May.  Apparently it is still not
> > > taken up-stream.   Ralf, why don't we fix it here and push
> > > it up from you?
> > >
> > > BTW, this bug actually has effect on real-time performance under
> > > preemptible kernel.
> >
> > < = 2.4.x preemptible kernel is OPP.
> >
> > >  It can delay the execution of the highest
> > > priority real-time process from execution up to 1 jiffy.
> >
> > Quite a number of users get_cycles() in the kernel assume it to return a
> > 64-bit number.  I guess we'll have to fake a 64-bit counter in software ...
> >
> 
> Whether we fake 64-bit or not, oldest_idle is declared as cycles_t.
> So comparing it with (cycles_t)-1 should be always be correct.  And it
> actually makes a correct C program. :-)
> 
> I don't see any possible reason for rejecting the change.  My previous
> report is probably just lost in the noise.

And once again, the patch hasn't made it in.  Can we either apply it get
a good reason not to?

Kip
