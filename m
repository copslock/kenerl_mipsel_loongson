Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9EL1qi16722
	for linux-mips-outgoing; Sun, 14 Oct 2001 14:01:52 -0700
Received: from dea.linux-mips.net (a1as17-p71.stg.tli.de [195.252.193.71])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9EL1mD16718
	for <linux-mips@oss.sgi.com>; Sun, 14 Oct 2001 14:01:48 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9EL1UT03711;
	Sun, 14 Oct 2001 23:01:30 +0200
Date: Sun, 14 Oct 2001 23:01:30 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Yoshi-K <ykida@yk.rim.or.jp>, linux-mips@oss.sgi.com
Subject: Re: MySQL
Message-ID: <20011014230130.A3614@dea.linux-mips.net>
References: <20011012225433.A10523@lucon.org> <MBECLJKHNDHFIBCEPBGLEECJDHAA.ykida@yk.rim.or.jp> <20011014093052.B2374@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011014093052.B2374@lucon.org>; from hjl@lucon.org on Sun, Oct 14, 2001 at 09:30:52AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Oct 14, 2001 at 09:30:52AM -0700, H . J . Lu wrote:

> > hello.
> > As for everybody, does MySQL operate without trouble?
> > 
> > OS: PS2 Linux.
> > CPU: R5900
> > gcc 2.95.2 
> > glibc 2.2.2
> > $ uname -a 
> > Linux speed-ps 2.2.1 #94 Thu Apr 19 12:13:01 JST 2001 mips unknown 
> > 
> 
> I ported mysql 3.23.36 to mips II and above in my RedHat 7.1 for
> mips.

I assume MIPS II means you're using ll/sc in the locking code in the MySQL.
Now that the ll/sc emulation is finally fixed these instructions will
also work for ll/sc-less CPUs.

  Ralf
