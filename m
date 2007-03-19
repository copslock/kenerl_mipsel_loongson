Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 15:33:22 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:9152 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021893AbXCSPdR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 15:33:17 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 391173ED1; Mon, 19 Mar 2007 08:32:42 -0700 (PDT)
Message-ID: <45FEAD11.7070503@ru.mvista.com>
Date:	Mon, 19 Mar 2007 18:32:33 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: ZONE_DMA on MIPS
References: <20070320.000947.88474417.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070320.000947.88474417.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:
> Some ZONE_DMA patches were merged in 2.6.21.  On most MIPS, ZONE_DMA
> is not needed, isn't it?
> 
> Currently JAZZ, MALTA, QEMU, IP22, SNI_RM, RBTX4938 defines
> GENERIC_ISA_DMA so they may need ZONE_DMA (though I wonder QEMU or
> RBTX4938 really need it...)

    Erm, concertning the latter -- probably not, as I'm not seeing other 
FPCIB0 backplane support in the source.

> Are there any other platforms requires special DMA zone?

    Erm, RBHMA4[24]00 have 8259 on the backplane... And the NEC boards with 
the Rockhopper backplane as well...

> ---
> Atsushi Nemoto

WBR, Sergei
