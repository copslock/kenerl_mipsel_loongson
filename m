Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1ILjXL11368
	for linux-mips-outgoing; Mon, 18 Feb 2002 13:45:33 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1ILjU911342
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 13:45:30 -0800
Received: from myware.mynet (fiendish.cygnus.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id MAA19566;
	Mon, 18 Feb 2002 12:44:58 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g1IKiSY29278;
	Mon, 18 Feb 2002 12:44:28 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: Geoff Keating <geoffk@redhat.com>
Cc: moshier@moshier.net, fxzhang@ict.ac.cn, linux-mips@oss.sgi.com,
   libc-alpha@sources.redhat.com
Subject: Re: math broken on mips
References: <Pine.LNX.4.44.0202181419220.25604-100000@moshier.net>
	<200202182018.g1IKIk802891@desire.geoffk.org>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 18 Feb 2002 12:44:28 -0800
In-Reply-To: <200202182018.g1IKIk802891@desire.geoffk.org>
Message-ID: <m3adu6bjv7.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geoff Keating <geoffk@geoffk.org> writes:

> Maybe we should add appropriate fesetround() calls to the math
> library?

No, this would punish the people who do not do stupid things with
rounding modes.  The user must know much better where such changes are
needed.

As you mentioned, there is no promise of precision in the standard
therefore everything is just fine as it is, standard-wise.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
