Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HMqbx15523
	for linux-mips-outgoing; Mon, 17 Sep 2001 15:52:37 -0700
Received: from sunsite.ms.mff.cuni.cz (sunsite.ms.mff.cuni.cz [195.113.19.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HMqae15520
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 15:52:36 -0700
Received: (from jj@localhost)
	by sunsite.ms.mff.cuni.cz (8.9.3/8.9.3) id AAA04641;
	Tue, 18 Sep 2001 00:56:01 +0200
Date: Tue, 18 Sep 2001 00:56:01 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Richard Henderson <rth@redhat.com>, "H . J . Lu" <hjl@lucon.org>,
   Ryan Murray <rmurray@cyberhqz.com>, linux-mips@oss.sgi.com,
   binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010918005601.F2189@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no> <20010916153857.H22750@cyberhqz.com> <20010916155003.B1446@lucon.org> <20010917154754.E30386@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20010917154754.E30386@redhat.com>; from Richard Henderson on Mon, Sep 17, 2001 at 03:47:54PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Sep 17, 2001 at 03:47:54PM -0700, Richard Henderson wrote:
> PowerPC and Sparc do not use .sdata/.sbss.

Minor correction: PowerPC uses .sdata/.sbss, Sparc does not.

	Jakub
