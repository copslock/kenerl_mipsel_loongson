Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HMufC15700
	for linux-mips-outgoing; Mon, 17 Sep 2001 15:56:41 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HMuce15697;
	Mon, 17 Sep 2001 15:56:38 -0700
Received: from dot.cygnus.com (dot.cygnus.com [205.180.230.224])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id PAA18185;
	Mon, 17 Sep 2001 15:56:16 -0700 (PDT)
Received: (from rth@localhost)
	by dot.cygnus.com (8.11.0/8.11.0) id f8HMuG230464;
	Mon, 17 Sep 2001 15:56:16 -0700
X-Authentication-Warning: dot.cygnus.com: rth set sender to rth@redhat.com using -f
Date: Mon, 17 Sep 2001 15:56:16 -0700
From: Richard Henderson <rth@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Ryan Murray <rmurray@cyberhqz.com>,
   linux-mips@oss.sgi.com, binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010917155616.H30386@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	"H . J . Lu" <hjl@lucon.org>, Ralf Baechle <ralf@oss.sgi.com>,
	Ryan Murray <rmurray@cyberhqz.com>, linux-mips@oss.sgi.com,
	binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no> <20010916153857.H22750@cyberhqz.com> <20010916155003.B1446@lucon.org> <20010917035509.B24278@dea.linux-mips.net> <20010917154001.D30386@redhat.com> <20010917155325.A25017@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010917155325.A25017@lucon.org>; from hjl@lucon.org on Mon, Sep 17, 2001 at 03:53:25PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Sep 17, 2001 at 03:53:25PM -0700, H . J . Lu wrote:
> Can you mix object files compiled with -fPIC/-fpic on Sparc/Alpha?

Yes, but of course the total GOT/small data area is constrained
by the size allowed by -fpic.


r~
