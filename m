Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8QA8dm17577
	for linux-mips-outgoing; Wed, 26 Sep 2001 03:08:39 -0700
Received: from arbat.com (cpe.atm2-0-104276.arcnxx10.customer.tele.dk [62.242.211.100])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8QA8YD17574
	for <linux-mips@oss.sgi.com>; Wed, 26 Sep 2001 03:08:36 -0700
Received: (qmail 25144 invoked by uid 307); 26 Sep 2001 10:08:31 -0000
Date: Wed, 26 Sep 2001 12:08:31 +0200
From: Erik Corry <erik@arbat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ryan Murray <rmurray@cyberhqz.com>, linux-mips@oss.sgi.com,
   binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010926120831.A22219@arbat.com>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no> <20010916153857.H22750@cyberhqz.com> <20010916155003.B1446@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010916155003.B1446@lucon.org>; from hjl@lucon.org on Sun, Sep 16, 2001 at 03:50:03PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Sep 16, 2001 at 03:50:03PM -0700, H . J . Lu wrote:
> > 
> > I don't think -G is the problem here.  The problem is that the GOT
> > needs to be bigger than a 16 bit value.  The only way to do this is to
> > recompile everything that is going to be linked in statically
> > (libc_noshared.a and libgcc.a included) with -Wa,-xgot This problem
> > currently affects openh323 and mozilla, among other things.

I think the current favoured solution on IRIX is multigot, where
if I understand correctly you switch GOT on some function calls 
in order to have multiple GOTs in one .o (or .so).

-- 
Erik Corry erik@arbat.com
