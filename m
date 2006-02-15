Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2006 10:50:42 +0000 (GMT)
Received: from WILBUR.CONTACTOFFICE.NET ([212.3.242.68]:7066 "EHLO
	wilbur.contactoffice.net") by ftp.linux-mips.org with ESMTP
	id S8133521AbWBOKud (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Feb 2006 10:50:33 +0000
Received: from pumbaa (pumbaa.contactoffice.com [10.0.0.3])
	by wilbur.contactoffice.net (Postfix) with ESMTP id 927E71238E5
	for <linux-mips@linux-mips.org>; Wed, 15 Feb 2006 11:57:00 +0100 (CET)
Message-ID: <2811923.1140001023878.JavaMail.root@pumbaa>
Date:	Wed, 15 Feb 2006 11:57:03 +0100 (CET)
From:	The Mole <TheMole@mail.be>
Reply-To: The Mole <TheMole@mail.be>
To:	linux-mips@linux-mips.org
Subject: usb-serial generic AMD DBAu1200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Origin-IP: 193.190.131.17
X-Mailer: ContactOffice Mail
Return-Path: <TheMole@mail.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheMole@mail.be
Precedence: bulk
X-list: linux-mips

Hi,

I'm currently experimenting with an AMD DBAu1200 devboard and the kernel AMD provided with it (a 2.6.11 derivative...). I only intend to use the usb ports actually... don't care much about the rest...

The problem I'm having is the following:
I succesfully compiled usb-serial as a module (with generic support) and the module loads fine (with the vendor en product parameters). If I however plugin the USB device with said vendor en product id's, the driver does not 'attach' itself to the device. The system recognises a new usb device, the driver is loaded fine... the interaction between both doesn't seem to be happening at all though...

Has anyone experienced this before? Any ideas are welcome...

Thanks,

Danny
-----------------------------------------------------
Mail.be, WebMail and Virtual Office
http://www.mail.be
