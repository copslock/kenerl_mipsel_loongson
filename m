Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IM37t11497
	for linux-mips-outgoing; Fri, 18 Jan 2002 14:03:07 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IM33P11494
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 14:03:03 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id NAA01214;
	Fri, 18 Jan 2002 13:02:53 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0IL2nO01100;
	Fri, 18 Jan 2002 13:02:49 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
References: <Pine.GSO.3.96.1020118213957.22923R-100000@delta.ds2.pg.gda.pl>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 18 Jan 2002 13:02:48 -0800
In-Reply-To: <Pine.GSO.3.96.1020118213957.22923R-100000@delta.ds2.pg.gda.pl>
Message-ID: <m38zav2wzr.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:

> Hmm, why would an ABI reserve spare registers for a possible future
> use that might never happen?  We can probably define a new ABI
> specifically for Linux, though, if the gain surpasses the loss.

I don't really care what is done for MIPS and there is no reason to
find excuses for not having the foresight.  I just present the facts:
if there is no thread register or something equally fast MIPS will be
one of the platforms which will have only a subset of the
functionality of the other Linux architectures and not all
applications will be able to be compiled for MIPS.  That's all.  If
this is fine (e.g., for MIPS on embedded platforms) then all is good.
If somebody wants to use threads and MIPS there is a problem.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
