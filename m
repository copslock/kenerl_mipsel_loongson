Received:  by oss.sgi.com id <S553858AbQLKMm0>;
	Mon, 11 Dec 2000 04:42:26 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:50950 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553855AbQLKMmM>; Mon, 11 Dec 2000 04:42:12 -0800
Received: from faramir.physik.uni-konstanz.de [134.34.144.86] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 145SGs-0003BM-00; Mon, 11 Dec 2000 13:41:34 +0100
Received: from agx by faramir.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 145SGs-0002HB-00; Mon, 11 Dec 2000 13:41:34 +0100
Date:   Mon, 11 Dec 2000 13:41:33 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
Message-ID: <20001211134133.A8720@faramir.physik.uni-konstanz.de>
References: <20001209003222.A10669@bacchus.dhis.org> <Pine.GSO.3.96.1001211122115.18945B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1001211122115.18945B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Dec 11, 2000 at 12:28:19PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Dec 11, 2000 at 12:28:19PM +0100, Maciej W. Rozycki wrote:
> friends) by glibc.  At least XFree86 and SVGATextMode make use of these
> features.  I suppose it's the same for MIPS (I haven't checked, though). 
Yes. xf86MapVidMem & friends use /dev/mem to mmap videomemory & iospace
independent of architecure.
 -- Guido
