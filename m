Received:  by oss.sgi.com id <S42184AbQFXWQL>;
	Sat, 24 Jun 2000 15:16:11 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:17006 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42183AbQFXWPl>;
	Sat, 24 Jun 2000 15:15:41 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA10305
	for <linux-mips@oss.sgi.com>; Sat, 24 Jun 2000 15:10:13 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA85464 for <linux-mips@oss.sgi.com>; Sat, 24 Jun 2000 15:14:40 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA02427
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 24 Jun 2000 15:12:53 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from u-150.karlsruhe.ipdial.viaginterkom.de (u-150.karlsruhe.ipdial.viaginterkom.de [62.180.19.150]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA01424
	for <linux@cthulhu.engr.sgi.com>; Sat, 24 Jun 2000 15:12:50 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1405681AbQFXWMz>;
        Sun, 25 Jun 2000 00:12:55 +0200
Date:   Sun, 25 Jun 2000 00:12:55 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>,
        "Bradley D. LaRonde" <brad@ltc.com>,
        linux-mips <linux-mips@fnet.fr>,
        linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
Message-ID: <20000625001255.C894@bacchus.dhis.org>
References: <20000623181736.A13410@bert.physik.uni-konstanz.de> <014f01bfdd33$8877b3c0$0701010a@ltc.com> <20000623185553.A20888@bert.physik.uni-konstanz.de> <019501bfdd35$bb301940$0701010a@ltc.com> <20000623190723.B20888@bert.physik.uni-konstanz.de> <01cb01bfdd3a$fc43b2c0$0701010a@ltc.com> <39547DB3.4FF35339@niisi.msk.ru> <20000624131218.A17554@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000624131218.A17554@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Sat, Jun 24, 2000 at 01:12:18PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Jun 24, 2000 at 01:12:18PM +0200, Guido Guenther wrote:

> [..snip..] 
> > If you cross-compile, you just redefine most of the stuff like CcCmd,
> > ArCmd, etc, anyway.
> Yes, but you have to make sure the redefinitions don't get redefined
> again, therefore IMHO an "#ifdef AsCmd" is needed. Otherwise the
> definition in hosts.def will be overriden by the one in linux.cf.

Does X building ever need the hostcompiler?  If not, then you can easily
do crossbuilds like:

  PATH=<prefix>/<target>/bin:$PATH make ...

  Ralf
