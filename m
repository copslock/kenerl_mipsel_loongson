Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PBqCx28796
	for linux-mips-outgoing; Mon, 25 Jun 2001 04:52:12 -0700
Received: from t111.niisi.ras.ru (IDENT:root@t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5PBqBV28793
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 04:52:11 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id PAA01899;
	Mon, 25 Jun 2001 15:52:32 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA23375; Mon, 25 Jun 2001 15:43:21 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id PAA18194; Mon, 25 Jun 2001 15:45:36 +0400 (MSD)
Message-ID: <3B372893.7EB21D8C@niisi.msk.ru>
Date: Mon, 25 Jun 2001 16:03:31 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@oss.sgi.com
Subject: Re: Bug in memmove
References: <Pine.GSO.3.96.1010622200059.18677C-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej,

"Maciej W. Rozycki" wrote:
> 
>  Ralf, I think it should get applied unless someone cooks up a better
> solution, i.e. optimizes it.  I'll optimize it myself, eventually, if no
> one else does, but don't hold your breath.
> 
Great! Optimized memmove is in todos of several MIPS developers.
Considering your patch and my investigation though, it's not
showstopper. In fact, there are a few places that call memmove, all of
them aren't on "common path". However, I would consider that common path
certainly depends on the way Linux is used. I may imagine the
configuration where the bug may trigger.

Perhaps, eliminating that known "horror fix" (you know) is more
important.

Regards,
Gleb.
