Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4UHVsH07113
	for linux-mips-outgoing; Wed, 30 May 2001 10:31:54 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4UHVph07107
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 10:31:51 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4UHVi022119;
	Wed, 30 May 2001 10:31:44 -0700
Message-ID: <3B152E51.ACF145BE@mvista.com>
Date: Wed, 30 May 2001 10:30:57 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J. Scott Kasten" <jsk@tetracon-eng.net>
CC: linux-mips@oss.sgi.com
Subject: Re: Pthreads.
References: <Pine.SGI.4.33.0105301100150.8607-100000@thor.tetracon-eng.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"J. Scott Kasten" wrote:
> 
> If I recall correctly, some time ago, Jun Sun was looking at pthreads.
> What is the status of threads in glibc-2.0.6/.7 and glibc-2.2.x for mips?
> I.E. works, broken, how bad, to do???
> 

I found a bug in the kernel that causes register corruption, which causes
pthread to fail.  The bug has been fixed for a while in the CVS tree.  I don't
recall any glibc specific patches.  

Yes, it runs fine on my machines.

Jun
