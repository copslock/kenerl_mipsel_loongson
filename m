Received:  by oss.sgi.com id <S42216AbQHIIBv>;
	Wed, 9 Aug 2000 01:01:51 -0700
Received: from t111.niisi.ras.ru ([193.232.173.111]:41524 "EHLO
        t111.niisi.ras.ru") by oss.sgi.com with ESMTP id <S42215AbQHIIB1>;
	Wed, 9 Aug 2000 01:01:27 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id MAA32540;
	Wed, 9 Aug 2000 12:00:06 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id LAA09694; Wed, 9 Aug 2000 11:49:30 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id LAA17229; Wed, 9 Aug 2000 11:56:19 +0400 (MSD)
Message-ID: <39911193.672C7E59@niisi.msk.ru>
Date:   Wed, 09 Aug 2000 12:08:51 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.72 [en] (WinNT; I)
X-Accept-Language: en,ru
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        Craig P Prescott <prescott@phys.ufl.edu>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: BREAK and magic SysRq handling for Z8530
References: <Pine.GSO.3.96.1000807174812.3044E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Maciej,

"Maciej W. Rozycki" wrote:
> 
> Hi,
> 
>  It appears our current Z8530 driver lacks BREAK support.  It also has the
> unfortunate side effect magic SysRq wouldn't work either, if we had it.
> Not anymore!  The following patch adds both features to our Z8530 driver.
> It also allows the magic SysRq hack to be compiled-in (i.e. no more
> linking errors) even if no virtual terminal driver is build, which is
> suitable for certain configurations, including mine.
> 

Have you tested the patch? The problem isn't in the patch itself, but as
I see the zs driver is broken for a long time. At least, I used to patch
heavily this driver for my Baget taht has 2 zs chips on board. Harald
has the plans to implement new version of the driver, but I guess he is
busy all the time. Or have I missed a cleanup of the driver ?

Also, changes in sunkbd.c, keyboard.c, and serial.c isn't a good idea.
:-)

Regards,
Gleb.
