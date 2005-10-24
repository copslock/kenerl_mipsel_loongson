Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2005 11:09:50 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.195]:5751 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465641AbVJXKJX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Oct 2005 11:09:23 +0100
Received: by zproxy.gmail.com with SMTP id j2so782622nzf
        for <linux-mips@linux-mips.org>; Mon, 24 Oct 2005 03:08:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nV70ay5p4740TFXirlI6PpSkFbVvL4JsnRAWx7WAOs/j3PUiTOGQ5Qm+oVkS5X6I62lPZp7TyzH+D6+tlvZnpaw6iovY2EBxig29aayh2K+yp1bVzAGPSoHphZHcpuxgP3+Rg1H9SYDaC8Gfan3IfE2Dv869jttOM82tfFWBPf0=
Received: by 10.37.18.45 with SMTP id v45mr6622429nzi;
        Mon, 24 Oct 2005 03:08:35 -0700 (PDT)
Received: by 10.36.47.4 with HTTP; Mon, 24 Oct 2005 03:08:34 -0700 (PDT)
Message-ID: <cda58cb80510240308j168a9e30t@mail.gmail.com>
Date:	Mon, 24 Oct 2005 12:08:34 +0200
From:	Franck <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Subject: kernel is overwhelmed by usb hcd's interrupts
In-Reply-To: <cda58cb80510210702g3b0c0bdbk@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510210702g3b0c0bdbk@mail.gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I've written an usb driver for linux for a specific usb host
controler. Basicaly the hw generates an interrupt every 1 ms (every
start of frame) and during transfers interrupts can be generated every
30 us ! My cpu is a MIPS 4KEC running at 96Mhz and HZ is 100.

After transfering 20M bytes of data through USB, the kernel loops for
a while in timer interrupt handler. It actually loops in update_times
with tick (jiffies - wall_jiffies) value equals to 3707637046 ! I
guess that the kernel have lost a lot of timer ticks...However
interrupts are enable inside usb driver, I don't see how the kernel
can lost so many ticks.

Could anyone give me some advices for that ?

Thanks
--
               Franck


--
               Franck
