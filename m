Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 23:00:31 +0100 (CET)
Received: from e34.co.us.ibm.com ([32.97.110.152]:59140 "EHLO
        e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011680AbcAZV7yAuTyi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 22:59:54 +0100
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jan 2016 14:59:47 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 26 Jan 2016 14:59:46 -0700
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CD88E1FF0021;
        Tue, 26 Jan 2016 14:47:55 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0QLxjsZ27918378;
        Tue, 26 Jan 2016 14:59:45 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0QLxXZq008480;
        Tue, 26 Jan 2016 14:59:44 -0700
Received: from paulmck-ThinkPad-W541 (paulmck-thinkpad-w541.au.ibm.com [9.192.250.130])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0QLxVNf008379;
        Tue, 26 Jan 2016 14:59:32 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8942E16C2B65; Tue, 26 Jan 2016 12:11:43 -0800 (PST)
Date:   Tue, 26 Jan 2016 12:11:43 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com,
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160126201143.GV4503@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com>
 <20160114120445.GB15828@arm.com>
 <56980145.5030901@imgtec.com>
 <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com>
 <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160126102402.GE6357@twins.programming.kicks-ass.net>
 <20160126103200.GI6375@twins.programming.kicks-ass.net>
 <20160126110053.GA21553@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126110053.GA21553@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16012621-0017-0000-0000-000011879FD4
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Jan 26, 2016 at 11:09:27AM +0000, Will Deacon wrote:
> On Tue, Jan 26, 2016 at 11:32:00AM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 26, 2016 at 11:24:02AM +0100, Peter Zijlstra wrote:
> > 
> > > Yeah, this goes under the header: memory-barriers.txt is _NOT_ a
> > > specification (I seem to keep repeating this).
> > 
> > Do we want this ?

Seems likely to me.  ;-)

> > ---
> >  Documentation/memory-barriers.txt | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index a61be39c7b51..433326ebdc26 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -1,3 +1,4 @@
> > +
> >  			 ============================
> >  			 LINUX KERNEL MEMORY BARRIERS
> >  			 ============================
> > @@ -5,6 +6,22 @@
> >  By: David Howells <dhowells@redhat.com>
> >      Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >  
> > +==========
> > +DISCLAIMER
> > +==========
> > +
> > +This document is not a specification; it is intentionally (for the sake of
> > +brevity) and unintentionally (due to being human) incomplete. This document is
> > +meant as a guide to using the various memory barriers provided by Linux, but
> > +in case of any doubt (and there are many) please ask.
> 
> It might be worth adding you and me to the top of the file, to save Paul
> Cc'ing us on questions (get_maintainer.pl points at poor old Corbet for
> this file).
> 
> But yes, it seems that something like this is required.

So Peter, would you like to update your patch to include yourself
and Will as authors?

						Thanx, Paul
