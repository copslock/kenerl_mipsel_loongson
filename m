Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8GM7O319668
	for linux-mips-outgoing; Sun, 16 Sep 2001 15:07:24 -0700
Received: from linpro.no (qmailr@mail.linpro.no [213.203.57.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8GM7Le19665
	for <linux-mips@oss.sgi.com>; Sun, 16 Sep 2001 15:07:22 -0700
Received: (qmail 22851 invoked from network); 16 Sep 2001 22:07:19 -0000
Received: from false.linpro.no (213.203.57.201)
  by mail.linpro.no with SMTP; 16 Sep 2001 22:07:19 -0000
Received: from pere by false.linpro.no with local (Exim 3.22 #1 (Debian))
	id 15ik4N-0006tV-00; Mon, 17 Sep 2001 00:07:19 +0200
Date: Mon, 17 Sep 2001 00:07:19 +0200
From: Petter Reinholdtsen <pere@hungry.com>
To: linux-mips@oss.sgi.com
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010917000719.B25531@false.linpro.no>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn>
User-Agent: Mutt/1.3.21i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

[Wilbern Cobb]
> This is a `feature' of the MIPS toolchain. Global and static items <= n
> bytes are placed into the small data or small bss sections instead of
> the normal data or bss sections as an optimization. Excess items would
> cause these linker errors.
> 
> Pass the compiler the -Gn flag (default is 8 bytes), ie. -G4 should work
> for most purposes.

I tried -G4, -G2 and -G1 without any luck.  Even with -G1 there are still
more than 9300 relocation messages.  (Do I need to compile all the object
files again, by the way?  I've only tried to relink -- it takes 12 hours
to compile :-( ))

Unfortunately, my problem is with is a prorietary software product
(Opera web browser), so I can not send you any source or object files.
:-(
