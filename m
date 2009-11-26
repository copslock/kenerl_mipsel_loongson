Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 09:46:10 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.156]:27658 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492652AbZKZIqG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 09:46:06 +0100
Received: by fg-out-1718.google.com with SMTP id 19so191077fgg.6
        for <linux-mips@linux-mips.org>; Thu, 26 Nov 2009 00:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=vQXcXcVPFGy/M9lta0ksNSmiM0DkgAT1U28LMevoyLg=;
        b=HiuhRA+GiEMPkU1Vg0A1x7Wv5rrBW+PovsSim90miMGsvbakk4oVXkDz8c7Dx5sr+e
         wJdXIqcAgWxQyzwcCtulHIx/I52+++DVmFpLGgP0GyNNkh3VIr6lMgyj8aV/peU90Gur
         bgEUTKNLyTKgBL8Bt0Ql+FzhF24QmVA6n0WGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=gsxsrlT4w3ls/akrn4wONkznxOwstjLww9SMYQq3CxRqN9A+MwW+s4bVzxbERIWUJr
         otoV91NGnNA2GREPZJEZ+4h0fjtPKrSNKSQE+QMEdys2tdWoZdAWb+Zje8hjvXQl4w0g
         PdPIOl/PVAiln5IVGM7Yn29d5MOniE1sAckfA=
Received: by 10.87.73.4 with SMTP id a4mr7705057fgl.76.1259225162174;
        Thu, 26 Nov 2009 00:46:02 -0800 (PST)
Received: from lenovo.localnet (florian.mimichou.net [88.178.11.95])
        by mx.google.com with ESMTPS id l12sm1787140fgb.25.2009.11.26.00.46.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 00:46:00 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     myuboot@fastmail.fm
Subject: Re: problem bring up initramfs and busybox
Date:   Thu, 26 Nov 2009 09:45:58 +0100
User-Agent: KMail/1.12.1 (Linux/2.6.30-2-686; KDE/4.3.2; i686; ; )
Cc:     "David VomLehn" <dvomlehn@cisco.com>,
        "Chris Dearman" <chris@mips.com>,
        "linux-mips" <linux-mips@linux-mips.org>
References: <1255735395.30097.1340523469@webmail.messagingengine.com> <20091118010351.GA21728@dvomlehn-lnx2.corp.sa.net> <1259195053.31777.1347090923@webmail.messagingengine.com>
In-Reply-To: <1259195053.31777.1347090923@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200911260945.59751.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Andrew.

Le jeudi 26 novembre 2009 01:24:13, myuboot@fastmail.fm a écrit :
> On Tue, 17 Nov 2009 20:03 -0500, "David VomLehn" <dvomlehn@cisco.com>
> 
> wrote:
> > On Tue, Nov 17, 2009 at 06:58:35PM -0600, myuboot@fastmail.fm wrote:
> > > On Wed, 18 Nov 2009 01:39 +0100, "Florian Fainelli"
> > >
> > > <florian@openwrt.org> wrote:
> > > > -------------------------------
> > >
> > > Actually I already got this patch for the board in little endian mode,
> > > and it is still there for the big endian mode. And this is one of the
> > > place I have been wondering if that needs to be changed for big endian.
> >
> > It sounds like you've done a good job getting the bootloader and kernel
> > to work, so this may be a silly suggestion, but are you sure your root
> > filesystem and busybox are little-endian? It would be an easy mistake to
> > make...
> >
> > > thanks. Andrew
> >
> > David VL
> 
> I have some clue on this issue now. It seems there is some problem with
> the serial console operating in interrupt mode. If the 8250 is in
> polling mode(set the IRQ for the 8250 serial port to 0), the output on
> the console is fine. But with 8250 in interrupt mode, 8250 serial driver
> does not receive any interrupt in serial8250_interrupt(). The same board
> works just fine when operating in little endian mode with interruption.
> I probably need to change something in IRQ initialization for big
> endian. I will post my solution when I can get it to work. In the
> meantime, any suggestion will be welcome.

Do you need that patch to work in little-endian: 
https://dev.openwrt.org/browser/trunk/target/linux/ar7/patches-2.6.30/500-
serial_kludge.patch ? If so, you are likely to need it in big-endian too since 
it works around a silicon issue.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
