Received:  by oss.sgi.com id <S553675AbRAHLog>;
	Mon, 8 Jan 2001 03:44:36 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:24585 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553663AbRAHLoX>;
	Mon, 8 Jan 2001 03:44:23 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D41187F3; Mon,  8 Jan 2001 12:44:19 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 22624F44B; Mon,  8 Jan 2001 10:09:30 +0100 (CET)
Date:   Mon, 8 Jan 2001 10:09:30 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Nicu Popovici <octavp@isratech.ro>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Loading srec imagine problem.
Message-ID: <20010108100930.A6841@paradigm.rfc822.org>
References: <3A58E9B1.459A33C1@isratech.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A58E9B1.459A33C1@isratech.ro>; from octavp@isratech.ro on Sun, Jan 07, 2001 at 05:12:02PM -0500
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jan 07, 2001 at 05:12:02PM -0500, Nicu Popovici wrote:
> Hello ,
> 
> I have now the following cross toolchain
> binutils 2.10.1 - egcs.1.0.3a - glibc-2.0.6.
> 
> I manage to cross compile the kernel for mips and when I try to load the
> srec imagine on the mips I get the following error.
> 
> For this srec imagine I used mips-linux-objcopy -O srec vmlinux
> srecimagine.

Wouldnt this use the original load address of the vmlinux as the srec
address ? Wouldnt this mean you are probably overwriting your monitor
while loading the srec ? Ususally you would load the image via srec to
a different location with a small copy and run type code in front.

Without a memory map etc one cant help here ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
