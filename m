Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BA3lRw023515
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 03:03:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BA3lMh023514
	for linux-mips-outgoing; Thu, 11 Jul 2002 03:03:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BA3cRw023505;
	Thu, 11 Jul 2002 03:03:39 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id OAA04093;
	Thu, 11 Jul 2002 14:07:49 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id OAA25059; Thu, 11 Jul 2002 14:05:44 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id OAA16131; Thu, 11 Jul 2002 14:02:41 +0400 (MSK)
Message-ID: <3D2D58A6.2E5D9695@niisi.msk.ru>
Date: Thu, 11 Jul 2002 14:06:30 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: Ralf Baechle <ralf@oss.sgi.com>, Jon Burgess <Jon_Burgess@eur.3com.com>,
   linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <80256BF2.004ECBE6.00@notesmta.eur.3com.com> <20020711021554.A3207@dea.linux-mips.net> <3D2D465C.FA06D50A@niisi.msk.ru> <3D2D4D83.B2694DF1@mips.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Carsten Langgaard wrote:
> > Unfortunately, it's required by manuals for some processors. As I know,
> > IDT HW manuals clearly state cache flush routines must operate from
> > uncached code and must access uncached data only. Examples are R30x1 CPU
> > series.
> 
> Yes, that's true.
> But that code belongs in the R30xx specific cache routines, not in the MIPS32 cache
> routines.

I don't wonder if other IDT CPUs also require this, including those that
conform MIPS32.
Basically, requirement of uncached run makes hadrware logic much simpler
and allows  to save silicon a bit.

Regards,
Gleb.
