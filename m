Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2003 10:59:39 +0100 (BST)
Received: from c01.tateyama.hu ([IPv6:::ffff:152.66.119.129]:62212 "HELO
	server.tateyama.hu") by linux-mips.org with SMTP
	id <S8225209AbTHNJ7a>; Thu, 14 Aug 2003 10:59:30 +0100
Received: (qmail 32268 invoked from network); 14 Aug 2003 09:59:23 -0000
Received: from c22.tateyama.hu (152.66.119.150)
  by c01.tateyama.hu with SMTP; 14 Aug 2003 09:59:23 -0000
From: Gabor Kerenyi <wom@tateyama.hu>
Organization: Tateyama Ltd.
To: linux-mips@linux-mips.org
Subject: General I/O
Date: Thu, 14 Aug 2003 12:12:38 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308141212.38679.wom@tateyama.hu>
Return-Path: <wom@tateyama.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wom@tateyama.hu
Precedence: bulk
X-list: linux-mips

Hi!

I have a board with VR4181A. I would like to read/write
the General I/O port but I can't find anything how to do it.

I could wrote a small driver to setup and handle an interrupt
on GUINT0 using vr41xx_set_irq_trigger (a simple switch is
connected to PIN0)
But I need to set/clear pins to be able to connect an EEPROM
to GPIO and some other stuff.

I can't find functions to do this simple like set_gio(pin, state).

Can someone help?

The board is not known by anyone, it's made in Japan
(TOADKK-TCS8000).

Thanks,

Gabor
