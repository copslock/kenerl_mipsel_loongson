Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HMm3q15396
	for linux-mips-outgoing; Mon, 17 Sep 2001 15:48:03 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HMm1e15345
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 15:48:01 -0700
Received: from dot.cygnus.com (dot.cygnus.com [205.180.230.224])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id PAA16952;
	Mon, 17 Sep 2001 15:47:54 -0700 (PDT)
Received: (from rth@localhost)
	by dot.cygnus.com (8.11.0/8.11.0) id f8HMlsT30446;
	Mon, 17 Sep 2001 15:47:54 -0700
X-Authentication-Warning: dot.cygnus.com: rth set sender to rth@redhat.com using -f
Date: Mon, 17 Sep 2001 15:47:54 -0700
From: Richard Henderson <rth@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ryan Murray <rmurray@cyberhqz.com>, linux-mips@oss.sgi.com,
   binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010917154754.E30386@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	"H . J . Lu" <hjl@lucon.org>, Ryan Murray <rmurray@cyberhqz.com>,
	linux-mips@oss.sgi.com, binutils@sourceware.cygnus.com,
	gcc@gcc.gnu.org
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no> <20010916153857.H22750@cyberhqz.com> <20010916155003.B1446@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010916155003.B1446@lucon.org>; from hjl@lucon.org on Sun, Sep 16, 2001 at 03:50:03PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Sep 16, 2001 at 03:50:03PM -0700, H . J . Lu wrote:
> I don't think mips is the only platform which has this problem. Do
> Alpha, PowerPC and Sparc have similar problems like that? What are
> the solutions for them?

Alpha has a complicated scheme by which every input object file may
be assigned to a different GOT, each of which is limited to 64k.  The
other reason this works is that variables assigned to .sdata/.sbss 
are _not_ treated differently wrt code generation.  Instead, this is
optimized via linker relaxation.

IA-64 will overflow its small data area at 22 bits.

PowerPC and Sparc do not use .sdata/.sbss.


r~
