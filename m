Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g54HfDnC002316
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 10:41:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g54HfD4B002315
	for linux-mips-outgoing; Tue, 4 Jun 2002 10:41:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g54Hf5nC002310
	for <linux-mips@oss.sgi.com>; Tue, 4 Jun 2002 10:41:07 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id VAA07238;
	Tue, 4 Jun 2002 21:43:01 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id VAA13814; Tue, 4 Jun 2002 21:38:21 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id VAA07610; Tue, 4 Jun 2002 21:40:15 +0400 (MSK)
Message-ID: <3CFCFC79.E846226B@niisi.msk.ru>
Date: Tue, 04 Jun 2002 21:44:25 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: mb() and friends again
References: <Pine.GSO.3.96.1020604164624.17556E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> > Why did you drop it? It's definetely required.
> 
>  Nope, it wasn't dropped.  It's included in a different patch, namely
> "patch-mips-2.4.18-20020412-wbflush-5".  The patch depends on the
> "patch-mips-2.4.18-20020530-mb-wb-8" one, so I am not going to resubmit
> the former one for discussion here until (unless) we decide on the latter
> one.

Don't forget the latter one. :-)

> 
> > While you patch operates in unusual terms from hw point of view, it does
> > right thins by stating that external wbs do differ from internal wb.
> 
>  What do you mean by "unusual terms"?  The names of the macros?  Well,
> they are based on what's used for other platforms and if treated as
> abstract names (as they should be) they actually reflect reality.
> 

Basically, the patch logically allows combination of a CPU with internal
write-buffer and an external wb chip. It's impossible if hw designers
don't smoke hard. :-)

In fact, CONFIG_CPU_HAS_WB means !CONFIG_CPU_HAS_WB, i.e. CPU don't have
built-in write-buffer logic and there is an external write-buffer chip
somewhere in the box.
("Somewhere" means a place on the path from the local bus to a memory
controller.)

Then, __fast_iob just flushes internal wb while wbflush flushes an
external wb.

That's why I call it "unusual terms from hw POV". 

But, don't reimplement the patch, please. It's OK. Just from software
point of view.

Regards,
Gleb.
