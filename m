Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAUIjZL26867
	for linux-mips-outgoing; Fri, 30 Nov 2001 10:45:35 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAUIjVo26862
	for <linux-mips@oss.sgi.com>; Fri, 30 Nov 2001 10:45:32 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 169rrU-0004GN-00; Fri, 30 Nov 2001 17:54:08 +0000
Subject: Re: pcmcia
To: ppopov@mvista.com (Pete Popov)
Date: Fri, 30 Nov 2001 17:54:08 +0000 (GMT)
Cc: gmo@broadcom.com (Guillermo A. Loyola),
   linux-mips@oss.sgi.com (linux-mips),
   linux-mips-kernel@lists.sourceforge.net (sforge)
In-Reply-To: <1007141701.22949.140.camel@zeus> from "Pete Popov" at Nov 30, 2001 09:35:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169rrU-0004GN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > We need the same here, how about doing this instead:
> > 
> > #ifdef __i386__
> > typedef u_short   ioaddr_t;
> > #else
> > typedef u_int	ioaddr_t;
> > #endif
> 
> That probably makes more sense.  I wasn't sure if it's only x86 that
> needs? ioaddr_t to be a 16 bit type.  

Is there any platform where making it int actually -breaks-. At least for
2.5 it would seem a lot saner to just make it bigger and see

Alan
