Received:  by oss.sgi.com id <S42370AbQIZIUC>;
	Tue, 26 Sep 2000 01:20:02 -0700
Received: from t111.niisi.ras.ru ([193.232.173.111]:30530 "EHLO
        t111.niisi.ras.ru") by oss.sgi.com with ESMTP id <S42281AbQIZITl>;
	Tue, 26 Sep 2000 01:19:41 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id NAA06351;
	Wed, 1 Jan 1997 13:42:26 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id LAA10418; Tue, 26 Sep 2000 11:51:43 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id MAA15053; Tue, 26 Sep 2000 12:16:48 +0300 (MSK)
Message-ID: <39D05E8B.A7F4A2D9@niisi.msk.ru>
Date:   Tue, 26 Sep 2000 12:30:03 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-origin@oss.sgi.com
Subject: Re: libc upgrade
References: <20000922152604.A2627@bacchus.dhis.org> <20000925112413.B3247@paradigm.rfc822.org> <20000925132056.A7598@bacchus.dhis.org> <20000925161500.A4773@paradigm.rfc822.org> <20000925221414.A6190@bacchus.dhis.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf,

BTW, what should we use as system headers with glibc nowadays ? Should
it be old HardHat kernel-headers-2.1.100 or newer 2.2.x ?

> I week of CPU time on an Origin building packages:  No problems ...  I'm
> actually fairly close to get a RH 6.2 built - as far as that is possible
> with glibc 2.0.
> 

Do you have the packages somewhere on the net ? I am personally
interested in disk packages (fdisk, msdostools &co.) and the packages
required in order to run 2.2 kernels. Old HardHat cfdisk, for example,
seems to create partitions in the big endian format. At least, the rest
see garbage after cfdisk creates a partition table.

Regards,
Gleb.
