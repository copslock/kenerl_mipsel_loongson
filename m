Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HMvXS15764
	for linux-mips-outgoing; Mon, 17 Sep 2001 15:57:33 -0700
Received: from sunsite.ms.mff.cuni.cz (sunsite.ms.mff.cuni.cz [195.113.19.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HMvTe15761;
	Mon, 17 Sep 2001 15:57:30 -0700
Received: (from jj@localhost)
	by sunsite.ms.mff.cuni.cz (8.9.3/8.9.3) id BAA04809;
	Tue, 18 Sep 2001 01:01:07 +0200
Date: Tue, 18 Sep 2001 01:01:07 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Richard Henderson <rth@redhat.com>, Ralf Baechle <ralf@oss.sgi.com>,
   Ryan Murray <rmurray@cyberhqz.com>, linux-mips@oss.sgi.com,
   binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010918010107.G2189@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no> <20010916153857.H22750@cyberhqz.com> <20010916155003.B1446@lucon.org> <20010917035509.B24278@dea.linux-mips.net> <20010917154001.D30386@redhat.com> <20010917155325.A25017@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20010917155325.A25017@lucon.org>; from H . J . Lu on Mon, Sep 17, 2001 at 03:53:25PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Sep 17, 2001 at 03:53:25PM -0700, H . J . Lu wrote:
> Can you mix object files compiled with -fPIC/-fpic on Sparc/Alpha?

At least on the Sparc, you can mix them as you want, if you don't
overflow the signed 13bit relocs in -fpic objects. The linker will tell
you...

	Jakub
