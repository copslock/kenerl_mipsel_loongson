Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CAXdRw018484
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 03:33:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CAXdnu018483
	for linux-mips-outgoing; Fri, 12 Jul 2002 03:33:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CAXURw018474;
	Fri, 12 Jul 2002 03:33:32 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id OAA19583;
	Fri, 12 Jul 2002 14:37:29 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id OAA32220; Fri, 12 Jul 2002 14:35:13 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id OAA25312; Fri, 12 Jul 2002 14:32:38 +0400 (MSK)
Message-ID: <3D2EB157.E90A2CBC@niisi.msk.ru>
Date: Fri, 12 Jul 2002 14:37:11 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Dominic Sweetman <dom@algor.co.uk>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Ralf Baechle <ralf@oss.sgi.com>,
   Carsten Langgaard <carstenl@mips.com>,
   Jon Burgess <Jon_Burgess@eur.3com.com>, linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <20020711131247.A11700@dea.linux-mips.net>
		<Pine.GSO.3.96.1020711185642.7876I-100000@delta.ds2.pg.gda.pl> <15662.3715.334923.669657@gladsmuir.algor.co.uk>
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dominic Sweetman wrote:
> PS: my standard appeal.  When you say you 'flush' a cache do you mean
> invalidate, write-back, or both?

I personally mean the routine has 'flush' in its name. So, 'to flush a
cache' just mens 'to call this routine'.

Considering the name belongs to the common code (as opposed to the arch
specific code), I doubt the name shall be changed.

Regards,
Gleb.
