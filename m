Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 11:23:29 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:33394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010574AbcA0KX1Z4jj9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2016 11:23:27 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D038449;
        Wed, 27 Jan 2016 02:22:39 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 138E23F246;
        Wed, 27 Jan 2016 02:23:15 -0800 (PST)
Date:   Wed, 27 Jan 2016 10:23:14 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20160127102313.GC2390@arm.com>
References: <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com>
 <20160114225510.GJ3818@linux.vnet.ibm.com>
 <20160115102431.GB2131@arm.com>
 <20160115175401.GW3818@linux.vnet.ibm.com>
 <20160115192845.GA12510@linux.vnet.ibm.com>
 <20160125144133.GB22927@arm.com>
 <20160126010646.GH4503@linux.vnet.ibm.com>
 <20160126121010.GD21553@arm.com>
 <20160126233733.GZ4503@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126233733.GZ4503@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
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

On Tue, Jan 26, 2016 at 03:37:33PM -0800, Paul E. McKenney wrote:
> On Tue, Jan 26, 2016 at 12:10:10PM +0000, Will Deacon wrote:
> > On Mon, Jan 25, 2016 at 05:06:46PM -0800, Paul E. McKenney wrote:
> > > PPC WRCnf+addrs
> > > ""
> > > {
> > > 0:r2=x; 0:r3=y;
> > > 1:r2=x; 1:r3=y;
> > > 2:r2=x; 2:r3=y;
> > > c=a; d=b; x=c; y=d;
> > > }
> > >  P0           | P1            | P2            ;
> > >  stw r3,0(r2) | lwz r8,0(r2)  | lwz r8,0(r3)  ;
> > >               | stw r2,0(r8)  | lwz r9,0(r8)  ;
> > > exists
> > > (1:r8=y /\ 2:r8=x /\ 2:r9=c)
> > 
> > Agreed.
> 
> OK, thank you!  Would you agree that it would be good to replace the
> current xor-based fake-dependency litmus tests with tests having real
> dependencies?

Yes, because it would look a lot more like real (kernel) code.

Will
