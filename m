Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IKKZb07574
	for linux-mips-outgoing; Fri, 18 Jan 2002 12:20:35 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IKKVP07570
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 12:20:32 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id LAA22159;
	Fri, 18 Jan 2002 11:20:19 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0IJKHe00822;
	Fri, 18 Jan 2002 11:20:17 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: "H . J . Lu" <hjl@lucon.org>
Cc: GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org>
	<m3elkn4ikq.fsf@myware.mynet> <20020118110844.A25165@lucon.org>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 18 Jan 2002 11:20:17 -0800
In-Reply-To: <20020118110844.A25165@lucon.org>
Message-ID: <m34rlj4gb2.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> I can write to k0/k1. But the value is not perserved by kernel.

Strange.  This means the registers cannot have been used so far and if
the kernel can be changed it is free.

> I don't think so. k0/k1 is reserved for OS. I don't know if OS can
> restore it for use space or not.

There are so many different MIPS implementations that I wouldn't bet
on it.  One would have to look at the minimum architecture definition.
Also, what do the new MIPS32 cores do?

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
