Received:  by oss.sgi.com id <S42369AbQIZIaC>;
	Tue, 26 Sep 2000 01:30:02 -0700
Received: from t111.niisi.ras.ru ([193.232.173.111]:52546 "EHLO
        t111.niisi.ras.ru") by oss.sgi.com with ESMTP id <S42281AbQIZI3k>;
	Tue, 26 Sep 2000 01:29:40 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id NAA06412;
	Wed, 1 Jan 1997 13:52:26 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id MAA10527; Tue, 26 Sep 2000 12:00:39 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id MAA15222; Tue, 26 Sep 2000 12:24:45 +0300 (MSK)
Message-ID: <39D06065.FC00C7A0@niisi.msk.ru>
Date:   Tue, 26 Sep 2000 12:37:57 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To:     Florian Lohoff <flo@rfc822.org>
CC:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-origin@oss.sgi.com
Subject: Re: libc upgrade
References: <20000922152604.A2627@bacchus.dhis.org> <20000925112413.B3247@paradigm.rfc822.org> <20000925132056.A7598@bacchus.dhis.org> <20000925161500.A4773@paradigm.rfc822.org> <20000925221414.A6190@bacchus.dhis.org> <20000926010416.B3761@paradigm.rfc822.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> > Ok, second theory.  What linker where you using to build all this programs?
> > The new ld.so needs to know what ld has built programs due to some pretty
> > stupid pre-2.9.something brokeness in R_MIPS_32 reloction handling.
> 
> egcs 1.0.3a binutils 2.8.1 (Very conservative)
> 

Well, another question. Ralf uploaded cross tools rpms year ago. Does
anybody have native rmps for big endian ? Also, does anybody have cross
tools for sparc glibc 2.1 (RH6.x sparc distribution) ? I can't compile
cross gcc on my Ultra, it seems like a bug in the sparc compiler, the
process fails in parsing an enum decl in a header.

Regards,
Gleb.
