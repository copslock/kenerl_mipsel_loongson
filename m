Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Apr 2005 20:58:26 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.202]:27768 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8224962AbVDZT6K> convert rfc822-to-8bit;
	Tue, 26 Apr 2005 20:58:10 +0100
Received: by wproxy.gmail.com with SMTP id 57so48153wri
        for <linux-mips@linux-mips.org>; Tue, 26 Apr 2005 12:58:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jQ4G5HXz+HIW+WCD9rZiR7BSPA3Xtmu5k4c0kZwvRfSFSRjpk3oaykOj6viVTx+RywMcy6Bf8RC3xiyYlBj1FWysdYXkxmLyqxQ/4qMZJBYDfcs0zRE3fo1nrLRsY41fRd6MBKvzoSW9ZII63HOS3RAeWVWSjUgcqpHDKBVSskA=
Received: by 10.54.120.16 with SMTP id s16mr81611wrc;
        Tue, 26 Apr 2005 12:58:00 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Tue, 26 Apr 2005 12:58:00 -0700 (PDT)
Message-ID: <ecb4efd105042612586d43fcc5@mail.gmail.com>
Date:	Tue, 26 Apr 2005 15:58:00 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: should the kernel be initializing the uarts on the Au1550?
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

It seems that the kernel (2.6.10) isn't properly initializing the
Au1550 serial ports. All three of the serial ports work, just not at
the same time. Linux seems to need yamon to configure the serial port
first. Out of the box yamon uses UART0 & UART3 and ttyS0 & ttyS2
(UART3, the 1550 doesn't have a UART2) work in linux, but ttyS1
doesn't. If I switch yamon to use UART1 & UART3, then ttyS0 doesn't
seem to work in linux. The serial port that isn't configured by yamon
will hang in an ioctl() on calling tcsetattr().

Before I just cheat and add a third serial port to yamon, should the
kernel be initializing the UARTs or does it really expect the yamon to
initialize them first? Is anyone using all 3 serial ports on an
Au1550?

                                  Thanks,
                                  Clem
