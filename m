Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IMiuu12567
	for linux-mips-outgoing; Fri, 18 Jan 2002 14:44:56 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IMipP12557
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 14:44:52 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id NAA05057;
	Fri, 18 Jan 2002 13:44:45 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0ILiib13822;
	Fri, 18 Jan 2002 13:44:44 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
References: <Pine.GSO.3.96.1020118220734.22923S-100000@delta.ds2.pg.gda.pl>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 18 Jan 2002 13:44:44 -0800
In-Reply-To: <Pine.GSO.3.96.1020118220734.22923S-100000@delta.ds2.pg.gda.pl>
Message-ID: <m3zo3b1ghf.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:

> Where did you get extraneous registers for the i386
> from (especially given the usual register shortage there)?

%gs

> Maybe we could use the same approach for MIPS.

I doubt it.

> Where to look for the code in glibc in a current snapshot?

%gs is used for a long time linuxthreads/sysdeps/386/useldt.h

>  One possible approach is to reserve GOT entries for thread registers. 
> While not as fast as CPU's registers, if frequently accessed they would
> stick in the cache.  Since the ABI mandates the code to keep a pointer to
> the GOT in the gp register, accesses to got entries need only a single
> instruction.  I haven't thought on it much -- someone might have a better
> idea. 

How would you have different values for different threads?  It would
mean having multiple GOTs which is a resource waste and a nightmare in
resource management.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
