Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2005 17:46:02 +0000 (GMT)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.192]:18180 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8225321AbVBVRpq>;
	Tue, 22 Feb 2005 17:45:46 +0000
Received: by rproxy.gmail.com with SMTP id 40so625989rnz
        for <linux-mips@linux-mips.org>; Tue, 22 Feb 2005 09:45:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=hkkpkYXcVLO0fG03/RMAjS8w9DOY+uqvNX9qKbTRkife34Q8aILCL6risvzhEANnF3k/HBemqGjsvG59rmA5W68F0QTi2llzpw9B9lMUmPLuDLwlAzinOd8T/ZqWSSC6/S6HVRBHZXjiOS7AzFQT0+mfpkmmaMr6QxcBqrHsA+s=
Received: by 10.38.179.14 with SMTP id b14mr186309rnf;
        Tue, 22 Feb 2005 09:45:44 -0800 (PST)
Received: by 10.38.179.17 with HTTP; Tue, 22 Feb 2005 09:45:44 -0800 (PST)
Message-ID: <52dd176405022209452e21643@mail.gmail.com>
Date:	Tue, 22 Feb 2005 11:45:44 -0600
From:	Guy Streeter <guy.streeter@gmail.com>
Reply-To: Guy Streeter <guy.streeter@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: on-board USB on malta 4kc and a 2.6 kernel?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <guy.streeter@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guy.streeter@gmail.com
Precedence: bulk
X-list: linux-mips

I am trying to verify that on-board USB should work on a malta 4kc
board. There appears to me to be some conflict between it and the
serial ports. I've been asking around and nobody says they have done
it, so I'd like to hear from anyone who has.

Here's what I see:
Using the mips.org CVS HEAD kernel source, and any USB device plugged
in, during bootup there is garbaged output on the console as USB
starts up:

==============================
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
NE Risr otolamynghch dde
IPrtg chha blof1buet 4yt
N: gied otolamyblhe 96i 4628yt)
NE Rier otofaly7
                N: gied ocofaly5eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on
usb-0000:00:0a.2-2.1
input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on
usb-0000:00:0a.2-2.1
==============================

Once the serial console gets to a login: prompt, the first character I
type is interpreted as a sysrq key.

If I run "lsusb -v" I will start seeing:

usb 1-2: lsusb timed out on ep0in
usb 1-2: usbfs: USBDEVFS_CONTROL failed cmd lsusb rqt 128 rq 6 len 256 ret -145

The console will again interpret a character as a sysrq key, and the
Ethernet controller starts timing out.

Does this look familiar to anyone?
Has anyone successfully used the on-boards USB on a malta 4kc board?

thanks for your help,
--Guy Streeter
