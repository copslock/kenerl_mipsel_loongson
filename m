Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4UJcim16133
	for linux-mips-outgoing; Wed, 30 May 2001 12:38:44 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4UJceh16128
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 12:38:40 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4UIxH028029;
	Wed, 30 May 2001 11:59:17 -0700
Message-ID: <3B1542D5.7D74C295@mvista.com>
Date: Wed, 30 May 2001 11:58:29 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J. Scott Kasten" <jsk@tetracon-eng.net>
CC: linux-mips@oss.sgi.com
Subject: Re: Pthreads.
References: <Pine.SGI.4.33.0105301431160.11351-100000@thor.tetracon-eng.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"J. Scott Kasten" wrote:
> 
> On Wed, 30 May 2001, Jun Sun wrote:
> 
> > "J. Scott Kasten" wrote:
> > >
> > > If I recall correctly, some time ago, Jun Sun was looking at pthreads.
> > > What is the status of threads in glibc-2.0.6/.7 and glibc-2.2.x for mips?
> > > I.E. works, broken, how bad, to do???
> > >
> >
> > I found a bug in the kernel that causes register corruption, which causes
> > pthread to fail.  The bug has been fixed for a while in the CVS tree.  I don't
> > recall any glibc specific patches.
> 
> If I recall correctly, that was S0 not being preserved under certain
> system calls.  Which I have taken care of.
> 
> >
> > Yes, it runs fine on my machines.
> >
> > Jun
> >
> 
> When you say runs fine, do you mean the 2.0.x, the 2.2.x or both?
> 
> Thanks for your response.

Both.  There are some bug fixes needed to the get the new glibc 2.2.x
working.  Once the fixes are settled, we will post them.

Jun
