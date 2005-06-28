Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 01:07:21 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.207]:5928 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226002AbVF1AG7> convert rfc822-to-8bit;
	Tue, 28 Jun 2005 01:06:59 +0100
Received: by wproxy.gmail.com with SMTP id 57so505629wri
        for <linux-mips@linux-mips.org>; Mon, 27 Jun 2005 17:06:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gHoR65qtv36MWq6msF0pagijKyL4NcnQkbKYzB1mgbr28wg0jzX4JnlvUj99tC1M/6zpNnh3ZQibxvw3t31AWbStnca3ti8Tc36N/FILEA7ruxxIJ8ijk+YsRO2VG1mSe8pSwiRZxKjKoIaqVIEOOmIT4S96KLB7Kc7wWVKkMbs=
Received: by 10.54.145.8 with SMTP id s8mr3809490wrd;
        Mon, 27 Jun 2005 17:06:27 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Mon, 27 Jun 2005 17:06:27 -0700 (PDT)
Message-ID: <2db32b720506271706201a66fb@mail.gmail.com>
Date:	Mon, 27 Jun 2005 17:06:27 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: can't find interrupt number under /proc/interrupts for the pci multi-port on db1550
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I am running 2.4.31 on db1550 with a pci multi-port board. the kernel
starts up ok. but after start-up, I can't find the corresponding
interrupt number for this board, which is irq 2. I can find the device
under /proc/devices and /proc/tty/driver, etc. So I am now sure if it
is working ok. Is there good (simple) method to test this serial port?

thanks
