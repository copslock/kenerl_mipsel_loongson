Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 21:31:12 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7415 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491177Ab0JVTbF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Oct 2010 21:31:05 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cc1e69b0000>; Fri, 22 Oct 2010 12:31:39 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 22 Oct 2010 12:31:26 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 22 Oct 2010 12:31:26 -0700
Message-ID: <4CC1E677.1090404@caviumnetworks.com>
Date:   Fri, 22 Oct 2010 12:31:03 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Is it any serial8250 platform driver available?
References: <AEA634773855ED4CAD999FBB1A66D0760126B496@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760126B496@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2010 19:31:26.0519 (UTC) FILETIME=[B7E82C70:01CB721F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/22/2010 12:23 PM, Ardelean, Andrei wrote:
> Hi,
>
> I am porting MIPS Linux from MALTA to a new board. I ported early
> console code from malta_console.c and I am looking now to use a
> interrupt driven driver for TTY. My UART is compatible with 8250 (1 UART
> port only) but the UART registers are directly mapped in CPU memory map.
> There is no PCI bus. My problem is that the driver implemented in 8250.c
> is very complex and it seems to be hardcode for ISA bus, is it any
> simple platform UART driver available to be directly mapped in the CPU
> space? Can you give me some advice what would be a good approach for my
> case?
>

Many chips have 8250 compatible ports and use 8250.c.

See arch/mips/cavium-octeon/serial.c

David Daeny
