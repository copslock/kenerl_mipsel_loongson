Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 19:23:23 +0100 (CET)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51689 "EHLO
        out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493776AbZKZSXU convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 19:23:20 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
        by gateway1.messagingengine.com (Postfix) with ESMTP id 73055C1DE9;
        Thu, 26 Nov 2009 13:23:16 -0500 (EST)
Received: from web6.messagingengine.com ([10.202.2.215])
  by compute1.internal (MEProxy); Thu, 26 Nov 2009 13:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:in-reply-to:references:subject:date; s=smtpout; bh=gmUQre/KkGzPZoz2nA0D4xVKcPw=; b=XUKhvT+xo1Qv54ibfkX1ZIAVDrUVhWqWzA7JxL+yWBbr/T3WwqJ/cPaosWfW6V9AaklTb4/umLH4zapmLPlq0Y89DyzTGuB6jMycBBJwWAWS4bXsIwsrRhZVkyQEzpbJaqa+psAx0uOEg9+7fHIlSZXnFkyDPk6AGrWgn7wj9RE=
Received: by web6.messagingengine.com (Postfix, from userid 99)
        id 4DA0BBF77B; Thu, 26 Nov 2009 13:23:16 -0500 (EST)
Message-Id: <1259259796.15040.1347211355@webmail.messagingengine.com>
X-Sasl-Enc: 6PG3jMM6p6kKs28kU+ofkucuvzbz21o2W2uir45pJhi1 1259259796
From:   myuboot@fastmail.fm
To:     "Florian Fainelli" <florian@openwrt.org>
Cc:     "David VomLehn" <dvomlehn@cisco.com>,
        "Chris Dearman" <chris@mips.com>,
        "linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <200911260945.59751.florian@openwrt.org>
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <20091118010351.GA21728@dvomlehn-lnx2.corp.sa.net>
 <1259195053.31777.1347090923@webmail.messagingengine.com>
 <200911260945.59751.florian@openwrt.org>
Subject: Re: problem bring up initramfs and busybox
Date:   Thu, 26 Nov 2009 12:23:16 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips



On Thu, 26 Nov 2009 09:45 +0100, "Florian Fainelli"
<florian@openwrt.org> wrote:
> Hi Andrew.
> 
> Le jeudi 26 novembre 2009 01:24:13, myuboot@fastmail.fm a écrit :
> > On Tue, 17 Nov 2009 20:03 -0500, "David VomLehn" <dvomlehn@cisco.com>
> > 
> > wrote:
> > > On Tue, Nov 17, 2009 at 06:58:35PM -0600, myuboot@fastmail.fm wrote:
> > > > On Wed, 18 Nov 2009 01:39 +0100, "Florian Fainelli"
> > > >
> > > > <florian@openwrt.org> wrote:
> > > > > -------------------------------
> > > >
> > > > Actually I already got this patch for the board in little endian mode,
> > > > and it is still there for the big endian mode. And this is one of the
> > > > place I have been wondering if that needs to be changed for big endian.
> > >
> > > It sounds like you've done a good job getting the bootloader and kernel
> > > to work, so this may be a silly suggestion, but are you sure your root
> > > filesystem and busybox are little-endian? It would be an easy mistake to
> > > make...
> > >
> > > > thanks. Andrew
> > >
> > > David VL
> > 
> > I have some clue on this issue now. It seems there is some problem with
> > the serial console operating in interrupt mode. If the 8250 is in
> > polling mode(set the IRQ for the 8250 serial port to 0), the output on
> > the console is fine. But with 8250 in interrupt mode, 8250 serial driver
> > does not receive any interrupt in serial8250_interrupt(). The same board
> > works just fine when operating in little endian mode with interruption.
> > I probably need to change something in IRQ initialization for big
> > endian. I will post my solution when I can get it to work. In the
> > meantime, any suggestion will be welcome.
> 
> Do you need that patch to work in little-endian: 
> https://dev.openwrt.org/browser/trunk/target/linux/ar7/patches-2.6.30/500-
> serial_kludge.patch ? If so, you are likely to need it in big-endian too
> since 
> it works around a silicon issue.
> -- 
> Best regards, Florian Fainelli
> Email: florian@openwrt.org
> Web: http://openwrt.org
> IRC: [florian] on irc.freenode.net
> -------------------------------
I did not need the patch for little endian. For the UART type, I used
PORT_16550 instead of AR7 and it worked just fine. Thanks for the
suggestion though.
Best regards, Andrew
