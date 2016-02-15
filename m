Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 21:35:18 +0100 (CET)
Received: from e33.co.us.ibm.com ([32.97.110.151]:57455 "EHLO
        e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012457AbcBOUfQztlMO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 21:35:16 +0100
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 15 Feb 2016 13:35:10 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 15 Feb 2016 13:35:08 -0700
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 87C7B1FF0029
        for <linux-mips@linux-mips.org>; Mon, 15 Feb 2016 13:23:17 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1FKZ70530212184
        for <linux-mips@linux-mips.org>; Mon, 15 Feb 2016 20:35:07 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
        by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1FKZ5Po017268
        for <linux-mips@linux-mips.org>; Mon, 15 Feb 2016 15:35:07 -0500
Received: from paulmck-ThinkPad-W541 ([9.70.82.75])
        by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u1FKZ5Ls017228;
        Mon, 15 Feb 2016 15:35:05 -0500
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AD38516C14DD; Mon, 15 Feb 2016 12:35:12 -0800 (PST)
Date:   Mon, 15 Feb 2016 12:35:12 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andy.Glew@imgtec.com, Leonid.Yegoshin@imgtec.com,
        peterz@infradead.org, linux-arch@vger.kernel.org, arnd@arndb.de,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        graham.whaley@gmail.com, torvalds@linux-foundation.org,
        hpa@zytor.com, mingo@kernel.org
Subject: Re: Writes, smp_wmb(), and transitivity?
Message-ID: <20160215203512.GL6719@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160215175825.GA15878@linux.vnet.ibm.com>
 <20160215185832.GQ6298@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160215185832.GQ6298@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16021520-0009-0000-0000-000012663BB3
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52076
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

On Mon, Feb 15, 2016 at 06:58:32PM +0000, Will Deacon wrote:
> On Mon, Feb 15, 2016 at 09:58:25AM -0800, Paul E. McKenney wrote:
> > Hello!
> 
> Hi Paul,
> 
> > Some architectures provide local transitivity for a chain of threads doing
> > writes separated by smp_wmb(), as exemplified by the litmus tests below.
> > The pattern is that each thread writes to a its own variable, does an
> > smp_wmb(), then writes a different value to the next thread's variable.
> > 
> > I don't know of a use of this, but if everyone supports it, it might
> > be good to mandate it.  Status quo is that smp_wmb() is non-transitive,
> > so it currently isn't supported.
> > 
> > Anyone know of any architectures that do -not- support this?
> > 
> > Assuming all architectures -do- support this, any arguments -against-
> > officially supporting it in Linux?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > Two threads:
> > 
> > 	int a, b;
> > 
> > 	void thread0(void)
> > 	{
> > 		WRITE_ONCE(a, 1);
> > 		smp_wmb();
> > 		WRITE_ONCE(b, 2);
> > 	}
> > 
> > 	void thread1(void)
> > 	{
> > 		WRITE_ONCE(b, 1);
> > 		smp_wmb();
> > 		WRITE_ONCE(a, 2);
> > 	}
> > 
> > 	/* After all threads have completed and the dust has settled... */
> > 
> > 	BUG_ON(a == 1 && b == 1);
> 
> My understanding is that this test, and the generalisation to n threads,
> is forbidden on ARM. However, the transitivity of DMB ST (used to
> construct smp_wmb()) has been the subject of long debates, because we
> allow the following test:
> 
> 
> P0:
> Wx = 1
> 
> P1:
> Rx == 1
> DMB ST
> Wy = 1
> 
> P2:
> Ry == 1
> <addr dep>
> Rx == 0
> 
> 
> so I'd be uneasy about saying "it's all transitive".

Agreed!  For one thing, doesn't DMB ST need writes on both sides?

But that is one reason that I am only semi-enthusiastic about this.
The potentially locally transitive case is -very- restrictive, applying
only to situations where -all- accesses are writes.

							Thanx, Paul
