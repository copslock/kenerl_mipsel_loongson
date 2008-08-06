Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 22:07:57 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:55902 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S28576560AbYHFVHu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Aug 2008 22:07:50 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Wed,  6 Aug 2008 21:07:42 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 06 Aug 2008 16:08:08 -0500
Subject: Re: [PATCH v2] au1xmmc: raise segment size limit.
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Pierre Ossman <drzeus@drzeus.cx>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20080806225229.7914d736@mjolnir.drzeus.cx>
References: <20080729081049.GB3908@roarinelk.homelinux.net>
	 <1218052355.3808.4.camel@kh-ubuntu.razamicroelectronics.com>
	 <20080806225229.7914d736@mjolnir.drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Wed, 06 Aug 2008 16:08:08 -0500
Message-Id: <1218056888.3808.10.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Has this been applied?  If so, where?  I don't see it in the LMO master
tree... (though I have been known to experience temporary blindness...)

-Kevin

On Wed, 2008-08-06 at 22:52 +0200, Pierre Ossman wrote:
> On Wed, 6 Aug 2008 12:52:35 -0700
> "Kevin Hickey" <khickey@rmicorp.com> wrote:
> 
> > On Tue, 2008-07-29 at 10:10 +0200, Manuel Lauss wrote:
> > > --- 
> > > 
> > > Raise the DMA block size limit from 2048 bytes to the maximum supported
> > > by the DMA controllers on the chip (64KB on Au1100, 4MB on Au1200).
> > > 
> > > This gives a very small performance boost and apparently fixes an oops
> > > when MMC-DMA and network traffic are active at the same time.
> > > 
> > > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> > I tested this in conjunction with "Alchemy: register platform device for
> > db1200..." successfully.
> > 
> > Acked-by: Kevin Hickey <khickey@rmicorp.com>
> 
> You're about a week too late ;)
