Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GEDERw031816
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 07:13:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GEDEDY031815
	for linux-mips-outgoing; Tue, 16 Jul 2002 07:13:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f125.dialo.tiscali.de [62.246.17.125])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GED7Rw031805
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 07:13:09 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6GAaW317905;
	Tue, 16 Jul 2002 12:36:32 +0200
Date: Tue, 16 Jul 2002 12:36:32 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "H. J. Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: Personality
Message-ID: <20020716123632.B17038@dea.linux-mips.net>
References: <3D33DAB2.353A4399@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D33DAB2.353A4399@mips.com>; from carstenl@mips.com on Tue, Jul 16, 2002 at 10:34:58AM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 16, 2002 at 10:34:58AM +0200, Carsten Langgaard wrote:

> The include/linux/personality.h file has changed between the 2.4.3 and
> the 2.4.18 kernel.
> Now there is a define of personality (#define personality(pers) (pers &
> PER_MASK), but that breaks things for the users, if they include this
> file.
> The user wishes to call the glibc personality function (which do the
> syscall), and not use the above definition.
> 
> So I guess we need a "#ifdef __KERNEL__" around some of the code in
> include/linux/personality.h (at least around the define of personality),
> which then has to go into the glibc kernel header files.

The general policy about such problems is to not use kernel include files
from user applications directly.  Hjl - maybe time for <sys/personality.h>?

  Ralf
