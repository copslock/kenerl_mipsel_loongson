Received:  by oss.sgi.com id <S554021AbQLDSb3>;
	Mon, 4 Dec 2000 10:31:29 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:58886 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553665AbQLDSa5>;
	Mon, 4 Dec 2000 10:30:57 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id EC291803; Mon,  4 Dec 2000 19:30:54 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 452458F74; Mon,  4 Dec 2000 19:29:46 +0100 (CET)
Date:   Mon, 4 Dec 2000 19:29:46 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     K.H.C.vanHouten@kpn.com
Cc:     linux-mips@oss.sgi.com, K.H.C.vanHouten@research.kpn.com
Subject: Re: [SUCCESS] 2.4.0-test11 on Decstation 5000/150 (R4000)
Message-ID: <20001204192946.A1109@paradigm.rfc822.org>
References: <20001203170430.A1504@paradigm.rfc822.org> <200012041814.TAA06250@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012041814.TAA06250@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Mon, Dec 04, 2000 at 07:14:30PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Dec 04, 2000 at 07:14:30PM +0100, Houten K.H.C. van (Karel) wrote:
> Florian Lohoff writes:
> >
> >Hi,
> >here is the short output - We needed to change ethernet, scsi
> >initialization and the vmalloc bug ...
> >
> > ... successfull decstation boot of linux 2.4-test11
> 
> I did try some kernel compiles with my new toolchain on my decstation,
> with the following result:
> 
> egcs-1.0.3a-1 / binutils-2.10.91-1lm : Userland compiles fine,
> 				       Kernel compile fails
> egcs-1.0.2-9 / binutils-2.8.1-2D1 : Kernel compiles OK.
> 
> Florian, do you compile native? and with which compiler / binutils?
> 
> Has anyone else a working toolchain for native building on mipsel ?

I am cross compiling kernels - I use egcs 1.1.2 + binutils 2.8.1 which
is the recommended setup for kernels >= 2.4.0-test11

I do compile userspace with glibc 2.0.6 with egcs 1.0.3a + binutils 2.8.1
and for glibc 2.2 setups with gcc + binutils cvs from 20001007 
+ some patches ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
