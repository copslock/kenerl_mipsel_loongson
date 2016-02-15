Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 18:58:30 +0100 (CET)
Received: from e19.ny.us.ibm.com ([129.33.205.209]:39609 "EHLO
        e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012408AbcBOR63UoDUr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 18:58:29 +0100
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 15 Feb 2016 12:58:23 -0500
Received: from d01dlp02.pok.ibm.com (9.56.250.167)
        by e19.ny.us.ibm.com (146.89.104.206) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 15 Feb 2016 12:58:21 -0500
X-IBM-Helo: d01dlp02.pok.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 59A4A6E8040
        for <linux-mips@linux-mips.org>; Mon, 15 Feb 2016 12:45:12 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1FHwKSF31850574
        for <linux-mips@linux-mips.org>; Mon, 15 Feb 2016 17:58:20 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
        by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1FHwJQj027185
        for <linux-mips@linux-mips.org>; Mon, 15 Feb 2016 12:58:20 -0500
Received: from paulmck-ThinkPad-W541 ([9.70.82.75])
        by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u1FHwIHF027163;
        Mon, 15 Feb 2016 12:58:19 -0500
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BB0F516C14DD; Mon, 15 Feb 2016 09:58:25 -0800 (PST)
Date:   Mon, 15 Feb 2016 09:58:25 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     will.deacon@arm.com, Andy.Glew@imgtec.com,
        Leonid.Yegoshin@imgtec.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     graham.whaley@gmail.com, torvalds@linux-foundation.org,
        hpa@zytor.com, mingo@kernel.org
Subject: Writes, smp_wmb(), and transitivity?
Message-ID: <20160215175825.GA15878@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16021517-0057-0000-0000-0000036DDF8E
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52065
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

Hello!

Some architectures provide local transitivity for a chain of threads doing
writes separated by smp_wmb(), as exemplified by the litmus tests below.
The pattern is that each thread writes to a its own variable, does an
smp_wmb(), then writes a different value to the next thread's variable.

I don't know of a use of this, but if everyone supports it, it might
be good to mandate it.  Status quo is that smp_wmb() is non-transitive,
so it currently isn't supported.

Anyone know of any architectures that do -not- support this?

Assuming all architectures -do- support this, any arguments -against-
officially supporting it in Linux?

							Thanx, Paul

------------------------------------------------------------------------

Two threads:

	int a, b;

	void thread0(void)
	{
		WRITE_ONCE(a, 1);
		smp_wmb();
		WRITE_ONCE(b, 2);
	}

	void thread1(void)
	{
		WRITE_ONCE(b, 1);
		smp_wmb();
		WRITE_ONCE(a, 2);
	}

	/* After all threads have completed and the dust has settled... */

	BUG_ON(a == 1 && b == 1);

Three threads:

	int a, b, c;

	void thread0(void)
	{
		WRITE_ONCE(a, 1);
		smp_wmb();
		WRITE_ONCE(b, 2);
	}

	void thread1(void)
	{
		WRITE_ONCE(b, 1);
		smp_wmb();
		WRITE_ONCE(c, 2);
	}

	void thread2(void)
	{
		WRITE_ONCE(c, 1);
		smp_wmb();
		WRITE_ONCE(a, 2);
	}

	/* After all threads have completed and the dust has settled... */

	BUG_ON(a == 1 && b == 1 && c == 1);

Four threads:

	int a, b, c, d;

	void thread0(void)
	{
		WRITE_ONCE(a, 1);
		smp_wmb();
		WRITE_ONCE(b, 2);
	}

	void thread1(void)
	{
		WRITE_ONCE(b, 1);
		smp_wmb();
		WRITE_ONCE(c, 2);
	}

	void thread2(void)
	{
		WRITE_ONCE(c, 1);
		smp_wmb();
		WRITE_ONCE(d, 2);
	}

	void thread3(void)
	{
		WRITE_ONCE(d, 1);
		smp_wmb();
		WRITE_ONCE(a, 2);
	}

	/* After all threads have completed and the dust has settled... */

	BUG_ON(a == 1 && b == 1 && c == 1 && d == 1);

And so on...
