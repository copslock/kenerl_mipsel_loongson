Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2QNSSC08693
	for linux-mips-outgoing; Mon, 26 Mar 2001 15:28:28 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2QNSSM08690
	for <linux-mips@oss.sgi.com>; Mon, 26 Mar 2001 15:28:28 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f2QNOu031012;
	Mon, 26 Mar 2001 15:24:56 -0800
Message-ID: <3ABFCF9B.FA35FF9B@mvista.com>
Date: Mon, 26 Mar 2001 15:24:11 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe deBlaquiere <jadb@redhat.com>
CC: Florian Lohoff <flo@rfc822.org>, "Kevin D. Kissell" <kevink@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: Embedded MIPS/Linux Needs
References: <00eb01c0b2c6$02c7ef60$0deca8c0@Ulysses> <3ABEB120.8020609@redhat.com> <20010326192559.A8385@paradigm.rfc822.org> <3ABF8ED5.2050007@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Joe deBlaquiere wrote:

> > Why would you suggest having vr41 and TX39 in a seperat tree ? I had a
> > look in the linux-vr tree and i dont like some of their #ifdef spaghetti
> > stuff so i am currently working on TX39 stuff on top of the oss tree
> > which could be made cleanly. (Dont integrate all TX39 archs into one
> > subarch *grrr*)
> >
> 
> It's kinda ugly, but some of that is that the original architecture didn't scale to having many different target platforms. I think a little sane multi-platform infrastructure would make things cleaner and better in the future.
> 

I was trying to move Vr41xx from linux-vr to oss tree and found a couple of
problems.  The most serious one that is that NEC Vr41xx TLB entry format is
slightly different from all other R4K-compatible CPUs.  Fixing this requires
either an ugly #ifdef in some common header files, or massively code
re-writing for all TLB related stuff.  Neither one is good.

I actually worked out a patch based on #ifdef approach, but a little too
"shameful" to submit it.  My feeling is that we need to separate TLB code from
cache code and introduce some way to plug in different TLB codes.  Then we can
get V41xx integrated nicely.

Jun
