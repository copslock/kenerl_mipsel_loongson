Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62GdHRw024973
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 09:39:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62GdH0C024972
	for linux-mips-outgoing; Tue, 2 Jul 2002 09:39:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62GdCRw024958
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 09:39:12 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA09640
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 09:43:27 -0700 (PDT)
	mail_from (ica2_ts@csv.ica.uni-stuttgart.de)
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17PQYH-000vml-00; Tue, 02 Jul 2002 18:30:53 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17PQaX-0003UW-00; Tue, 02 Jul 2002 18:33:13 +0200
Date: Tue, 2 Jul 2002 18:33:13 +0200
To: "H. J. Lu" <hjl@lucon.org>
Cc: Eric Christopher <echristo@redhat.com>, bkoz@redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: Kernel ll/sc emulation?
Message-ID: <20020702163313.GN16753@rembrandt.csv.ica.uni-stuttgart.de>
References: <1025548213.1438.7.camel@ghostwheel.cygnus.com> <20020701122313.35d7dd56.bkoz@redhat.com> <1025562305.28484.1.camel@ghostwheel.cygnus.com> <20020701153438.A31602@lucon.org> <1025568244.30577.16.camel@ghostwheel.cygnus.com> <20020701182418.A1600@lucon.org> <1025574335.30581.44.camel@ghostwheel.cygnus.com> <20020701185158.A2134@lucon.org> <1025574717.30577.48.camel@ghostwheel.cygnus.com> <20020701192415.A2617@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020701192415.A2617@lucon.org>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

H. J. Lu wrote:
> On Mon, Jul 01, 2002 at 06:51:57PM -0700, Eric Christopher wrote:
> > 
> > > What do you meant by "it'll be emulated if it fails"? I didn't see any
> > > ll/sc emulation in the Linux mips kernel. If you use ll/sc on CPU which
> > > doesn't implement ll/sc, your binary will just dump core.
> > 
> > The kernel should trap and emulate the instruction at that point, at
> > least as far as I've been told.
> > 
> 
> That is a news to me. I couldn't find it anywhere in the Linux mips
> kernel. Could someone point me to the right place in the Linux mips
> kernel source tree?

grep -rI LLSC arch/mips/kernel


HTH,
Thiemo
