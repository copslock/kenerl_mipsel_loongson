Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3I9mu8d003771
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 02:48:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3I9muMS003770
	for linux-mips-outgoing; Thu, 18 Apr 2002 02:48:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3I9mm8d003715
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 02:48:50 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id NAA25787;
	Thu, 18 Apr 2002 13:49:36 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA06619; Thu, 18 Apr 2002 13:50:26 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id NAA05540; Thu, 18 Apr 2002 13:47:08 +0400 (MSK)
Message-ID: <3CBE96CD.43620756@niisi.msk.ru>
Date: Thu, 18 Apr 2002 13:50:05 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: Update of RedHat 7.1/mips
References: <20020417210843.A10182@lucon.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

"H . J . Lu" wrote:
> 
> FYI, I updated a few packages in RedHat 7.1/mips. It has new gcc,
> glibc, binutils and gdb.

Will your glibc work on r3k (w/o ll, sc, double word instructions)? Or
you just don't care about 3rd class processors? 

Do you compile your distribution with -mips2 or there is a chance it
will work on r3k?
 
Regards,
Gleb.
