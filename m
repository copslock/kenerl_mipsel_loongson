Received:  by oss.sgi.com id <S42196AbQF0HyC>;
	Tue, 27 Jun 2000 00:54:02 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:46087 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42189AbQF0Hx6>; Tue, 27 Jun 2000 00:53:58 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id AAA05096
	for <linux-mips@oss.sgi.com>; Tue, 27 Jun 2000 00:59:13 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id AAA10545 for <linux-mips@oss.sgi.com>; Tue, 27 Jun 2000 00:53:27 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA48970
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 27 Jun 2000 00:51:34 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA04025
	for <linux@cthulhu.engr.sgi.com>; Tue, 27 Jun 2000 00:51:24 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id LAA17652;
	Tue, 27 Jun 2000 11:51:36 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id LAA14615; Tue, 27 Jun 2000 11:35:57 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id LAA13938; Tue, 27 Jun 2000 11:46:06 +0400 (MSD)
Message-ID: <39585E84.3E75C76A@niisi.msk.ru>
Date:   Tue, 27 Jun 2000 11:57:56 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.72 [en] (WinNT; I)
X-Accept-Language: en,ru
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     "Bradley D. LaRonde" <brad@ltc.com>,
        linux-mips <linux-mips@fnet.fr>,
        linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
References: <20000623181736.A13410@bert.physik.uni-konstanz.de> <014f01bfdd33$8877b3c0$0701010a@ltc.com> <20000623185553.A20888@bert.physik.uni-konstanz.de> <019501bfdd35$bb301940$0701010a@ltc.com> <20000623190723.B20888@bert.physik.uni-konstanz.de> <01cb01bfdd3a$fc43b2c0$0701010a@ltc.com> <39547DB3.4FF35339@niisi.msk.ru> <20000624131218.A17554@bilbo.physik.uni-konstanz.de> <20000625001255.C894@bacchus.dhis.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Sat, Jun 24, 2000 at 01:12:18PM +0200, Guido Guenther wrote:
> 
> > [..snip..]
> > > If you cross-compile, you just redefine most of the stuff like CcCmd,
> > > ArCmd, etc, anyway.
> > Yes, but you have to make sure the redefinitions don't get redefined
> > again, therefore IMHO an "#ifdef AsCmd" is needed. Otherwise the
> > definition in hosts.def will be overriden by the one in linux.cf.
> 
> Does X building ever need the hostcompiler?

This depends on your taste basically. If you want 'clean' build w/o
stupid errors, you should define CROSS_COMPILE and other macros to be
used diring cross compilation. After that, X understands there are
hostcompiler and crosscompiler. Then, makedepend & Co are compiled by
hostcompiler and X server itself are compiler by cross compiler. In
principle, you may safely ignore all that stuff and be ready to build
makedep & Co manually.

Regards,
Gleb.
