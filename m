Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2005 10:08:41 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:9170 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133625AbVI2JIK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Sep 2005 10:08:10 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 38788C07B;
	Thu, 29 Sep 2005 11:07:54 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id BC4301BC089;
	Thu, 29 Sep 2005 11:07:55 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 0013E1A18B0;
	Thu, 29 Sep 2005 11:07:55 +0200 (CEST)
Subject: Re: USB on AU1550
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Jay Monkman <jtm@smoothsmoothie.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <433B0299.8080507@smoothsmoothie.com>
References: <433B0299.8080507@smoothsmoothie.com>
Content-Type: text/plain
Date:	Thu, 29 Sep 2005 11:07:11 +0200
Message-Id: <1127984831.10179.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> I'm trying to get USB working on my AU1550 board, and I'm getting an error I
> don't understand. I've searched the web and the mailing list archives, but
> haven't found anything relevant.

Not the answer to you question, but I have some problems with USB on
AU1200 board too. I use AirStar2 USB card (this is DVB-T card) and it
is recognized by AU1200 and can communicate with it. I can tune to 
transporder, but the data (transport stream) is not send from the
USB card. 
The card conforms to USB 1.1. 
I tried it on a PC running Linux and it works fine.

AU1200 kernel: 2.6.11, PC kernel: 2.6.13.2.

Any thoughts?

BR,
Matej

P.S.: This is the log:
----------------------------------------------------------------------------------
flexcop_usb: running at FULL speed.
DVB: registering new adapter (FlexCop Digital TV device).
f010
b2c2-flexcop: MAC address = <DELETED>
b2c2-flexcop: found the mt352 at i2c address: 0x0f
DVB: registering frontend 0 (Zarlink MT352 DVB-T)...
b2c2-flexcop: initialization of 'Air2PC/AirStar 2 DVB-T' at the 'USB'
bus controlled by a 'FlexCopIII' complete
creating 4 iso-urbs with 4 frames each of 1023 bytes size = 16368.
initializing and submitting urb no. 0 (buf_offset: 0).
urb no: 0, frame: 0, frame_offset: 0
urb no: 0, frame: 1, frame_offset: 1023
urb no: 0, frame: 2, frame_offset: 2046
urb no: 0, frame: 3, frame_offset: 3069
submitted urb no. 0.
initializing and submitting urb no. 1 (buf_offset: 4092).
urb no: 1, frame: 0, frame_offset: 0
urb no: 1, frame: 1, frame_offset: 1023
urb no: 1, frame: 2, frame_offset: 2046
urb no: 1, frame: 3, frame_offset: 3069
submitted urb no. 1.
initializing and submitting urb no. 2 (buf_offset: 8184).
urb no: 2, frame: 0, frame_offset: 0
urb no: 2, frame: 1, frame_offset: 1023
urb no: 2, frame: 2, frame_offset: 2046
urb no: 2, frame: 3, frame_offset: 3069
submitted urb no. 2.
initializing and submitting urb no. 3 (buf_offset: 12276).
urb no: 3, frame: 0, frame_offset: 0
urb no: 3, frame: 1, frame_offset: 1023
urb no: 3, frame: 2, frame_offset: 2046
urb no: 3, frame: 3, frame_offset: 3069
submitted urb no. 3.
flexcop_usb: Technisat/B2C2 FlexCop II/IIb/III Digital TV USB Driver
successfully initialized and connected.
usbcore: registered new driver b2c2_flexcop_usb
----------------------------------------------------------------------------------
