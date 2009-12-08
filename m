Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 12:37:26 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:15036 "HELO
        imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with SMTP id S1492628AbZLHLhW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 12:37:22 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
        by imap.sh.mvista.com (Postfix) with SMTP
        id 8EAD93ED9; Tue,  8 Dec 2009 03:37:13 -0800 (PST)
Message-ID: <4B1E3A5A.9050100@ru.mvista.com>
Date:   Tue, 08 Dec 2009 14:36:58 +0300
From:   Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     figo zhang <figo1802@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>, macro@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: Dma addr should use Kuseg1 for MIPS32?
References: <c6ed1ac50912070455n736af31fuf2c981fc182b494f@mail.gmail.com>         <20091207134502.GB5119@linux-mips.org> <c6ed1ac50912071749m49b1e5f5m7ae53384389338d9@mail.gmail.com>
In-Reply-To: <c6ed1ac50912071749m49b1e5f5m7ae53384389338d9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

figo zhang wrote:

>
>     > i write dma_phy to DMA base register, but why it cannot work? it
>     should
>     > write Kseg1 space to DMA register?
>     > I remember that it is ok for ARM/X86 .
>
>     It's only happens to work on some systems.
>
>
> in my puzzle, if i run 
> dma_vaddr =(char*) __get_free_pages(GFP_KERNEL,  order);
> dma_phy = virt_to_phy(dma_vaddr);
>
> if the result is:
> dma_vaddr = 0x801b00000;
> dma_phy = 0x1b00000;
>
> so i should write 0x1b00000 to my DMA Base register or wirte 
> (0x1b000000 | 0xa0000000) to DMA?

   You must always use the physical addresses when programming DMA, i.e. 
0x1b00000 in this case.

WBR, Sergei
