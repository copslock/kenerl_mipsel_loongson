Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OG40nC002234
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 09:04:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OG403N002233
	for linux-mips-outgoing; Mon, 24 Jun 2002 09:04:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OG3snC002230;
	Mon, 24 Jun 2002 09:03:55 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id JAA12383;
	Mon, 24 Jun 2002 09:07:08 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA07155;
	Mon, 24 Jun 2002 09:07:06 -0700 (PDT)
Message-ID: <019401c21b99$387ce290$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: "Carsten Langgaard" <carstenl@mips.com>, <linux-mips@oss.sgi.com>
References: <3D1729F3.7241A74A@mips.com> <3D17376B.59333E27@niisi.msk.ru> <20020624173954.A1109@dea.linux-mips.net>
Subject: Re: Bug in __copy_user
Date: Mon, 24 Jun 2002 18:07:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

From: "Ralf Baechle" <ralf@oss.sgi.com> 
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

Only a few thousand (or tens of thousands) of Sony Playstation 2
users.  ;-)  Most of them are running the wierd 2.2.1.?? Sony
branch, but there are a few poor deluded souls tryng to update
to 2.2.20...

            Kevin K.
