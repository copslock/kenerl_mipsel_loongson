Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 16:54:55 +0100 (BST)
Received: from adsl-72-19.38-151.net24.it ([IPv6:::ffff:151.38.19.72]:4009
	"EHLO zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8225002AbVEEPyk> convert rfc822-to-8bit; Thu, 5 May 2005 16:54:40 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DTigN-0000AR-00
	for <linux-mips@linux-mips.org>; Thu, 05 May 2005 17:54:35 +0200
Date:	Thu, 5 May 2005 17:54:35 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: USB hangs on AU1100
Message-ID: <20050505155435.GA28227@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

I'm just using USB host support on a AU1100 developing board (DB1100
configuration) and i notice that CPU locks in function
au1xxx_start_hc():

        /* wait for reset complete (read register twice; see au1500 errata) */
        while (au_readl(USB_HOST_CONFIG),
                !(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
                udelay(1000);

while waiting for USB controller to reset. I checked it out and I
discovered that register USB_HOST_CONFIG is fixed at value 0xe! So the
controller never reset...

Linux is 2.6.12-rc3 from CVS.

Someone knows whats wrong?

Thanks in advance,

Rodolfo Giometti

-- 

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127
