Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3J8Sg8d028607
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Apr 2002 01:28:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3J8SgaK028606
	for linux-mips-outgoing; Fri, 19 Apr 2002 01:28:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3J8SM8d028581
	for <linux-mips@oss.sgi.com>; Fri, 19 Apr 2002 01:28:33 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id MAA17224;
	Fri, 19 Apr 2002 12:29:16 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id MAA12166; Fri, 19 Apr 2002 12:30:36 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id MAA14299; Fri, 19 Apr 2002 12:24:36 +0400 (MSK)
Message-ID: <3CBFD518.C413C72A@niisi.msk.ru>
Date: Fri, 19 Apr 2002 12:28:08 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Keith Owens <kaos@ocs.com.au>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: DBE table ordering
References: <Pine.GSO.3.96.1020418195601.5266A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej,

"Maciej W. Rozycki" wrote:
> 
> On Thu, 18 Apr 2002, Gleb O. Raiko wrote:
> 
> > I dont't know about other tables and other arches. Perhaps, they need
> > sorting of some tables. But, definetely, sorting isn't required for mips
> > dbe/unaligned access tables.
> 
>  Still it can be done for consistency.  It won't hurt, will it?
> 

Sure, it won't hurt performance. Just looks stupid in this place.

Even if we'll add something like dbe_memcpy, which will require a lot of
addresses in the table in order ot get adequate performance, it'll be
still stupid. And answer your next question, dbe_memcpy is needed for
accesses to busses like VME where Bus{Abort,Error,Fail} are quite legal
and traditionally all of them are traslated to DBE.

Regards,
Gleb.
