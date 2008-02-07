Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 21:01:54 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:62593 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S20038266AbYBGVBp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Feb 2008 21:01:45 +0000
Received: (qmail 30516 invoked from network); 7 Feb 2008 21:01:43 -0000
Received: from unknown (HELO ?10.41.13.129?) (38.101.235.133)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 7 Feb 2008 14:01:43 -0700
Subject: RE: iomemory causing a data bus error
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	Don Hiatt <DHiatt@zeugmasystems.com>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C57986B1@exchange.ZeugmaSystems.local>
References: <1202397602.3298.25.camel@localhost>
	 <1202416377.3298.44.camel@localhost>
	 <DDFD17CC94A9BD49A82147DDF7D545C57986B1@exchange.ZeugmaSystems.local>
Content-Type: text/plain
Date:	Thu, 07 Feb 2008 16:01:11 -0500
Message-Id: <1202418072.3298.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips

> Take a look at /proc/interrupts to see if you have something firing
> that you do not expect.

I took a look and this is what I see:

# cat /proc/interrupts 
           CPU0       
  2:          0   PNX Level IRQ  GIC
  7:          0   PNX Level IRQ  Timer
 10:        661   PNX Level IRQ  pnx8550-1
 11:        605   PNX Level IRQ  pnx8550-2
 13:          1   PNX Level IRQ  ohci_hcd:usb2
 23:        583   PNX Level IRQ  i2c
 24:        845   PNX Level IRQ  i2c
 28:        334   PNX Level IRQ  pnx8xxx-uart
 34:          1   PNX Level IRQ  Drawing Engine
 47:          0   PNX Level IRQ  vmsp1
 49:          0   PNX Level IRQ  vmsp2
 55:      15876   PNX Level IRQ  libata, ehci_hcd:usb1, ohci_hcd:usb3, ohci_hcd:usb4, eth0
 75:         18   PNX Level IRQ  i2c
 78:        192   PNX Level IRQ  i2c
 79:      80239   PNX Level IRQ  timer
 80:         19   PNX Level IRQ  Monotonic timer

ERR:      99373

It looks like there are quite a few devices on irq 55 even before I load
my module. Is it at all possible that I could get my device to use a
different interrupt line? or is this totally restricted by hardware?

Also what does the "ERR" mean? Does this keep a tally of errors? If so
does 99K errors seem high?

> If you are sharing the same IRQ as USB, do you request the IRQ as
> shared? Does the USB as well?

My device does, yes. At this point I have to assume the USB driver is
too. But even if that was the problem, it wouldn't explain why the error
also happens when I don't request the interrupt at all.

Thanks,
Jon
