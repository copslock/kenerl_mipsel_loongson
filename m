Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 15:51:41 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:20928 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021906AbXCSPvh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 15:51:37 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 9C9513ED1; Mon, 19 Mar 2007 08:51:04 -0700 (PDT)
Message-ID: <45FEB160.4040903@ru.mvista.com>
Date:	Mon, 19 Mar 2007 18:50:56 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: ZONE_DMA on MIPS
References: <20070320.000947.88474417.anemo@mba.ocn.ne.jp>	<45FEAD11.7070503@ru.mvista.com> <20070320.004736.10544260.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070320.004736.10544260.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>Are there any other platforms requires special DMA zone?

>>    Erm, RBHMA4[24]00 have 8259 on the backplane... And the NEC boards with 
>>the Rockhopper backplane as well...

> Having 8259 does not mean it uses ISA DMA.  IIRC FPCIB0 backplane does
> not have real ISA slot, and no on-board device uses ISA DMA.

    No, it does have ISA slot (a single one)! :-D

> Does Rockhopper backplace have ISA slot?

    No, that one doesn't. :-)

> ---
> Atsushi Nemoto

WBR, Sergei
