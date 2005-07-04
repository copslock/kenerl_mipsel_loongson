Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2005 16:37:57 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:205.217.158.170]:50894
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8226097AbVGDPg6>; Mon, 4 Jul 2005 16:36:58 +0100
Received: (qmail 5716 invoked from network); 4 Jul 2005 08:37:02 -0700
Received: from c-24-6-216-150.hsd1.ca.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 4 Jul 2005 08:37:02 -0700
Message-ID: <42C957A4.9090303@total-knowledge.com>
Date:	Mon, 04 Jul 2005 08:37:08 -0700
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050620)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Arianna Arona <arianna@dsi.unimi.it>
CC:	linux-mips@linux-mips.org
Subject: Re: IOC3 not working on SGI O2K
References: <200507041444.00289.arianna@dsi.unimi.it>
In-Reply-To: <200507041444.00289.arianna@dsi.unimi.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

I have uploaded my latest kernel to the website.
Try it.

    Ilya.

Arianna Arona wrote:

>Hi everybody,
>
>I have a SGI O2K, and I'm trying to install linux.
>I've downloaded vmlinux.ip27-20040428 from 
>http://www.total-knowledge.com/progs/mips/kernels/ and it boots and mount a 
>local root file system.
>IOC3 ethernet card doesn't work.
>
>Here are boot logs:
>[.....]
>[33] 0:1 0; <6> eth%d: link down 0000000004e00791
>[.....]
>[63] 0:1 0; 725e700004e00791
>Found DS1981U NIC registration number 07:e0:04:70:5e, CRC 72.
>Ethernet address is 08:00:69:0d:16:00
>eth0: link down
>eth0: using PHY 0, vendor 0x2000, model 0, rev 3.
>eth0: IOC3 SSRAm has 128Kbytes.
>
>
>IOC3 is on a board with 2 consoles and a SCSI port.
>Could be this the problem? Is there any solution?
>
>Thank you very much,
>Arianna
>  
>
