Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jul 2005 01:56:59 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.207]:58358 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226180AbVGBA4k> convert rfc822-to-8bit;
	Sat, 2 Jul 2005 01:56:40 +0100
Received: by wproxy.gmail.com with SMTP id 70so455861wra
        for <linux-mips@linux-mips.org>; Fri, 01 Jul 2005 17:56:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B0N2GBjnEg0XtYEP8PrBOk5VtMikHzBPnKw4HoQWc97h14O4gK6MRYQuGfGe+u+UxOjS84scOpyIQRWaSF2qMGH3Xp6vZFqcrmPNkzFOnFYJ06nwMuVJtX8UArk+e9bz4lucuKq6DVxQXWx4tia7o/lrZ6Yg5StLjgPWxEPQj3Y=
Received: by 10.54.101.2 with SMTP id y2mr2093100wrb;
        Fri, 01 Jul 2005 17:56:29 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Fri, 1 Jul 2005 17:56:29 -0700 (PDT)
Message-ID: <2db32b720507011756247735d6@mail.gmail.com>
Date:	Fri, 1 Jul 2005 17:56:29 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: possible serial driver fixup for au1x00 in 2.6?
Cc:	rolfliu@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Basically, au1x00_uart.c is doing the same thing as 8250.c. If I want
to add extra serial port support by 8250.c. There could be some
problem. Any idea?

Correct me if I am wrong
