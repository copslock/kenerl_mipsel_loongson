Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NCH6Rw023982
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 05:17:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NCH6YG023981
	for linux-mips-outgoing; Tue, 23 Jul 2002 05:17:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f249.dialo.tiscali.de [62.246.17.249])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NCH0Rw023971
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 05:17:02 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6NBdJL10772;
	Tue, 23 Jul 2002 13:39:19 +0200
Date: Tue, 23 Jul 2002 13:39:19 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: sys32_execve fix
Message-ID: <20020723133919.A10566@dea.linux-mips.net>
References: <3D3C0E26.676F4799@mips.com> <3D3C1ACB.E7D17386@mips.com> <3D3D1F9F.68C688D3@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D3D1F9F.68C688D3@mips.com>; from carstenl@mips.com on Tue, Jul 23, 2002 at 11:19:38AM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 23, 2002 at 11:19:38AM +0200, Carsten Langgaard wrote:

> > The patch below should fix that problem, please notice it also include the
> > previous patch I send.
> >
> > Maybe it would be even better to put the "flock32" structure definition in
> > include/asm-mips64/fcntl.h instead.

Yep, did that.  The patch I'm actually going to check in has become quite
a bit larger as I did the quite some cleanup to that file.

  Ralf
