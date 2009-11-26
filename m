Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 01:24:18 +0100 (CET)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:41150 "EHLO
        out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493673AbZKZAYP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2009 01:24:15 +0100
Received: from compute2.internal (compute2.internal [10.202.2.42])
        by gateway1.messagingengine.com (Postfix) with ESMTP id A4793C1D56;
        Wed, 25 Nov 2009 19:24:13 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute2.internal (MEProxy); Wed, 25 Nov 2009 19:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:in-reply-to:references:subject:date; s=smtpout; bh=knimOq2Kia1VeSfW8Hy9IW+gcMs=; b=CGgdG5jtjuc1mtDl59KsP5OiJFZhmkmG5+Zein+Rwl1UBta//s1PKkUX6AbZAT0Xz3hBYdNo/vw6kaSo3Tsz80zOflr8zH2WWUxO7hQrQXHTFRaq0htMcBMIZao5Vx4G826cE005jGy9ZPSNu8KzDqPYrUN2g4zPB/f7DZCXj7c=
Received: by web8.messagingengine.com (Postfix, from userid 99)
        id 88605103BE0; Wed, 25 Nov 2009 19:24:13 -0500 (EST)
Message-Id: <1259195053.31777.1347090923@webmail.messagingengine.com>
X-Sasl-Enc: RDZMLBS19hOPvThszxj+KJiPwKh3x4bUtSVUKpjWYyWC 1259195053
From:   myuboot@fastmail.fm
To:     "David VomLehn" <dvomlehn@cisco.com>
Cc:     "Florian Fainelli" <florian@openwrt.org>,
        "Chris Dearman" <chris@mips.com>,
        "linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <20091118010351.GA21728@dvomlehn-lnx2.corp.sa.net>
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4B031B78.5030204@mips.com>
 <1258504293.3627.1345755107@webmail.messagingengine.com>
 <200911180139.29283.florian@openwrt.org>
 <1258505915.7077.1345760963@webmail.messagingengine.com>
 <20091118010351.GA21728@dvomlehn-lnx2.corp.sa.net>
Subject: Re: problem bring up initramfs and busybox
Date:   Wed, 25 Nov 2009 18:24:13 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

On Tue, 17 Nov 2009 20:03 -0500, "David VomLehn" <dvomlehn@cisco.com>
wrote:
> On Tue, Nov 17, 2009 at 06:58:35PM -0600, myuboot@fastmail.fm wrote:
> > 
> > On Wed, 18 Nov 2009 01:39 +0100, "Florian Fainelli"
> > <florian@openwrt.org> wrote:
> > > -------------------------------
> > Actually I already got this patch for the board in little endian mode,
> > and it is still there for the big endian mode. And this is one of the
> > place I have been wondering if that needs to be changed for big endian. 
> 
> It sounds like you've done a good job getting the bootloader and kernel
> to work, so this may be a silly suggestion, but are you sure your root
> filesystem and busybox are little-endian? It would be an easy mistake to
> make...
> 
> > thanks. Andrew
> 
> David VL
I have some clue on this issue now. It seems there is some problem with
the serial console operating in interrupt mode. If the 8250 is in
polling mode(set the IRQ for the 8250 serial port to 0), the output on
the console is fine. But with 8250 in interrupt mode, 8250 serial driver
does not receive any interrupt in serial8250_interrupt(). The same board
works just fine when operating in little endian mode with interruption.
I probably need to change something in IRQ initialization for big
endian. I will post my solution when I can get it to work. In the
meantime, any suggestion will be welcome.

Best regards, Andrew
