Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3I9cj8d003062
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 02:38:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3I9cjrN003061
	for linux-mips-outgoing; Thu, 18 Apr 2002 02:38:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from niisi.wave.ras.ru (niisi.wave.ras.ru [194.85.104.220])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3I9cd8d003053
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 02:38:40 -0700
Received: from t06.niisi.ras.ru (t06.systud.msk.su [193.232.173.6])
	by niisi.wave.ras.ru (8.9.1/8.9.1) with ESMTP id NAA19836;
	Thu, 18 Apr 2002 13:39:55 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA06541; Thu, 18 Apr 2002 13:38:01 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id NAA05008; Thu, 18 Apr 2002 13:34:16 +0400 (MSK)
Message-ID: <3CBE93CA.EB27DB1A@niisi.msk.ru>
Date: Thu, 18 Apr 2002 13:37:14 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: DBE table ordering
References: <314.1019112700@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith,

Keith Owens wrote:
> 
> This is a more general problem than mips dbe, other kernel tables and
> other architectures will have the same problem.  I will do a general
> patch against 2.5.8 to sort these tables at init time, and backport the
> general fix to 2.4.19 later.  In the meantime your patch will bypass
> the problem for mips dbe.

Consider it as a feature. It was known from the time Ralf designed it. 

If you really hate this behaviour and want to change it, I guess just
linear serach is OK. Or just introduce set of get/put_dbe{b,w,l}
routines instead of macros and expect just one fault address (well, 6
addresses, if you care). I think, it's better than rearranging the table
on startup (your proposal) and searching in several dbe tables (was
introduced last year).

Another table (in fact, I know only the unaligned access table in
arch/mips*/unaligned.c) is immune, because call from an __init routine
from user space is somewhat tricky and, anyway, isn't allowed.

If you know other tables, I think it's better to find a solution on
individual basis. No needs for a common solution here. 

Regards,
Gleb.
