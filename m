Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 14:18:03 +0000 (GMT)
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:35270
	"EHLO vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20038971AbXKZORw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Nov 2007 14:17:52 +0000
Received: from t0b61.t.pppool.de ([89.55.11.97] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1Iwela-00036c-1t; Mon, 26 Nov 2007 14:16:54 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Steve Brown <sbrown@cortland.com>
Subject: Re: ohci-ssb driver on a Broadcom BCM5354
Date:	Mon, 26 Nov 2007 15:15:42 +0100
User-Agent: KMail/1.9.6
Cc:	"John W. Linville" <linville@tuxdriver.com>,
	linux-mips@linux-mips.org
References: <47408305.5090804@cortland.com> <200711191923.56471.mb@bu3sch.de> <474AA87D.7000509@cortland.com>
In-Reply-To: <474AA87D.7000509@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711261515.42501.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Monday 26 November 2007 12:05:33 Steve Brown wrote:
> Michael Buesch wrote:
> > On Sunday 18 November 2007 23:47:52 John W. Linville wrote:
> >   
> >> You probably want to make Michael Buesch aware of this issue.
> >>     
> >
> > I'm not sure anyone really tested this beyond some insmod tests.
> > I did not test this, as I don't have such a device.
> > So if you have any patches to fix this, please send them. I'm
> > certainly the wrong person who can fix this. ;)
> >
> >   
> Adding the following at the end of ssb_ohci_attach seems to fix the problem.
> 
>  if (ssb_dma_set_mask(dev, DMA_32BIT_MASK))
>    return -EOPNOTSUPP;
> 
> I guessed at the dma mask. Would the code in the b43 driver that selects 
> a dma mask be appropriate here?

I have no idea. If it makes it work, yeah. Cool. Let's add this.

-- 
Greetings Michael.
