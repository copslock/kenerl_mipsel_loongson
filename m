Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1IMdQI13613
	for linux-mips-outgoing; Mon, 18 Feb 2002 14:39:26 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1IMdN913610
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 14:39:23 -0800
Received: from myware.mynet (fiendish.cygnus.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id NAA25095;
	Mon, 18 Feb 2002 13:39:06 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g1ILd4829506;
	Mon, 18 Feb 2002 13:39:04 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: moshier@moshier.net
Cc: Geoff Keating <geoffk@redhat.com>, fxzhang@ict.ac.cn,
   <linux-mips@oss.sgi.com>, <libc-alpha@sources.redhat.com>
Subject: Re: math broken on mips
References: <Pine.LNX.4.44.0202181603470.25667-100000@moshier.net>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 18 Feb 2002 13:39:04 -0800
In-Reply-To: <Pine.LNX.4.44.0202181603470.25667-100000@moshier.net>
Message-ID: <m3it8ua2rr.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Stephen L Moshier <moshier@moshier.net> writes:

> Does the glibc documentation define it?

No version of any math library reliably worked with anything but
round-to-nearest.  Only functions which were implemented using integer
operations were immune and this set varied among different platforms.
It's not written down but was always said.  If somebody wants to add
it to the documentation s/he can write something up.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
