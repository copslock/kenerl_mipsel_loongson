Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OG0SnC002119
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 09:00:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OG0SZM002118
	for linux-mips-outgoing; Mon, 24 Jun 2002 09:00:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OG0InC002115;
	Mon, 24 Jun 2002 09:00:22 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id UAA28048;
	Mon, 24 Jun 2002 20:03:48 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id TAA26858; Mon, 24 Jun 2002 19:56:55 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id TAA29978; Mon, 24 Jun 2002 19:59:33 +0400 (MSK)
Message-ID: <3D174330.BAEBC56@niisi.msk.ru>
Date: Mon, 24 Jun 2002 20:05:04 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Carsten Langgaard <carstenl@mips.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Bug in __copy_user
References: <3D1729F3.7241A74A@mips.com> <3D17376B.59333E27@niisi.msk.ru> <20020624173954.A1109@dea.linux-mips.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> Gleb,
> 
> On Mon, Jun 24, 2002 at 07:14:51PM +0400, Gleb O. Raiko wrote:
> 
> > This patch also solves the problem for mips in 2.4/2.5 kernel. My
> > question was about the patch for mips64 and mips in 2.2 kernel.
> >
> > Shall memcpy.S from 2.4/2.5 be backported to 2.2 and mips64?
> 
> I think that would be the prefered solution as it'll be easier to maintain.
> 
> I've not received any 2.2 patches in a very long, long time - anybody
> actually still using it?

Yes, I am still using 2.2. Considering pathes, I've got patches for r3k,
which doesn't work with a standard 2.2 kernel. But those patches are
backports from 2.4. So, I don't think they shall be applied. From other
hand, I don't plan develop 'normal' patches for 2.2.

Regards,
Gleb.
