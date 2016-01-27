Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 01:41:04 +0100 (CET)
Received: from e31.co.us.ibm.com ([32.97.110.149]:36673 "EHLO
        e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009266AbcA1AkrJtBU9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 01:40:47 +0100
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jan 2016 17:40:40 -0700
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 27 Jan 2016 17:40:37 -0700
X-IBM-Helo: d03dlp03.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 22F9719D8041;
        Wed, 27 Jan 2016 17:28:37 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0S0ebiF29818924;
        Wed, 27 Jan 2016 17:40:37 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0S0eTnn026779;
        Wed, 27 Jan 2016 17:40:36 -0700
Received: from paulmck-ThinkPad-W541 (paulmck-thinkpad-w541.au.ibm.com [9.192.250.130])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0S0eS3E026717;
        Wed, 27 Jan 2016 17:40:28 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3561316C2B65; Wed, 27 Jan 2016 15:35:04 -0800 (PST)
Date:   Wed, 27 Jan 2016 15:35:04 -0800
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
Message-ID: <20160127233504.GP4503@linux.vnet.ibm.com>
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
x-cbid: 16012800-8236-0000-0000-000015938556
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51501
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
> 
> > +========
> > +CONTENTS
> > +========
> >  
> >   (*) Abstract memory access model.

Good point!  Would you be willing to add a Signed-off-by so I
can take the combined change, assuming Peter and Will are good
with it?

							Thanx, Paul
