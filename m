Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4EL63R23257
	for linux-mips-outgoing; Mon, 14 May 2001 14:06:03 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4EL5xF23241
	for <linux-mips@oss.sgi.com>; Mon, 14 May 2001 14:06:00 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4EKatq09936;
	Mon, 14 May 2001 17:36:55 -0300
Date: Mon, 14 May 2001 17:36:55 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ryan Murray <rmurray@debian.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: backwards compatible ld.so patch
Message-ID: <20010514173655.A9383@bacchus.dhis.org>
References: <20010513115431.A342@cyberhqz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010513115431.A342@cyberhqz.com>; from rmurray@debian.org on Sun, May 13, 2001 at 11:54:31AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, May 13, 2001 at 11:54:31AM -0700, Ryan Murray wrote:

> Attached is a patch that changes the MAP_BASE_ADDR macro to one that Dan
> mentioned in his question about a backwards-compatible change to ld.so
> that allows both new and old shlibs to run.
> 
> This seems to work -- I've run perl (with an old-binutils libperl.so), with
> a new-binutils built ld.so and libc.so, and it works fine.  The comment above
> the change should probably be updated to indicate the new state of things,
> as well...
> 
> Comments?

Wrong.  You're replacing a hack with something even more evil.

Right thing would be to make sure that the dynamic table is loaded before
MAP_BASE_ADDR gets dereferenced; then you can reactivate the commented out
code.

  Ralf
