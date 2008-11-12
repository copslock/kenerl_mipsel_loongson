Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2008 13:39:31 +0000 (GMT)
Received: from [63.111.213.197] ([63.111.213.197]:55410 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S23340233AbYKLNj2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Nov 2008 13:39:28 +0000
Received: from 71.145.173.151 ([71.145.173.151]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Wed, 12 Nov 2008 13:39:21 +0000
Received: from kh-d820-ubuntu by webmail.razamicroelectronics.com; 12 Nov 2008 07:39:20 -0600
Subject: Re: [PATCH 2/3] Alchemy: Move evalboard code to common directory
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>
In-Reply-To: <20081112120528.GA11667@roarinelk.homelinux.net>
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>
	 <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226143942.git.mano@roarinelk.homelinux.net>
	 <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net>
	 <1226462433.9026.12.camel@kh-d820-ubuntu.razamicroelectronics.com>
	 <491AB16A.3050203@ru.mvista.com>
	 <20081112120528.GA11667@roarinelk.homelinux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Wed, 12 Nov 2008 07:39:20 -0600
Message-Id: <1226497160.9026.25.camel@kh-d820-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Wed, 2008-11-12 at 13:05 +0100, Manuel Lauss wrote:
> Hello,
> 
> On Wed, Nov 12, 2008 at 01:35:22PM +0300, Sergei Shtylyov wrote:
> > Hello.
> >
> > Kevin Hickey wrote:
> >
> >> And in keeping with my other email, I think that the evalboards
> >> directory is a good idea (though I would recommend the name
> >> "develboards" as that is what DB stands for), but it should contain
> >>   
> >
> >   I'd prefer devel-boards, or dev-boards.
> 
> Can we settle on "devboards" without the hyphen?  Everybody okay with that?
I'd prefer dev-boards but I'm not so vested that I'm willing to get into
a protracted semantic argument about it.
> 
> 
> >> subdirectories for each board and a common directory for common DB code.
> >> Smashing all of the board code into one file doesn't leave any room to
> >> grow if that file gets too big.
> >
> >   I doubt that this could be the case here. And I don't think anybody has 
> > placed limits on the source file size so far.
> >
> >> Also, a single common.c will not be sufficient in the future.
> >>   
> >
> >   Wait, the file only includes prom_init() for now, so might be worth 
> > renaming it...
> 
> I planned on putting some of the code currently living in common/ into it.
> Not a good idea?  Then I'll rename it to prom.c and leave it alone.
If you do that then keep it common.c; otherwise rename.
> 
> 
> Thoughts?
> 
> Thanks,
> 	Manuel Lauss
=Kevin
-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P: 512.691.8044
