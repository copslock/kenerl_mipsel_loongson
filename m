Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OBsdV11745
	for linux-mips-outgoing; Fri, 24 Aug 2001 04:54:39 -0700
Received: from t111.niisi.ras.ru (IDENT:root@[193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OBsZd11741
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 04:54:35 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id PAA29920;
	Fri, 24 Aug 2001 15:54:19 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA00514; Fri, 24 Aug 2001 15:30:14 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id NAA20010; Fri, 24 Aug 2001 13:37:24 +0400 (MSD)
Message-ID: <3B86206C.832A9801@niisi.msk.ru>
Date: Fri, 24 Aug 2001 13:37:48 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Jun Sun <jsun@mvista.com>, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
References: <Pine.GSO.3.96.1010823192712.21718H-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
>  It sounds reasonable.  We may also check the Alpha port for solutions --
> it supports multiple dissimilar systems as well.

Alpha is easy and simple from my POV, it has just SRM or MILO, kernel at
fixed location anyway. 

In our case, almost every box has own location for kernel varying from
0x80000000 for brave people to 0x80100000 for people who doesn't care
much about 1 MB :-). (Well, I clearly understand it's firmware
requirements, not people's preferences. Almost.) Then, various binary
formats of the kernel image...

I personally prefer PPC with its _machine tricks and SPARC for BTFIXUP
stuff.

However, I doubt whether we could support single kernel image for all
MIPS boxes. MIPS is typical embedded platform, where standards are
favourite because there are so many to choose from.

BTW, I remember, Ralf tried to implement CPU type recognition at
run-time, he dropped his efforts after he realized nobody could use this
feature because boxes are so different.

Regards,
Gleb.
