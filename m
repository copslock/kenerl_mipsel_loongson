Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11CO1P00719
	for linux-mips-outgoing; Fri, 1 Feb 2002 04:24:01 -0800
Received: from desire.geoffk.org (12-234-190-114.client.attbi.com [12.234.190.114])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11CNwd00716
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 04:23:58 -0800
Received: (from geoffk@localhost)
	by desire.geoffk.org (8.11.6/8.11.6) id g11BNhg01794;
	Fri, 1 Feb 2002 03:23:43 -0800
Date: Fri, 1 Feb 2002 03:23:43 -0800
From: Geoff Keating <geoffk@geoffk.org>
Message-Id: <200202011123.g11BNhg01794@desire.geoffk.org>
To: schwab@suse.de
CC: machida@sm.sony.co.jp, kaz@ashi.footprints.net, hjl@lucon.org,
   macro@ds2.pg.gda.pl, libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
In-reply-to: <jebsf9bhot.fsf@sykes.suse.de> (message from Andreas Schwab on
	Fri, 01 Feb 2002 11:49:22 +0100)
Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
Reply-to: Geoff Keating <geoffk@redhat.com>
References: <20020201.123523.50041631.machida@sm.sony.co.jp>
	<Pine.LNX.4.33.0201311952440.2305-100000@ashi.FootPrints.net>
	<20020201.135903.123568420.machida@sm.sony.co.jp> <jebsf9bhot.fsf@sykes.suse.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> From: Andreas Schwab <schwab@suse.de>
> Date: Fri, 01 Feb 2002 11:49:22 +0100

> There is no way to find out anything about intermediate values of *p when
> compare_and_swap returns zero.  The value of *p can change anytime, even
> if it only was different from oldval just at the time compare_and_swap did
> the comparison.  So there is zero chance that a spurious failure of
> compare_and_swap breaks anything.

Something to watch out for, though, is livelock.  Consider the
situation in which two processors are competing for a cache line, and
both only win at the 'wrong' time: when computing a new value to be
passed to compare_and_swap rather than when actually trying to perform
the compare_and_swap.  This is why on powerpc the loop is coded in the
asm statement.

-- 
- Geoffrey Keating <geoffk@geoffk.org> <geoffk@redhat.com>
