Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9F5l2S27132
	for linux-mips-outgoing; Sun, 14 Oct 2001 22:47:02 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9F5ktD27129;
	Sun, 14 Oct 2001 22:46:55 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id 1DDF8125C3; Sun, 14 Oct 2001 22:46:54 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 972D6EBA6; Sun, 14 Oct 2001 22:46:54 -0700 (PDT)
Date: Sun, 14 Oct 2001 22:46:54 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Yoshi-K <ykida@yk.rim.or.jp>, linux-mips@oss.sgi.com
Subject: Re: MySQL
Message-ID: <20011014224654.B1658@lucon.org>
References: <20011012225433.A10523@lucon.org> <MBECLJKHNDHFIBCEPBGLEECJDHAA.ykida@yk.rim.or.jp> <20011014093052.B2374@lucon.org> <20011014230130.A3614@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011014230130.A3614@dea.linux-mips.net>; from ralf@oss.sgi.com on Sun, Oct 14, 2001 at 11:01:30PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Oct 14, 2001 at 11:01:30PM +0200, Ralf Baechle wrote:
> On Sun, Oct 14, 2001 at 09:30:52AM -0700, H . J . Lu wrote:
> 
> > > hello.
> > > As for everybody, does MySQL operate without trouble?
> > > 
> > > OS: PS2 Linux.
> > > CPU: R5900
> > > gcc 2.95.2 
> > > glibc 2.2.2
> > > $ uname -a 
> > > Linux speed-ps 2.2.1 #94 Thu Apr 19 12:13:01 JST 2001 mips unknown 
> > > 
> > 
> > I ported mysql 3.23.36 to mips II and above in my RedHat 7.1 for
> > mips.
> 
> I assume MIPS II means you're using ll/sc in the locking code in the MySQL.
> Now that the ll/sc emulation is finally fixed these instructions will
> also work for ll/sc-less CPUs.

Yes. It has some Linux/mips patch. I can only guess Linux/mips looks
different than other Linux targets because of IRIX :-). See my RedHat
7.1 port for details.


H.J.
