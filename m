Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f64CMEw14346
	for linux-mips-outgoing; Wed, 4 Jul 2001 05:22:14 -0700
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f64CMDV14343
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 05:22:13 -0700
Received: from t111.niisi.ras.ru (root@t111.niisi.ras.ru [193.232.173.111]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA09452
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 05:22:04 -0700 (PDT)
	mail_from (raiko@niisi.msk.ru)
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id QAA03222;
	Wed, 4 Jul 2001 16:09:19 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id QAA01776; Wed, 4 Jul 2001 16:05:28 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id QAA21772; Wed, 4 Jul 2001 16:06:27 +0400 (MSD)
Message-ID: <3B430AC6.6F8F6DD1@niisi.msk.ru>
Date: Wed, 04 Jul 2001 16:23:34 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
CC: linux-mips@oss.sgi.com
Subject: Re: sti() does not work.
References: <20010704122329.B30713@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thiemo Seufer wrote:
> > extern __inline__ void  __sti(void)
> > {
> >       __asm__ __volatile__(
> >               ".set\tnoreorder\n\t"
> >               ".set\tnoat\n\t"
> >               "mfc0\t$1,$12\n\t"
> >               "ori\t$1,0x1f\n\t"
> >               "xori\t$1,0x1e\n\t"
> >               "mtc0\t$1,$12\n\t"               /* <----- problem  here
> > ! */
> 
> Here should follow some nop's on a MIPS I system to make sure $12
> is written (why is noreorder used here?).
> 

Support for r3k in 2.2 is broken for a long time. Use 2.4 instead.

Regards,
Gleb.
