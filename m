Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2006 01:49:06 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:42464 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20037876AbWLHBtB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2006 01:49:01 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 1207615D4004;
	Thu,  7 Dec 2006 19:19:10 -0800 (PST)
Subject: Serial 8250 driver registration:
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061208.101112.108306293.nemoto@toshiba-tops.co.jp>
References: <1165462754.6516.40.camel@sandbar.kenati.com>
	 <20061207.131306.63741931.nemoto@toshiba-tops.co.jp>
	 <1165534711.6512.10.camel@sandbar.kenati.com>
	 <20061208.101112.108306293.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Date:	Thu, 07 Dec 2006 18:01:45 -0800
Message-Id: <1165543305.6512.17.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

Yeah, i thought you might have meant that :-)

i m starting to think that the uartclk parameter that i pass to the
platform_add_devices function might be wrong --

i m passing the standard value of 1843200 for a baudrate of 115200...

now the output after the board specific encm3_platform_init function is
called, is the kernel messages with mostly alternate characters missing,
like so:


> 1000 s 1.5 P P <o@d.>
> 0: A1 Ee d  01500000,  28
> 0: Bd BCM5221 10/100 BT PHY   e 0
> 0: U Bd BCM5221 10/100 BT PHY  a
> 1: A1 Er   01510000,  29
> 1: Bo BCM5221 10/100 BT PHY   r 0
> 1: U Bo BCM5221 10/100 BT PHY  a
> NET: Rt c l 2
> IP   h  e r: 1024 (r: 0, 4096 )
> TCP a  e r: 4096 (r: 2, 16384 e)
> TCP   e r: 4096 (r: 2, 16384 e)
> TCP: H e i (b 4096 d 4096)
> TCP o i
> TCP  t
> NET: Re c l 1
> NET: Rs t y 17
> IP-Ci: Gs m 255.255.255.0
> IP-C:: Ce:
>       c=0, =192.168.1.147, =255.255.255.0, =255.255.255.255,
>      =192.168.1.147, ==, -n=(e)<6>0: n  l x
> ,
>      s=255.255.255.255, s=192.168.1.8, p=
>  d c n
>  i  n
> Ln  t  RPC 100003/2  192.168.1.8
> Li    RPC 100005/1  192.168.1.8
> VFS: Me  ( y).
> Fi e e y: 128

Could there be another cause for this?
This is my platform_device structure:


> static struct plat_serial8250_port encm3_via_uart_data[] = {
>                 {
>                         .iobase         = 0x3f8,                        //iobase address
> //                      .membase        = (char *)(0x50000000 + 0x3f8),         // is a pointer - ioremap cookie or NULL
>                         .irq            = INT_PIC_4,    // interrupt 4 from the 8259 on the southbridge
> //                      .flags          = UPF_SHARE_IRQ, //| UPF_SKIP_TEST |
>                         .flags          = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_AUTO_IRQ,
>                         .iotype         = UPIO_PORT,
>                         .regshift       = 1,
>                         .uartclk        = 1843200,
> 
>                                             },
>                         { },
> };


Regards,
Ashlesha.
