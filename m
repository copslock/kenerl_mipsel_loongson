Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2008 13:38:17 +0000 (GMT)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:6514 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S23634549AbYKLNiO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Nov 2008 13:38:14 +0000
Received: from 71.145.173.151 ([71.145.173.151]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Wed, 12 Nov 2008 13:38:03 +0000
Received: from kh-d820-ubuntu by webmail.razamicroelectronics.com; 12 Nov 2008 07:38:02 -0600
Subject: Re: [PATCH 2/3] Alchemy: Move evalboard code to common directory
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>
In-Reply-To: <491AB16A.3050203@ru.mvista.com>
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>
	 <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226143942.git.mano@roarinelk.homelinux.net>
	 <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net>
	 <1226462433.9026.12.camel@kh-d820-ubuntu.razamicroelectronics.com>
	 <491AB16A.3050203@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Wed, 12 Nov 2008 07:38:02 -0600
Message-Id: <1226497082.9026.23.camel@kh-d820-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Wed, 2008-11-12 at 13:35 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Kevin Hickey wrote:
> 
> > And in keeping with my other email, I think that the evalboards
> > directory is a good idea (though I would recommend the name
> > "develboards" as that is what DB stands for), but it should contain
> >   
>    I'd prefer devel-boards, or dev-boards.
dev-boards works for me.

> 
> > subdirectories for each board and a common directory for common DB code.
> > Smashing all of the board code into one file doesn't leave any room to
> > grow if that file gets too big.
> 
>    I doubt that this could be the case here. And I don't think anybody 
> has placed limits on the source file size so far.
I agree from a technical standpoint.  I meant that if the files
logically grew too much and it was desirable to split them, there would
be nowhere to put the split files.  On the other hand, I suppose that we
don't need that today and we can always create the directory later if
necessary...

> 
> > Also, a single common.c will not be sufficient in the future.
> >   
> 
>    Wait, the file only includes prom_init() for now, so might be worth 
> renaming it...
> 
> > =Kevin
> >
> > On Sat, 2008-11-08 at 13:08 +0100, Manuel Lauss wrote:
> >   
> >> Move all code of the Pb/Db boards to a single subdirectory and extract
> >> some common code.
> >>
> >> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> >>     
> 
>     And now I'll have to give Kevin two lessons of the network etiquette:
> 
> - don't top-post (your comments should be below the quoted text you're 
> replying to);
> - above all, don't leave tens of KBs of uncommented patch behind, do 
> spend several seconds to delete it!
My apologies.  I will comply in this and future posts.

> 
> WBR, Sergei
> 
> 
=Kevin
-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P: 512.691.8044
