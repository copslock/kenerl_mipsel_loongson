Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3IGmQ8d032702
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 09:48:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3IGmQfT032701
	for linux-mips-outgoing; Thu, 18 Apr 2002 09:48:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3IGmK8d032692
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 09:48:22 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id UAA03333;
	Thu, 18 Apr 2002 20:49:28 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id UAA08492; Thu, 18 Apr 2002 20:50:09 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id UAA22066; Thu, 18 Apr 2002 20:47:21 +0400 (MSK)
Message-ID: <3CBEF932.5F189B55@niisi.msk.ru>
Date: Thu, 18 Apr 2002 20:49:54 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: Update of RedHat 7.1/mips
References: <20020417210843.A10182@lucon.org> <3CBE96CD.43620756@niisi.msk.ru> <20020418093208.B20868@lucon.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:
> 
> On Thu, Apr 18, 2002 at 01:50:05PM +0400, Gleb O. Raiko wrote:
> > Hi,
> >
> > "H . J . Lu" wrote:
> > >
> > > FYI, I updated a few packages in RedHat 7.1/mips. It has new gcc,
> > > glibc, binutils and gdb.
> >
> > Will your glibc work on r3k (w/o ll, sc, double word instructions)? Or
> > you just don't care about 3rd class processors?
> >
> 
> I didn't compile anything with -mipsN. But I don't have a r3k to test.

OK. I will test myself.

Regards,
Gleb.
