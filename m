Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 10:36:30 +0100 (BST)
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:21892 "EHLO
	imx2.toshiba.co.jp") by ftp.linux-mips.org with ESMTP
	id S20024683AbZCaJgZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 10:36:25 +0100
Received: from arc1.toshiba.co.jp ([133.199.194.235])
	by imx2.toshiba.co.jp  with ESMTP id n2V9YDob007443;
	Tue, 31 Mar 2009 18:34:13 +0900 (JST)
Received: (from root@localhost)
	by arc1.toshiba.co.jp  id n2V9YDSK013183;
	Tue, 31 Mar 2009 18:34:13 +0900 (JST)
Received: from unknown [133.199.192.144] 
	 by arc1.toshiba.co.jp with ESMTP id UAA13182;
	 Tue, 31 Mar 2009 18:34:13 +0900
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp2.toshiba.co.jp  with ESMTP id n2V9YCJh024670;
	Tue, 31 Mar 2009 18:34:12 +0900 (JST)
Received: from BK2211.rdc.toshiba.co.jp by toshiba.co.jp id n2V9YCkK017829; Tue, 31 Mar 2009 18:34:12 +0900 (JST)
Received: from island.swc.toshiba.co.jp (localhost [127.0.0.1])
	by BK2211.rdc.toshiba.co.jp (8.13.8+Sun/8.13.8) with ESMTP id n2V9YCST003528;
	Tue, 31 Mar 2009 18:34:12 +0900 (JST)
Received: from [133.196.123.121] (dhcp-b021 [133.196.123.121])
	by island.swc.toshiba.co.jp (Postfix) with ESMTP
	id 0A8A540002; Tue, 31 Mar 2009 18:34:07 +0900 (JST)
Message-ID: <49D1E384.8080009@toshiba.co.jp>
Date:	Tue, 31 Mar 2009 18:33:56 +0900
From:	KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	IDE/ATA Devel <linux-ide@vger.kernel.org>
Cc:	Grant Grundler <grundler@google.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	LKML <linux-kernel@google.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] linux-next remove wmb() from ide-dma-sff.c and scc_pata.c
References: <da824cf30903301739l688e8eb2r46086953245ebbe5@mail.gmail.com> <alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be>
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoshitake.kobayashi@toshiba.co.jp
Precedence: bulk
X-list: linux-mips

2009/03/31 16:51, Geert Uytterhoeven wrote:
> On Mon, 30 Mar 2009, Grant Grundler wrote:
>> Followup to "[PATCH 03/10] ide: destroy DMA mappings after ending DMA"
>> email on March 14th:
>>     http://lkml.org/lkml/2009/3/14/17
>>
>> No maintainer is listed for "Toshiba CELL Reference Set IDE" (BLK_DEV_CELLEB)
>> or tx4939ide.c in MAINTAINERS. I've CC'd "Ishizaki Kou" @Toshiba (Maintainer for
>> "Spidernet Network Driver for CELL") and linuxppc-dev list in the hope
>> someone else
>> would know or would be able to ACK this patch.
> 
> tx49xx is MIPS, for Nemoto-san.

The patch looks good for Toshiba Cell Reference Set.
I think the patch will be acked by IDE maintainer.

Thank you for informing me of the contribution.

Regards,

-- Yoshi
