Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OFeqnC001179
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 08:40:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OFeqEa001178
	for linux-mips-outgoing; Mon, 24 Jun 2002 08:40:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-18.ka.dial.de.ignite.net [62.180.196.18])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OFelnC001175
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 08:40:49 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5OFdtV01135;
	Mon, 24 Jun 2002 17:39:55 +0200
Date: Mon, 24 Jun 2002 17:39:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: Carsten Langgaard <carstenl@mips.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Bug in __copy_user
Message-ID: <20020624173954.A1109@dea.linux-mips.net>
References: <3D1729F3.7241A74A@mips.com> <3D17376B.59333E27@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D17376B.59333E27@niisi.msk.ru>; from raiko@niisi.msk.ru on Mon, Jun 24, 2002 at 07:14:51PM +0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Gleb,

On Mon, Jun 24, 2002 at 07:14:51PM +0400, Gleb O. Raiko wrote:

> This patch also solves the problem for mips in 2.4/2.5 kernel. My
> question was about the patch for mips64 and mips in 2.2 kernel.
> 
> Shall memcpy.S from 2.4/2.5 be backported to 2.2 and mips64?

I think that would be the prefered solution as it'll be easier to maintain.

I've not received any 2.2 patches in a very long, long time - anybody
actually still using it?

  Ralf
