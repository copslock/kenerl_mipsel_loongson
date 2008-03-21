Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 15:20:13 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:55564 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28577222AbYCUPUL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2008 15:20:11 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 00CD43ECB; Fri, 21 Mar 2008 08:20:08 -0700 (PDT)
Message-ID: <47E3D27B.5010908@ru.mvista.com>
Date:	Fri, 21 Mar 2008 18:21:31 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Nico Coesel <ncoesel@DEALogic.nl>
Cc:	linux-mips@linux-mips.org
Subject: Re: Serial console on Au1100
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF86E@dealogicserver.DEALogic.nl>
In-Reply-To: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF86E@dealogicserver.DEALogic.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Nico Coesel wrote:

> Sergei,
> I'm using kernel 2.6.24 now (before I used 2.6.21-rc4). I do see the
> console messages on the framebuffer device.

> Kernel options:
> console=ttyS0 root=/dev/mtdblock0 rootfstype=jffs2 rw
> video=au1100fb:panel:KERN_AU1100 tsdev.xres=320 tsdev.yres=234
> console=tty0

> If I omit console=tty0, then there is no output on the framebuffer

    You're specifying console twice, but without a baud rate. Also, do you 
have  CONFIG_SERIAL_8250_CONSOLE enabled?

> device or the serial port. I also tried setting the I/O address and so
> on, but no luck.

> Nico Coesel

WBR, Sergei
