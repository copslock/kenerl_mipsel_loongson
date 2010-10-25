Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 17:37:45 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:33360 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490954Ab0JYPhm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 17:37:42 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o9PFbZMq001859;
        Mon, 25 Oct 2010 08:37:35 -0700
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o9PFbYwa014946;
        Mon, 25 Oct 2010 08:37:34 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o9PFbXI20157;
        Mon, 25 Oct 2010 08:37:33 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Is it any serial8250 platform driver available?
Date:   Mon, 25 Oct 2010 08:37:31 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760126B6FC@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4CC1E677.1090404@caviumnetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is it any serial8250 platform driver available?
Thread-Index: ActyIdl9ASD1+buoRQG+J40+/SvxqgCN/hTg
References: <AEA634773855ED4CAD999FBB1A66D0760126B496@CORPEXCH1.na.ads.idt.com> <4CC1E677.1090404@caviumnetworks.com>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "David Daney" <ddaney@caviumnetworks.com>
Cc:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi David,

I studied this driver and few other examples and I have one question
regarding the driver configuration:
Which field must be initialized in the plat_serial8250_port structure: 
	unsigned long	iobase;		/* io base address */
	void __iomem	*membase;	/* ioremap cookie or NULL */
	resource_size_t	mapbase;	/* resource base */ 
Some drivers init only one of them, other two fields. 

My UART is located at 0x1bf01000, can I put this value in all those
fields?

Thanks,
Andrei


-----Original Message-----
From: David Daney [mailto:ddaney@caviumnetworks.com] 
Sent: Friday, October 22, 2010 3:31 PM
To: Ardelean, Andrei
Cc: linux-mips@linux-mips.org
Subject: Re: Is it any serial8250 platform driver available?

On 10/22/2010 12:23 PM, Ardelean, Andrei wrote:
> Hi,
>
> I am porting MIPS Linux from MALTA to a new board. I ported early
> console code from malta_console.c and I am looking now to use a
> interrupt driven driver for TTY. My UART is compatible with 8250 (1
UART
> port only) but the UART registers are directly mapped in CPU memory
map.
> There is no PCI bus. My problem is that the driver implemented in
8250.c
> is very complex and it seems to be hardcode for ISA bus, is it any
> simple platform UART driver available to be directly mapped in the CPU
> space? Can you give me some advice what would be a good approach for
my
> case?
>

Many chips have 8250 compatible ports and use 8250.c.

See arch/mips/cavium-octeon/serial.c

David Daeny
