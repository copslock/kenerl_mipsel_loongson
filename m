Received:  by oss.sgi.com id <S42224AbQFXJS1>;
	Sat, 24 Jun 2000 02:18:27 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:38187 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42223AbQFXJSB>; Sat, 24 Jun 2000 02:18:01 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id CAA04494
	for <linux-mips@oss.sgi.com>; Sat, 24 Jun 2000 02:23:15 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id CAA20954 for <linux-mips@oss.sgi.com>; Sat, 24 Jun 2000 02:17:31 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA59632
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 24 Jun 2000 02:15:43 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA06634
	for <linux@cthulhu.engr.sgi.com>; Sat, 24 Jun 2000 02:15:40 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id NAA26688;
	Sat, 24 Jun 2000 13:15:59 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA28539; Sat, 24 Jun 2000 13:03:35 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id NAA16716; Sat, 24 Jun 2000 13:10:26 +0400 (MSD)
Message-ID: <39547DB3.4FF35339@niisi.msk.ru>
Date:   Sat, 24 Jun 2000 13:21:55 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.72 [en] (WinNT; I)
X-Accept-Language: en,ru
MIME-Version: 1.0
To:     "Bradley D. LaRonde" <brad@ltc.com>
CC:     Guido Guenther <agx@bert.physik.uni-konstanz.de>,
        linux-mips <linux-mips@fnet.fr>,
        linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
References: <20000623181736.A13410@bert.physik.uni-konstanz.de> <014f01bfdd33$8877b3c0$0701010a@ltc.com> <20000623185553.A20888@bert.physik.uni-konstanz.de> <019501bfdd35$bb301940$0701010a@ltc.com> <20000623190723.B20888@bert.physik.uni-konstanz.de> <01cb01bfdd3a$fc43b2c0$0701010a@ltc.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Bradley D. LaRonde" wrote:
> 
> Cool, thank you.
> 
> It looks like they won't break anything for me.  :-)
> 
> Except I did see that one place where you hard-coded gcc.  I cross-compile,
> but maybe that's OK anyway.

If you cross-compile, you just redefine most of the stuff like CcCmd,
ArCmd, etc, anyway.

Regards,
Gleb.
