Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DID6f15910
	for linux-mips-outgoing; Mon, 13 Aug 2001 11:13:06 -0700
Received: from t111.niisi.ras.ru (IDENT:root@[193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DID1j15907;
	Mon, 13 Aug 2001 11:13:02 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id WAA05475;
	Mon, 13 Aug 2001 22:12:55 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id VAA01383; Mon, 13 Aug 2001 21:55:58 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id WAA08024; Mon, 13 Aug 2001 22:08:59 +0400 (MSD)
Message-ID: <3B781837.33B9E438@niisi.msk.ru>
Date: Mon, 13 Aug 2001 22:11:03 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, Harald Koerfgen <hkoerfg@web.de>,
   Keith Owens <kaos@ocs.com.au>, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Make __dbe_table available to modules
References: <Pine.GSO.3.96.1010813181607.23241N-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



"Maciej W. Rozycki" wrote:
>  The MIPS architecture defines the bus error exception event for data
> reads and instruction fetches only.  Writes are asynchronous so errors on
> them cannot be reported exactly -- some MIPS documentation recommends
> using a general-purpose interrupt line for such events.
> 

DBE is treated as ACK* on write. Some HW design manuals advise to use
this fact even.

Regards,
Gleb.
