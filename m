Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5CGbNW30183
	for linux-mips-outgoing; Tue, 12 Jun 2001 09:37:23 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5CGbGV30180;
	Tue, 12 Jun 2001 09:37:16 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 7D21D125BA; Tue, 12 Jun 2001 09:37:15 -0700 (PDT)
Date: Tue, 12 Jun 2001 09:37:15 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Florian Lohoff <flo@rfc822.org>, Raoul Borenius <borenius@shuttle.de>,
   linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010612093715.A20012@lucon.org>
References: <20010611000359.A25631@paradigm.rfc822.org> <20010611064249.A15039@bacchus.dhis.org> <20010611165019.A17263@bunny.shuttle.de> <20010612120927.B8798@paradigm.rfc822.org> <20010612135306.A26214@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010612135306.A26214@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Jun 12, 2001 at 01:53:06PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 12, 2001 at 01:53:06PM +0200, Ralf Baechle wrote:
> On Tue, Jun 12, 2001 at 12:09:27PM +0200, Florian Lohoff wrote:
> 
> > I got a hint that it might be the compile to produce this bug - I was
> > suggested to use some gcc 3.0 prerelease. I now checked again and i am
> > already using some gcc 3.0
> 
> It's not a tool related bug but a genuine kernel bug in our semaphore code.
> Which - unfortunately is a bit of headache to fix but is more or less the #1
> on the list of my instabilities right now.

I have some kernel crashes which are cured by some gcc/binutils changes
which I don't believe should make any differences. I thought I could
take out the mips64 and -march patches. But wtithout them, the user
applications seem ok, but the kernel crashes in all different places.
I have to put them back in. They may be kernel bugs and my gcc/binutils
changes may just hide them.

BTW, what is the current 2.4 kernel patches for Algorithmics P6032?

Thanks.


H.J.
