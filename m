Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3IC8Z8d012906
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 05:08:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3IC8Z4Y012905
	for linux-mips-outgoing; Thu, 18 Apr 2002 05:08:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3IC8Q8d012895
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 05:08:30 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id QAA31929;
	Thu, 18 Apr 2002 16:09:33 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id QAA07213; Thu, 18 Apr 2002 16:09:17 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id QAA12152; Thu, 18 Apr 2002 16:00:45 +0400 (MSK)
Message-ID: <3CBEB61C.BC6F1746@niisi.msk.ru>
Date: Thu, 18 Apr 2002 16:03:40 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: DBE table ordering
References: <1661.1019123375@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith Owens wrote:
> 
> On Thu, 18 Apr 2002 13:37:14 +0400,
> "Gleb O. Raiko" <raiko@niisi.msk.ru> wrote:
> >If you really hate this behaviour and want to change it, I guess just
> >linear serach is OK.
> 
> Performance matters for these tables.  It is worth doing one sort at
> boot time to let the kernel run faster all the time.  For some tables
> (ia64 unwind) the API mandates that the table be in ascending order.
> 

No, performance doesn't matter here. First, we are speaking about DBE
exception which slowdowns performance. Second, get/put_dbe are used for
peripherial accesses which are slow anyway. Third, do you really want to
speed up probe routines where those macros are used? I guess, not.

Then, how many addresses you have in your dbe_table, 1000 or 6 ? I guess
the latter. In the worst case, linear search requires 12 comparisons,
while binary search takes 6. 6 extra comparisons is nothing in the dbe
handler. If you have more than 6 addresses in the table, just replace
macros by routines and get exactly 6. And 6 comparisons, btw, there is
no need for loop, just 6 if-statements.

I dont't know about other tables and other arches. Perhaps, they need
sorting of some tables. But, definetely, sorting isn't required for mips
dbe/unaligned access tables.

Regards,
Gleb.
