Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0T9stW03635
	for linux-mips-outgoing; Tue, 29 Jan 2002 01:54:55 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0T9spP03632
	for <linux-mips@oss.sgi.com>; Tue, 29 Jan 2002 01:54:51 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id AAA09780;
	Tue, 29 Jan 2002 00:54:42 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0T8sfY20995;
	Tue, 29 Jan 2002 00:54:41 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: "H . J . Lu" <hjl@lucon.org>
Cc: GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: A linuxthreads bug on mips?
References: <20020125234542.A31028@lucon.org>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 29 Jan 2002 00:54:41 -0800
In-Reply-To: <20020125234542.A31028@lucon.org>
Message-ID: <m3zo2x35bi.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> Here is a modified ex2.c which only uses one conditional variable. It
> works fine on x86. But it leads to dead lock on mips where both
> producer and consumer are suspended. Is this testcase correct?

Only if you assume fair scheduling which is not necessarily the case.
Assume the put() function has to stop because the buffer is full.  The
get() function now reads.  It can read everything.  Calling
pthread_cond_signal() does not mean that the put() function gets
running.  Instead get() keeps running and exhausts the input buffer
and then gets in the

    while (b->writepos == b->readpos)
    {
      pthread_cond_wait (&b->notempty, &b->lock);
    }
 
loop where it can wake up immediately.  put() never is required to be
runnable.

Therefore your revised code is not acceptable although it probably
will almost always work.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
