Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NKQrh22186
	for linux-mips-outgoing; Wed, 23 May 2001 13:26:53 -0700
Received: from blackdog.wirespeed.com ([208.170.106.25])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NKQjF22170;
	Wed, 23 May 2001 13:26:45 -0700
Received: from redhat.com (IDENT:joe@uberdog.hsv.redhat.com [172.16.16.108])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id OAA06732;
	Wed, 23 May 2001 14:53:55 -0500
Message-ID: <3B0C17D9.3060600@redhat.com>
Date: Wed, 23 May 2001 15:04:41 -0500
From: Joe deBlaquiere <jadb@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.8.1) Gecko/20010422
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: Jun Sun <jsun@mvista.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com,
   "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010523152429.5196A-100000@delta.ds2.pg.gda.pl> <3B0BF7F8.3050306@redhat.com> <3B0C0475.B9ACE682@mvista.com> <20010523205412.A10981@paradigm.rfc822.org> <20010523205552.B10981@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Florian Lohoff wrote:

> On Wed, May 23, 2001 at 08:54:12PM +0200, Florian Lohoff wrote:
> 
>> My favourit would be to let the glibc on runtime decide whether
>> to use sysmips or ll/sc in the atomic test_and_set stuff. This would
>> lead to an common atom op in the userspace which is fast on ll/sc 
>> cpus and gives much lesser performance penaltys in the sysmips case
>> than emulating ll/sc.
> 
> 
> But again - I tried to run this discussion again and again - As long
> as there is no code to use there is no point in taking a discussion.
> I needed a working sysmips for debian as we compile the glibc with
> sysmips (performance penalty but for now works everywhere) thus
> i fixed the sysmips.
> 

I have to agree with the pragmatism first, philosophy second approach. If it is beautiful but doesn't work it dosn't help anyone.

The thing I don't understand is how glibc is going to cleanly decide at 
runtime which code to use. It's relatively easy to do something like 
that in the kernel, but I can't come up with an elegant solution to make 
such a choice at runtime in glibc.

Assuming that we're moving forward (as Kevin points out) the percentage 
of systems without ll/sc is going down. While these systems don't have 
much CPU power to spare, we should make the baseline implementation have 
ll/sc emulation. If somebody wants to make a MIPS I optimized glibc, 
then that's fine, but allowing the 'standard' MIPSII glibc to work on 
all systems simplifies life ( mine at least ;) ).

-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
