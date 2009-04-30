Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 12:14:51 +0100 (BST)
Received: from gateway10.websitewelcome.com ([67.18.44.16]:39141 "HELO
	gateway10.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20026473AbZD3LOp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 12:14:45 +0100
Received: (qmail 4022 invoked from network); 30 Apr 2009 11:17:12 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway10.websitewelcome.com with SMTP; 30 Apr 2009 11:17:12 -0000
Received: from [217.109.65.213] (port=2063 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LzUDv-0007uT-QW; Thu, 30 Apr 2009 06:14:40 -0500
Message-ID: <49F98826.3030708@paralogos.com>
Date:	Thu, 30 Apr 2009 13:14:46 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
References: <20090428124645.GA14347@roarinelk.homelinux.net> <20090429060317.GB15627@linux-mips.org> <20090429082556.GA22844@roarinelk.homelinux.net> <20090429083349.GB26289@linux-mips.org> <20090429114042.GA24576@roarinelk.homelinux.net> <20090429141411.GA25905@roarinelk.homelinux.net> <20090429143523.GA10242@linux-mips.org> <20090429153221.GA26387@roarinelk.homelinux.net> <20090430104130.GA1878@roarinelk.homelinux.net>
In-Reply-To: <20090430104130.GA1878@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> Hi,
>
> This is really embarrassing:  The oops is what happens when you
> ioremap(0x10) and write 0xffffffff at the resulting address (0xa0000010).
>   
This pretty much implies that _CACHE_UNCACHED was passed in the flags
value to ioremap, so it simply returned the kseg1 address.  By any
chance is physical page zero also referenced somewhere as cacheable?

          Kevin K.
