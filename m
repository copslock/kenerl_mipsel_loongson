Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MJJEw27813
	for linux-mips-outgoing; Tue, 22 Jan 2002 11:19:14 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MJJBP27810
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 11:19:11 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id KAA04959;
	Tue, 22 Jan 2002 10:19:01 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA24246;
	Tue, 22 Jan 2002 10:19:01 -0800 (PST)
Message-ID: <00e801c1a371$65c92ec0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jason Gunthorpe" <jgg@debian.org>
Cc: <linux-mips@oss.sgi.com>
References: <Pine.LNX.3.96.1020122110419.20690A-100000@wakko.deltatee.com>
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
Date: Tue, 22 Jan 2002 19:19:55 +0100
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

> On Tue, 22 Jan 2002, Kevin D. Kissell wrote:
> 
> > The idea leverages off the fact that a branch likely
> > instruction performs a kind of conditional execution.
> > The instruction in the delay slot is executed only if
> > the branch is taken.  This can be used to synthesize
> > a conditional store.  The user level code for a simple
> > atomic increment, for example, would look something
> > like this:
> 
> Hmm, could you use this to take the race out of the kernel wait loop 
> too? Ie use current->need_resched as the test and 'wait' as the
> conditional operation.

It's quite possible.  But remember that it won't work on
an R3000.  R39xx yes, but not an R3K "classic".

            Kevin K.
