Received:  by oss.sgi.com id <S42203AbQF1HR7>;
	Wed, 28 Jun 2000 00:17:59 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:29022 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42201AbQF1HRm>;
	Wed, 28 Jun 2000 00:17:42 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id AAA27796
	for <linux-mips@oss.sgi.com>; Wed, 28 Jun 2000 00:12:49 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA72659
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 28 Jun 2000 00:17:09 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA07258
	for <linux@cthulhu.engr.sgi.com>; Wed, 28 Jun 2000 00:16:59 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id LAA26568;
	Wed, 28 Jun 2000 11:16:19 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id KAA32147; Wed, 28 Jun 2000 10:59:44 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id LAA09607; Wed, 28 Jun 2000 11:09:06 +0400 (MSD)
Message-ID: <3959A74F.44C97D23@niisi.msk.ru>
Date:   Wed, 28 Jun 2000 11:20:47 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.72 [en] (WinNT; I)
X-Accept-Language: en,ru
MIME-Version: 1.0
To:     Guido Guenther <guido.guenther@gmx.net>
CC:     Ralf Baechle <ralf@oss.sgi.com>,
        "Bradley D. LaRonde" <brad@ltc.com>,
        linux-mips <linux-mips@fnet.fr>,
        linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
References: <20000623181736.A13410@bert.physik.uni-konstanz.de> <014f01bfdd33$8877b3c0$0701010a@ltc.com> <20000623185553.A20888@bert.physik.uni-konstanz.de> <019501bfdd35$bb301940$0701010a@ltc.com> <20000623190723.B20888@bert.physik.uni-konstanz.de> <01cb01bfdd3a$fc43b2c0$0701010a@ltc.com> <39547DB3.4FF35339@niisi.msk.ru> <20000624131218.A17554@bilbo.physik.uni-konstanz.de> <20000625001255.C894@bacchus.dhis.org> <39585E84.3E75C76A@niisi.msk.ru> <20000627111727.A2352@bert.physik.uni-konstanz.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Guido Guenther wrote:
> 
> On Tue, Jun 27, 2000 at 11:57:56AM +0400, Gleb O. Raiko wrote:
> "define CROSS_COMPILE" is not perfect yet. E.g. xkbcomp is compiled for
> target architecture(since it's needed there) but the build process also tries
> to execute it on the host, same for pswrap.

I speak for X server only. The rest of XFree might be used from HardHat.

Regards,
Gleb.
