Received:  by oss.sgi.com id <S554030AbRBWSNj>;
	Fri, 23 Feb 2001 10:13:39 -0800
Received: from mail.sonytel.be ([193.74.243.200]:10404 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S554026AbRBWSNb>;
	Fri, 23 Feb 2001 10:13:31 -0800
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id TAA01478;
	Fri, 23 Feb 2001 19:13:27 +0100 (MET)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id TAA00796;
	Fri, 23 Feb 2001 19:13:27 +0100 (MET)
Date:   Fri, 23 Feb 2001 19:13:27 +0100
From:   Tom Appermont <tea@sonycom.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Tom Appermont <tea@sonycom.com>, linux-mips@oss.sgi.com
Subject: Re: ELF header kernel module wrong?
Message-ID: <20010223191327.A18076@ginger.sonytel.be>
References: <20010223151355.A9091@ginger.sonytel.be> <3A969BDD.C6A41060@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
X-Mailer: Mutt 1.0i
In-Reply-To: <3A969BDD.C6A41060@mvista.com>; from jsun@mvista.com on Fri, Feb 23, 2001 at 09:20:29AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii

Jun Sun wrote:
>
> > I'm trying to get modules to work on my R5000 little endian
> > target, linux 2.4.1 + modutils 2.4.2 .
> > 
> > When I insmod a module, I get error messages like:
> > 
>
> This is a well-known problem which also exists in the old toolchain.  If you
> can search the archive, you can see a string of discussions a few months
> back.  (I don't know if we have any mailing archive?)

I also don't know if their is a linux-mips archive, but luckily Geert
keeps one himself. I found the discussion thread you are referring to
(I think) and attached the final mail below.

> > I use egcs 1.2.1 + binutils 2.9.5. Is this a problem with my
> > binutils?
> > 
> 
> Essentially it is caused by the different symbols sorting used in binutial and
> modutils.  I was trying to fix it but it was beyond my ken.

Hmmmm ... anybody else tried to fix this or with plans to do so?


Tom








--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ralfb
