Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0ILL9209977
	for linux-mips-outgoing; Fri, 18 Jan 2002 13:21:09 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0ILL6P09974
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 13:21:07 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id MAA27511;
	Fri, 18 Jan 2002 12:20:53 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0IKKpP00956;
	Fri, 18 Jan 2002 12:20:51 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "H . J . Lu" <hjl@lucon.org>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
References: <Pine.GSO.3.96.1020118204144.22923P-100000@delta.ds2.pg.gda.pl>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 18 Jan 2002 12:20:51 -0800
In-Reply-To: <Pine.GSO.3.96.1020118204144.22923P-100000@delta.ds2.pg.gda.pl>
Message-ID: <m3vgdz2yxo.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:

> But what about that Alpha's special code?  It could possibly be
> reused given the large Alpha's similarity to MIPS.

No.  Alpha has certain builtin code which looks similar to calls or
software interrupts but are executed in the CPU.  This allows access
to some memory in the CPU which is almost as fast as a normal register
access.  MIPS doesn't have such hardware.  If you cannot find a
register you're doomed.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
