Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BAXdRw024047
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 03:33:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BAXduA024046
	for linux-mips-outgoing; Thu, 11 Jul 2002 03:33:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BAXQRw024037;
	Thu, 11 Jul 2002 03:33:30 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id OAA04443;
	Thu, 11 Jul 2002 14:37:48 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id OAA25198; Thu, 11 Jul 2002 14:34:28 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id OAA17554; Thu, 11 Jul 2002 14:32:49 +0400 (MSK)
Message-ID: <3D2D5FA5.5D964B68@niisi.msk.ru>
Date: Thu, 11 Jul 2002 14:36:21 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: Ralf Baechle <ralf@oss.sgi.com>, Jon Burgess <Jon_Burgess@eur.3com.com>,
   linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <80256BF2.004ECBE6.00@notesmta.eur.3com.com> <20020711021554.A3207@dea.linux-mips.net> <3D2D465C.FA06D50A@niisi.msk.ru> <3D2D4D83.B2694DF1@mips.com> <3D2D58A6.2E5D9695@niisi.msk.ru> <3D2D5AD2.1B254721@mips.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Carsten Langgaard wrote:
> 
> "Gleb O. Raiko" wrote:
> > Basically, requirement of uncached run makes hadrware logic much simpler
> > and allows  to save silicon a bit.
> 
> That could be true, but then again I suggest making specific cache routines for those
> CPUs.
> It would be a real performance hit for the rest of us, if we have to operate from
> uncached space.
> 

In theory, yes, there is a performance penalty. In practice, I doubt
this penalty is significant. Sure, Linux likes to flush cahces, not to
say more. But, did somebody measure the penalty of uncached runs? Even
with microbencnmarks like lmbench.

Regards,
Gleb.
