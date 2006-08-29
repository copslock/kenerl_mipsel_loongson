Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 16:42:22 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:57003 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039480AbWH2PmU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2006 16:42:20 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A3D9C3ED1; Tue, 29 Aug 2006 08:13:29 -0700 (PDT)
Message-ID: <44F459DD.8060902@ru.mvista.com>
Date:	Tue, 29 Aug 2006 19:14:37 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	=?ISO-8859-1?Q?Thomas_?= =?ISO-8859-1?Q?K=F6ller?= 
	<thomas@koeller.dyndns.org>
Subject: Re: [PATCH] RM9000 serial driver
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp> <200608222227.20181.thomas.koeller@baslerweb.com>
In-Reply-To: <200608222227.20181.thomas.koeller@baslerweb.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Thomas Koeller wrote:

>>If you have an another standard 8250 port. this driver cannot support it
>>You should do as well as AU1X00.

> The AU1X00 code obviously assumes that every port that is not an AU1X00 is
> a standard port requiring no register mapping. However, this is of course
> not necessarily true in the most general case. There could be platforms
> with multiple ports, all non-standard, but in different ways. Handling this

    The key word here is *could*. So far, this case is purely speculative. The 
"half-compatible" UARTs seem to only reside in some SOCs for which case the 
current scheme is still adequate.
    I think I understand why such "half- compatible" hardware has appeared at 
all -- the weird 8250 addressing scheme with several registers mapped to the 
single address may be hard to implement...

> would require per-port mapping functions, which could be achieved by adding
> function pointers to struct uart_8250_port. However, this would add the
> overhead of a real, non-inlined function call to every register access.

> Also, it seems to me that the whole register-mapping stuff conflicts with
> autodetection, because autoconfig() uses serial_inp() and serial_outp()
> before the port types, and hence the mapping requirements, are known.

    Port types have nothing to do with this. Or at least they hadn't until 
your recent patch. :-)
    iotype was used to identify the addressing scheme, and it's alsready known 
beforehand.

> This is not a problem for me, however, since the correct port type is
> set up by the platform using early_serial_setup().

    There actually may be some other (and more valid than your case :-) issues 
preventing autoconfure from use with SOC UARTs. I guess autoconfigure code 
wan't intended for the case of SOC chips -- their UARTs' charactarestics are 
usually known beforehand, and the correct PORT_* might be pre-set by the 
platform setup code.

WBR, Sergei
