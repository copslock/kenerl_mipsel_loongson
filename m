Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NL7t823730
	for linux-mips-outgoing; Wed, 23 May 2001 14:07:55 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NL7pF23725;
	Wed, 23 May 2001 14:07:51 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4NL6T013900;
	Wed, 23 May 2001 14:06:29 -0700
Message-ID: <3B0C263F.B4BD9259@mvista.com>
Date: Wed, 23 May 2001 14:06:07 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: Joe deBlaquiere <jadb@redhat.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, ralf@oss.sgi.com,
   Pete Popov <ppopov@mvista.com>, George Gensure <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010523152429.5196A-100000@delta.ds2.pg.gda.pl> <3B0BF7F8.3050306@redhat.com> <3B0C0475.B9ACE682@mvista.com> <20010523205412.A10981@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Florian Lohoff wrote:

> My favourit would be to let the glibc on runtime decide whether
> to use sysmips or ll/sc in the atomic test_and_set stuff. This would
> lead to an common atom op in the userspace which is fast on ll/sc
> cpus and gives much lesser performance penaltys in the sysmips case
> than emulating ll/sc.
> 

Do you have an idea how this run-time detection might be implemented?  I am
very curious.  

For example, how will you figure out the existence of ll/sc instruction?  Is
that a test which is a part of every process startup procedure?  Or do you
introduce a new syscall?

Jun
