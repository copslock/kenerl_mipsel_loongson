Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jun 2006 21:22:10 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.195]:48372 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133809AbWFKUV7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Jun 2006 21:21:59 +0100
Received: by nz-out-0102.google.com with SMTP id z3so1159072nzf
        for <linux-mips@linux-mips.org>; Sun, 11 Jun 2006 13:21:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=W7zp/iYBqZBQmwbtrbdRoNysMtIJ1IDwYcL+Cikod0ccF8T455Tx5hponWiJPrEcHk1BLkAEOhRcdGHNQOYeMZgDAX74Rn+eHsVHGQFnYmwzzvDviTf9yzarTBzOrhFS6SSp0Ea+ZNp6txbV9bGNH8/rChjPhea/rLcnMcOjA14=
Received: by 10.36.196.20 with SMTP id t20mr7553873nzf;
        Sun, 11 Jun 2006 13:21:57 -0700 (PDT)
Received: by 10.36.128.9 with HTTP; Sun, 11 Jun 2006 13:21:57 -0700 (PDT)
Message-ID: <acd2a5930606111321t11c29c77p83e56615b42902f9@mail.gmail.com>
Date:	Mon, 12 Jun 2006 00:21:57 +0400
From:	"Vitaly Wool" <vitalywool@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: PNX8550 fails to compile in 2.6.17-rc4
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <20060607142702.GA20184@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2234_20641037.1150057317747"
References: <20060607105221.7b15b243.vitalywool@gmail.com>
	 <20060607142702.GA20184@linux-mips.org>
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_2234_20641037.1150057317747
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Ralf,

On 6/7/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> This seems to be one of the serial bits for the ip3106 which must have
> been lost on the way to kernel.org.  Unfortunately the original author
> does no longer take care of the code.  I just took a stab at the PNX8550
> code and it has a significant number of other problems.  All small in
> the sum large enough such that I will mark PNX8550 support broken.

I took an attempt to compile 2.6.16.20 kernel from linux-mips.org for
PNX8550 and it went a little further but also failed soon:

  CC      arch/mips/philips/pnx8550/common/platform.o
/home/vital/work/opensource/linux-
2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:101: error: variable
`pnx8550_usb_ohci_device' has initializer but incomplete type
/home/vital/work/opensource/linux-
2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102: error: unknown
field `name' specified in initializer
/home/vital/work/opensource/linux-
2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102: warning: excess
elements in struct initializer
/home/vital/work/opensource/linux-
2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102: warning: (near
initialization for `pnx8550_usb_ohci_device')
/home/vital/work/opensource/linux-
2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:103: error: unknown
field `id' specified in initializer
/home/vital/work/opensource/linux-
2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:103: warning: excess
elements in struct initializer
...
/home/vital/work/opensource/linux-
2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:101: error: storage
size of `pnx8550_usb_ohci_device' isn't known
/home/vital/work/opensource/linux-
2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:112: error: storage
size of `pnx8550_uart_device' isn't known
make[2]: *** [arch/mips/philips/pnx8550/common/platform.o] Error 1
make[1]: *** [arch/mips/philips/pnx8550/common] Error 2
make: *** [vmlinux] Error 2

Does it make sense to try to fix those? Or will it only result in more
errore showing up next?

Best regards,
   Vitaly

------=_Part_2234_20641037.1150057317747
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Ralf,<br><br>
<div><span class="gmail_quote">On 6/7/06, <b class="gmail_sendername">Ralf Baechle</b> &lt;<a href="mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt; wrote:</span></div>
<div>&gt; This seems to be one of the serial bits for the ip3106 which must have<br>&gt; been lost on the way to <a href="http://kernel.org">kernel.org</a>.&nbsp;&nbsp;Unfortunately the original author<br>&gt; does no longer take care of the code.&nbsp;&nbsp;I just took a stab at the PNX8550
<br>&gt; code and it has a significant number of other problems.&nbsp;&nbsp;All small in<br>&gt; the sum large enough such that I will mark PNX8550 support broken.<br>&nbsp;</div>
<div>I took an attempt to compile <a href="http://2.6.16.20">2.6.16.20</a> kernel from <a href="http://linux-mips.org">linux-mips.org</a> for PNX8550 and it went a little further but also failed soon:</div>
<div>&nbsp;</div>
<div>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/mips/philips/pnx8550/common/platform.o<br>/home/vital/work/opensource/linux-<a href="http://2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:101">2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:101
</a>: error: variable `pnx8550_usb_ohci_device' has initializer but incomplete type<br>/home/vital/work/opensource/linux-<a href="http://2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102">2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102
</a>: error: unknown field `name' specified in initializer<br>/home/vital/work/opensource/linux-<a href="http://2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102">2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102
</a>: warning: excess elements in struct initializer<br>/home/vital/work/opensource/linux-<a href="http://2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102">2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102
</a>: warning: (near initialization for `pnx8550_usb_ohci_device')<br>/home/vital/work/opensource/linux-<a href="http://2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:103">2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:103
</a>: error: unknown field `id' specified in initializer<br>/home/vital/work/opensource/linux-<a href="http://2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:103">2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:103
</a>: warning: excess elements in struct initializer<br>...</div>
<div>/home/vital/work/opensource/linux-<a href="http://2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:101">2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:101</a>: error: storage size of `pnx8550_usb_ohci_device' isn't known
<br>/home/vital/work/opensource/linux-<a href="http://2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:112">2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:112</a>: error: storage size of `pnx8550_uart_device' isn't known
<br>make[2]: *** [arch/mips/philips/pnx8550/common/platform.o] Error 1<br>make[1]: *** [arch/mips/philips/pnx8550/common] Error 2<br>make: *** [vmlinux] Error 2<br>&nbsp;</div>
<div>Does it make sense to try to fix those? Or will it only result in more errore showing up next?</div>
<div>&nbsp;</div>
<div>Best regards,</div>
<div>&nbsp;&nbsp; Vitaly<br><br>&nbsp;</div>

------=_Part_2234_20641037.1150057317747--
