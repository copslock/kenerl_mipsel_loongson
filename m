Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 23:00:12 +0100 (CET)
Received: from e31.co.us.ibm.com ([32.97.110.149]:51814 "EHLO
        e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011656AbcAZV7xFq7di (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 22:59:53 +0100
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jan 2016 14:59:46 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 26 Jan 2016 14:59:45 -0700
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A47511FF0043;
        Tue, 26 Jan 2016 14:47:54 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0QLxi9429163660;
        Tue, 26 Jan 2016 14:59:44 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0QLxWO0008450;
        Tue, 26 Jan 2016 14:59:43 -0700
Received: from paulmck-ThinkPad-W541 (paulmck-thinkpad-w541.au.ibm.com [9.192.250.130])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0QLxTOe008212;
        Tue, 26 Jan 2016 14:59:29 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8A40A16C2B5F; Tue, 26 Jan 2016 12:13:39 -0800 (PST)
Date:   Tue, 26 Jan 2016 12:13:39 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20160126201339.GW4503@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
 <20160115091348.GA27936@worktop>
 <20160115174612.GV3818@linux.vnet.ibm.com>
 <20160115212714.GM3421@worktop>
 <20160115215853.GC3818@linux.vnet.ibm.com>
 <20160125164242.GF22927@arm.com>
 <20160126060322.GJ4503@linux.vnet.ibm.com>
 <20160126101927.GD6357@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126101927.GD6357@twins.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16012621-8236-0000-0000-0000158A4871
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51433
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

On Tue, Jan 26, 2016 at 11:19:27AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 25, 2016 at 10:03:22PM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 25, 2016 at 04:42:43PM +0000, Will Deacon wrote:
> > > On Fri, Jan 15, 2016 at 01:58:53PM -0800, Paul E. McKenney wrote:
> > > > On Fri, Jan 15, 2016 at 10:27:14PM +0100, Peter Zijlstra wrote:
> 
> > > > > Yes, that seems a good start. But yesterday you raised the 'fun' point
> > > > > of two globally ordered sequences connected by a single local link.
> > > > 
> > > > The conclusion that I am slowly coming to is that litmus tests should
> > > > not be thought of as linear chains, but rather as cycles.  If you think
> > > > of it as a cycle, then it doesn't matter where the local link is, just
> > > > how many of them and how they are connected.
> > > 
> > > Do you have some examples of this? I'm struggling to make it work in my
> > > mind, or are you talking specifically in the context of the kernel
> > > memory model?
> > 
> > Now that you mention it, maybe it would be best to keep the transitive
> > and non-transitive separate for the time being anyway.  Just because it
> > might be possible to deal with does not necessarily mean that we should
> > be encouraging it.  ;-)
> 
> So isn't smp_mb__after_unlock_lock() exactly such a scenario? And would
> not someone trying to implement RCsc locks using locally transitive
> RELEASE/ACQUIRE operations need exactly this stuff?
> 
> That is, I am afraid we need to cover the mix of local and global
> transitive operations at least in overview.

True, but we haven't gotten to locking yet.  That said, I would argue
that smp_mb__after_unlock_lock() upgrades locks to transitive, and
thus would not be an exception to the "no combining transitive and
non-transitive steps in cycles" rule.

							Thanx, Paul
