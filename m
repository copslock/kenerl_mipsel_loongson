Received:  by oss.sgi.com id <S42310AbQGaWDW>;
	Mon, 31 Jul 2000 15:03:22 -0700
Received: from [207.81.221.34] ([207.81.221.34]:30546 "EHLO relay")
	by oss.sgi.com with ESMTP id <S42302AbQGaWDE>;
	Mon, 31 Jul 2000 15:03:04 -0700
Received: from vcubed.com ([207.81.96.153])
	by relay (8.8.7/8.8.7) with ESMTP id SAA27664;
	Mon, 31 Jul 2000 18:21:36 -0400
Message-ID: <3985FC8A.70E449C6@vcubed.com>
Date:   Mon, 31 Jul 2000 18:24:10 -0400
From:   Dan Aizenstros <dan@vcubed.com>
Organization: V3 Semiconductor
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     linux-mips@oss.sgi.com
Subject: Re: Binutils-2.10
References: <Pine.GSO.3.96.1000731182751.21648Q-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Thanks for the help.  I was able to build binutils-2.10 after
generating the headers as you described.

The reason I expect the patch to change generated files is
because the normal make does not generate them and the files
are included in the binutils-2.10.tar.bz2 file.  They are also
in CVS.  Why are generated files in CVS or the binary distribution
if you have to generate them?

I thought all I would have to do is a ./configure; make; make install
after I applied the patches.  Maybe you could add the need to generate
files on your binutils-2.10 web page.

Dan Aizenstros
Software Engineer
V3 Semiconductor Corp.

"Maciej W. Rozycki" wrote:
> 
> On Mon, 31 Jul 2000, Dan Aizenstros wrote:
> 
> > it is a generated file so how do I generate it?  I am also
> 
>  make -C bfd headers
> 
> > wondering if changes to this file are missing from the patch
> > file.
> 
>  It's intentional.  Why would generated files be included in a patch?  It
> only makes life more difficult when applying to modified sources.
> 
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
