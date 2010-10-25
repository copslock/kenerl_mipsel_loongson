Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 18:56:05 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:45444 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491019Ab0JYQ4C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 18:56:02 +0200
Received: by bwz5 with SMTP id 5so3199183bwz.36
        for <linux-mips@linux-mips.org>; Mon, 25 Oct 2010 09:56:01 -0700 (PDT)
Received: by 10.204.55.20 with SMTP id s20mr5380651bkg.168.1288025761184;
        Mon, 25 Oct 2010 09:56:01 -0700 (PDT)
Received: from hserver.mobile (smart152.bb.netvision.net.il [212.143.76.5])
        by mx.google.com with ESMTPS id 4sm5017021bki.13.2010.10.25.09.55.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 09:55:59 -0700 (PDT)
Message-ID: <4CC599EE.2000102@mvista.com>
Date:   Mon, 25 Oct 2010 18:53:34 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.11) Gecko/20101013 Thunderbird/3.1.5
MIME-Version: 1.0
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: Is it any serial8250 platform driver available?
References: <AEA634773855ED4CAD999FBB1A66D0760126B496@CORPEXCH1.na.ads.idt.com> <4CC1E677.1090404@caviumnetworks.com> <AEA634773855ED4CAD999FBB1A66D0760126B6FC@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760126B6FC@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

[Resending to the list as I've only replied to Andrei -- due to stupid keyboard 
layout switcher in  OpenSUSE preventing Ctrl-Shift-R in Thunderbird from 
working... :-/]

On 25-10-2010 19:37, Ardelean, Andrei wrote:

> Hi David,

> I studied this driver and few other examples and I have one question
> regarding the driver configuration:
> Which field must be initialized in the plat_serial8250_port structure:
> 	unsigned long	iobase;		/* io base address */
> 	void __iomem	*membase;	/* ioremap cookie or NULL */
> 	resource_size_t	mapbase;	/* resource base */
> Some drivers init only one of them, other two fields.

    Of course, .iobase is for I/O port mapped UARTs (think PC), .mapbase and 
.membase are for the memory mapped UARTs (like your case).

> My UART is located at 0x1bf01000, can I put this value in all those
> fields?

    You only need to put that into ,mapbase.

> Thanks,
> Andrei

WBR, Sergei
