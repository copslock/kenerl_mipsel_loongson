Received:  by oss.sgi.com id <S42251AbQIHNfm>;
	Fri, 8 Sep 2000 06:35:42 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:23822 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42247AbQIHNfY>;
	Fri, 8 Sep 2000 06:35:24 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id BEB3D7DD; Fri,  8 Sep 2000 15:39:59 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 9D4A38F81; Fri,  8 Sep 2000 15:33:59 +0200 (CEST)
Date:   Fri, 8 Sep 2000 15:33:59 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Problems with various packages on MIPS
Message-ID: <20000908153359.E9873@paradigm.rfc822.org>
References: <20000907135527.A4620@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20000907135527.A4620@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Thu, Sep 07, 2000 at 01:55:27PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Sep 07, 2000 at 01:55:27PM +0100, Ian Chilton wrote:
> Hello,
> 
> I am currently building a Linux system from scratch on my Indy.
> 
> I am having problems compiling groff and Perl...
> 
> groff 1.16 gives the following error:
> 
> Making tbl.n from tbl.man
> sed: -e expression #19, char 22: Unterminated `s' command
> make[2]: *** [tbl.n] Error 1
> make[2]: Leaving directory `/mnt/lfs-script/tmp/groff-1.16/src/preproc/tbl'
> make[1]: *** [src/preproc/tbl] Error 2
> make[1]: Leaving directory `/mnt/lfs-script/tmp/groff-1.16'
> make: *** [all] Error 2

The problem is the contained - "mdate.sh" script which gives
random output (Sometimes date - somtimes date + time) - I have no
clue why it does this but i have a fix (New mdate.sh script) for
this in the debian BTS.

http://cgi.debian.org/cgi-bin/bugreport.cgi?bug=62554

The original bug is 143 Days old meanwhile ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
