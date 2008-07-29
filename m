Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 05:02:25 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:55643 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20034753AbYG2ECO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Jul 2008 05:02:14 +0100
Received: from 71.145.167.199 ([71.145.167.199]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Tue, 29 Jul 2008 04:02:06 +0000
Received: from kh-d820-ubuntu by webmail.razamicroelectronics.com; 28 Jul 2008 23:02:05 -0500
Subject: Re: [PATCH v2 1/1][MIPS] Initialization of Alchemy boards
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, dmitri.vorobiev@movial.fi
In-Reply-To: <20080728223603.GA1430@linux-mips.org>
References: <1217268566.19887.3.camel@kh-ubuntu.razamicroelectronics.com>
	 <20080728223603.GA1430@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Mon, 28 Jul 2008 22:56:04 -0500
Message-Id: <1217303764.9702.4.camel@kh-d820-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Ralf,

On Mon, 2008-07-28 at 23:36 +0100, Ralf Baechle wrote:
> On Mon, Jul 28, 2008 at 01:09:26PM -0500, Kevin Hickey wrote:
> 
> >   An earlier update changed some calls from simple_strotl to
> > strict_strtol but did not account for the differences in the syntax
> > between the calls.simple_strotl returns the integer; strict_strtol
> > returns an error code and takes a pointer to the result.  As it was,
> > NULL was being passed in place of the result, which led to failures
> > during kernel initialization when using YAMON.
> > 
> > Signed-off-by:  Kevin Hickey <khickey@rmicorp.com>
> > 
> >  arch/mips/au1000/db1x00/init.c  |    2 +-
> >  arch/mips/au1000/mtx-1/init.c   |    2 +-
> >  arch/mips/au1000/pb1000/init.c  |    2 +-
> >  arch/mips/au1000/pb1100/init.c  |    2 +-
> >  arch/mips/au1000/pb1200/init.c  |    2 +-
> >  arch/mips/au1000/pb1500/init.c  |    2 +-
> >  arch/mips/au1000/pb1550/init.c  |    2 +-
> >  arch/mips/au1000/xxs1500/init.c |    2 +-
> >  8 files changed, 8 insertions(+), 8 deletions(-)
> 
> One little nit on the submission format - if you include a diffstat, please
> put it after a line consisting only of three - like this:
It was only after creating this that I discovered git-format-patch.
I'll use that in the future (I can assume that it handles stat lines
correctly, right?).
> 
> ---
>  arch/mips/au1000/db1x00/init.c  |    2 +-
>  arch/mips/au1000/mtx-1/init.c   |    2 +-
>  arch/mips/au1000/pb1000/init.c  |    2 +-
> 
> This keeps git and other tools that try to extract the body of the mail
> for the description from considering the diffstat as part of the
> description.
> 
> Patch applied, thanks!
Thanks!  Is there any chance of this making it into 2.6.27?  I saw that
Linus marked the master branch as 2.6.27-rc1 today, so I'm not very
optimistic.  But I have to make some decisions about internal releases
etc and I'm still trying to get a handle on how the kernel gets
versioned. 
> 
>   Ralf
> 
-Kevin
