Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8H1teU23138
	for linux-mips-outgoing; Sun, 16 Sep 2001 18:55:40 -0700
Received: from dea.linux-mips.net (u-10-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8H1tZe23135
	for <linux-mips@oss.sgi.com>; Sun, 16 Sep 2001 18:55:36 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8H1tA424458;
	Mon, 17 Sep 2001 03:55:10 +0200
Date: Mon, 17 Sep 2001 03:55:09 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ryan Murray <rmurray@cyberhqz.com>, linux-mips@oss.sgi.com,
   binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010917035509.B24278@dea.linux-mips.net>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no> <20010916153857.H22750@cyberhqz.com> <20010916155003.B1446@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010916155003.B1446@lucon.org>; from hjl@lucon.org on Sun, Sep 16, 2001 at 03:50:03PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Sep 16, 2001 at 03:50:03PM -0700, H . J . Lu wrote:

> I don't think mips is the only platform which has this problem. Do
> Alpha, PowerPC and Sparc have similar problems like that? What are
> the solutions for them?
> 
> BTW, it sounds like the -fpic vs. -fPIC issue. 

It is.  Yet I wouldn't like to assign a different meaning to -fpic and
-fPIC as most makefiles make little difference between these two options,
so that would imply quite some overhead.

  Ralf
