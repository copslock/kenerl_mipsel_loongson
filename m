Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 16:17:33 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:13735 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20182152AbYIKPR0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2008 16:17:26 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 108C53ECF; Thu, 11 Sep 2008 08:17:22 -0700 (PDT)
Message-ID: <48C936AC.1080309@ru.mvista.com>
Date:	Thu, 11 Sep 2008 19:18:04 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <48C6B768.4010200@ru.mvista.com>	<20080911.003222.51867360.anemo@mba.ocn.ne.jp>	<48C7EDE4.3090400@ru.mvista.com> <20080912.000349.18312151.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080912.000349.18312151.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:

>>>But the "Command Transfer Mode Select" bits affects access timings on
>>>setting task registers for DMA command.

>>    So what? PIO and DMA are different protocols on IDE bus, so they shouldn't 
>>affect each other. The IDE core will always tune the best PIO mode for you, so 
>>the optimal command timings will be set.

> Hmm, that would be a thing I had misunderstood.  I thought
> set_pio_mode is not called when the drive was DMA capable.

    PIO autotuning was optional before (done only if the driver requested it 
via setting drive->autotune), but now done always.

MBR, Sergei
