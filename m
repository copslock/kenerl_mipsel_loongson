Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62GFIRw008338
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 09:15:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62GFIxQ008337
	for linux-mips-outgoing; Tue, 2 Jul 2002 09:15:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sccrmhc01.attbi.com (sccrmhc01.attbi.com [204.127.202.61])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62GFERw008301
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 09:15:14 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020702022417.IUSW29588.sccrmhc01.attbi.com@ocean.lucon.org>;
          Tue, 2 Jul 2002 02:24:17 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 29EE9125D3; Mon,  1 Jul 2002 19:24:16 -0700 (PDT)
Date: Mon, 1 Jul 2002 19:24:15 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: bkoz@redhat.com, linux-mips@oss.sgi.com
Subject: Kernel ll/sc emulation?
Message-ID: <20020701192415.A2617@lucon.org>
References: <20020701110145.A27314@lucon.org> <1025548213.1438.7.camel@ghostwheel.cygnus.com> <20020701122313.35d7dd56.bkoz@redhat.com> <1025562305.28484.1.camel@ghostwheel.cygnus.com> <20020701153438.A31602@lucon.org> <1025568244.30577.16.camel@ghostwheel.cygnus.com> <20020701182418.A1600@lucon.org> <1025574335.30581.44.camel@ghostwheel.cygnus.com> <20020701185158.A2134@lucon.org> <1025574717.30577.48.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1025574717.30577.48.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Mon, Jul 01, 2002 at 06:51:57PM -0700
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 01, 2002 at 06:51:57PM -0700, Eric Christopher wrote:
> 
> > What do you meant by "it'll be emulated if it fails"? I didn't see any
> > ll/sc emulation in the Linux mips kernel. If you use ll/sc on CPU which
> > doesn't implement ll/sc, your binary will just dump core.
> 
> The kernel should trap and emulate the instruction at that point, at
> least as far as I've been told.
> 

That is a news to me. I couldn't find it anywhere in the Linux mips
kernel. Could someone point me to the right place in the Linux mips
kernel source tree?

Thanks.


H.J.
