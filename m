Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LJbmS04649
	for linux-mips-outgoing; Mon, 21 Jan 2002 11:37:48 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LJbjP04619
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 11:37:45 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id KAA18162;
	Mon, 21 Jan 2002 10:36:27 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0LIaQP24084;
	Mon, 21 Jan 2002 10:36:26 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: "H . J . Lu" <hjl@lucon.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Kevin D. Kissell" <kevink@mips.com>,
   Machida Hiroyuki <machida@sm.sony.co.jp>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
References: <003701c1a25f$8abfc120$0deca8c0@Ulysses>
	<Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl>
	<20020121102455.A27606@lucon.org>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 21 Jan 2002 10:36:26 -0800
In-Reply-To: <20020121102455.A27606@lucon.org>
Message-ID: <m3zo37tutx.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> Ulrich, should applciations have access to thread register directly?

It doesn't matter.  The value isn't changed in the lifetime of a
thread.  So the overhead of a syscall wouldn't be too much.  And
protection against programs overwriting the register isn't necessary.
It's the program's fault if that happens.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
