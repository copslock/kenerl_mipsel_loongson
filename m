Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8GMoLr20443
	for linux-mips-outgoing; Sun, 16 Sep 2001 15:50:21 -0700
Received: from cn.csoft.net ([204.92.252.130])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8GMoGe20440
	for <linux-mips@oss.sgi.com>; Sun, 16 Sep 2001 15:50:17 -0700
Received: (qmail 6131 invoked from network); 16 Sep 2001 22:50:08 -0000
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 16 Sep 2001 22:50:08 -0000
Date: Sun, 16 Sep 2001 19:50:08 -0300 (ADT)
From: Wilbern Cobb <cobb@cn.csoft.net>
X-X-Sender:  <cobb@oddbox.cn>
To: Petter Reinholdtsen <pere@hungry.com>
cc: <linux-mips@oss.sgi.com>
Subject: Re: linker problem: relocation truncated to fit
In-Reply-To: <20010917000719.B25531@false.linpro.no>
Message-ID: <Pine.BSO.4.33.0109161949300.4519-100000@oddbox.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 17 Sep 2001, Petter Reinholdtsen wrote:

> [Wilbern Cobb]
> > This is a `feature' of the MIPS toolchain. Global and static items <= n
> > bytes are placed into the small data or small bss sections instead of
> > the normal data or bss sections as an optimization. Excess items would
> > cause these linker errors.
> >
> > Pass the compiler the -Gn flag (default is 8 bytes), ie. -G4 should work
> > for most purposes.
>
> I tried -G4, -G2 and -G1 without any luck.  Even with -G1 there are still
> more than 9300 relocation messages.  (Do I need to compile all the object
> files again, by the way?  I've only tried to relink -- it takes 12 hours
> to compile :-( ))
>
> Unfortunately, my problem is with is a prorietary software product
> (Opera web browser), so I can not send you any source or object files.
> :-(

You most definately need to recompile all object files, sorry =).

-vedge
