Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 23:40:40 +0200 (CEST)
Received: from e17.ny.us.ibm.com ([129.33.205.207]:43436 "EHLO
        e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026534AbcDNVki2HMPw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2016 23:40:38 +0200
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Apr 2016 17:40:32 -0400
Received: from d01dlp03.pok.ibm.com (9.56.250.168)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 14 Apr 2016 17:40:30 -0400
X-IBM-Helo: d01dlp03.pok.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0F8B0C9003E;
        Thu, 14 Apr 2016 17:40:25 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3ELeU3u35127468;
        Thu, 14 Apr 2016 21:40:30 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
        by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3ELeR9g010699;
        Thu, 14 Apr 2016 17:40:29 -0400
Received: from paulmck-ThinkPad-W541 ([9.70.82.191])
        by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3ELeQ9L010677;
        Thu, 14 Apr 2016 17:40:27 -0400
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6618616C2AF6; Thu, 14 Apr 2016 14:40:54 -0700 (PDT)
Date:   Thu, 14 Apr 2016 14:40:54 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
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
Subject: Re: [PATCH] documentation: Add disclaimer
Message-ID: <20160414214054.GB31866@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160114120445.GB15828@arm.com>
 <56980145.5030901@imgtec.com>
 <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com>
 <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160126102402.GE6357@twins.programming.kicks-ass.net>
 <20160126103200.GI6375@twins.programming.kicks-ass.net>
 <20160126110053.GA21553@arm.com>
 <20160126201143.GV4503@linux.vnet.ibm.com>
 <15882.1453906627@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15882.1453906627@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16041421-0041-0000-0000-000003E2AD6A
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52987
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

On Wed, Jan 27, 2016 at 02:57:07PM +0000, David Howells wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > +==========
> > +DISCLAIMER
> > +==========
> > +
> > +This document is not a specification; it is intentionally (for the sake of
> > +brevity) and unintentionally (due to being human) incomplete. This document is
> > +meant as a guide to using the various memory barriers provided by Linux, but
> > +in case of any doubt (and there are many) please ask.
> > +
> > +I repeat, this document is not a specification of what Linux expects from
> > +hardware.
> 
> The purpose of this document is twofold:
> 
>  (1) to specify the minimum functionality that one can rely on for any
>      particular barrier, and
> 
>  (2) to provide a guide as to how to use the barriers that are available.
> 
> Note that an architecture can provide more than the minimum requirement for
> any particular barrier, but if the barrier provides less than that, it is
> incorrect.
> 
> Note also that it is possible that a barrier may be a no-op for an
> architecture because the way that arch works renders an explicit barrier
> unnecessary in that case.
> 
> > +
> 
> Can you bung an extra blank line in here if you have to redo this at all?

Done as part of your patch.  Again, apologies for the delay.

							Thanx, Paul

> > +========
> > +CONTENTS
> > +========
> >  
> >   (*) Abstract memory access model.
> >  
> 
> David
> 
