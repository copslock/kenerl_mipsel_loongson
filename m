Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8H1qo623048
	for linux-mips-outgoing; Sun, 16 Sep 2001 18:52:50 -0700
Received: from dea.linux-mips.net (u-10-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8H1qBe23045
	for <linux-mips@oss.sgi.com>; Sun, 16 Sep 2001 18:52:15 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8H1oe824438;
	Mon, 17 Sep 2001 03:50:40 +0200
Date: Mon, 17 Sep 2001 03:50:40 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Wilbern Cobb <cobb@cn.csoft.net>
Cc: "H . J . Lu" <hjl@lucon.org>, Petter Reinholdtsen <pere@hungry.com>,
   linux-mips@oss.sgi.com
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010917035040.A24278@dea.linux-mips.net>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn>; from cobb@cn.csoft.net on Sun, Sep 16, 2001 at 01:29:38PM -0300
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Sep 16, 2001 at 01:29:38PM -0300, Wilbern Cobb wrote:

> This is a `feature' of the MIPS toolchain. Global and static items <= n
> bytes are placed into the small data or small bss sections instead of
> the normal data or bss sections as an optimization. Excess items would
> cause these linker errors.
> 
> Pass the compiler the -Gn flag (default is 8 bytes), ie. -G4 should work
> for most purposes.

Default is -G0 because GP optimization isn't supported with SVR4 PIC code.

SVR4 code uses the $gp register as a pointer to the middle of a 64kbyte
sized data segment called GOT, global offset table.  A GOT overflow results
in obscure error messages as you observe them.

The only easy way to get around this is -Wa,-xgot and making sure that all
the static objects like libgcc which can't be rebuilt easily with -Wa,-xgot
get linked in first.  More effort is splitting files with this problem into
multiple shared libraries each below the critical size but this usually
results in better code.

The best solution which currently isn't supported by binutils is a multi-got
code model.

  Ralf
