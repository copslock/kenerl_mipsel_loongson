Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OBtIw11872
	for linux-mips-outgoing; Fri, 24 Aug 2001 04:55:18 -0700
Received: from t111.niisi.ras.ru (IDENT:root@[193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OBsqd11818
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 04:55:16 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id PAA29917;
	Fri, 24 Aug 2001 15:54:18 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA00515; Fri, 24 Aug 2001 15:30:15 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id NAA20181; Fri, 24 Aug 2001 13:41:50 +0400 (MSD)
Message-ID: <3B862174.435C0324@niisi.msk.ru>
Date: Fri, 24 Aug 2001 13:42:12 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
References: <Pine.GSO.3.96.1010823174707.21718F-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
>  Well, other system might as well (e.g. DECstations can), but that doesn't
> solve the problem -- to access firmware variables you need to know which
> kind of firmware you are on.
> 

No way at run-time. You have to choose the box during compilation in
order to supply linker with proper load address.

Regards,
Gleb.
