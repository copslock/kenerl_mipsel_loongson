Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KDlEm25347
	for linux-mips-outgoing; Fri, 20 Apr 2001 06:47:14 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KDlCM25344
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 06:47:12 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3KDjqC02104;
	Fri, 20 Apr 2001 10:45:52 -0300
Date: Fri, 20 Apr 2001 10:45:52 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: wesolows@foobazco.org (Keith M Wesolowski),
   rjkm@convergence.de (Ralph Metzler), jensenq@Lineo.COM (Quinn Jensen),
   linux-mips@oss.sgi.com
Subject: Re: Linux on LSI EZ4102
Message-ID: <20010420104552.B1973@bacchus.dhis.org>
References: <20010418132323.A25356@foobazco.org> <E14pzEm-0005jl-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14pzEm-0005jl-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 18, 2001 at 10:11:42PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 18, 2001 at 10:11:42PM +0100, Alan Cox wrote:

> > Any -ac kernel contains at most the same changes that are in the oss
> > tree.  Trees other than the oss one, including ac, are likely to
> > contain more bugs.
> 
> -ac has all the stuff Ralf has sent me. Linus has most of that. In some
> ways -ac has less bugs (eg the oss tree has serious disk corruption bugs -ac
> doesnt) but I certainly cant guarantee -ac will always build on mips, and 
> right now with the sem changes it quite probably wont.

It won't nor will Linus latest pre-patch.

Time to start sending more patches to you & Linus ...

  Ralf
