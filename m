Received:  by oss.sgi.com id <S554086AbQLDS6K>;
	Mon, 4 Dec 2000 10:58:10 -0800
Received: from u-49-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.49]:62734
        "EHLO u-49-20.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553667AbQLDS55>; Mon, 4 Dec 2000 10:57:57 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869702AbQLDS5p>;
	Mon, 4 Dec 2000 19:57:45 +0100
Date:	Mon, 4 Dec 2000 19:57:45 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	K.H.C.vanHouten@kpn.com
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        K.H.C.vanHouten@research.kpn.com
Subject: Re: [SUCCESS] 2.4.0-test11 on Decstation 5000/150 (R4000)
Message-ID: <20001204195745.E12738@bacchus.dhis.org>
References: <20001203170430.A1504@paradigm.rfc822.org> <200012041814.TAA06250@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200012041814.TAA06250@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Mon, Dec 04, 2000 at 07:14:30PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Dec 04, 2000 at 07:14:30PM +0100, Houten K.H.C. van (Karel) wrote:

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

egcs 1.0.x will misscompile kernels; therefore from test10 on the kernel
refuses to compile.

  Ralf
