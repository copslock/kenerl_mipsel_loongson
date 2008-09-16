Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2008 22:39:40 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:31333 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20157643AbYIPVjg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2008 22:39:36 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D30B03ECB; Tue, 16 Sep 2008 14:39:30 -0700 (PDT)
Message-ID: <48D0278D.6090807@ru.mvista.com>
Date:	Wed, 17 Sep 2008 01:39:25 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <48CA8BEE.1090305@ru.mvista.com>	<20080913.005904.07457691.anemo@mba.ocn.ne.jp>	<48CAA498.9090804@ru.mvista.com> <20080913.213226.106262199.anemo@mba.ocn.ne.jp> <48D0220B.4090601@ru.mvista.com>
In-Reply-To: <48D0220B.4090601@ru.mvista.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

> Thats wrong -- According t the spec. the bit should be set following 
> any assertion of INTRQ on IDE bus (possibly not at once though -- 
> after flushing FIFO). Well, no wonder with such description of the 
> bits as:
>
>
> INT_IDE (RWC) [Interrupt]
> Is “1” when data transfer completes. This bit is cleared by writing 
> “1” to it.
> When this bit is set to ‘1’, the following bits of the ATA Interrupt 
> Controller Register will be
> reset: bits [15:8] (Mask Address Error INT, Mask Reach Multiple INT, 
> Mask DEV
> Timing Error, Mask Ultra DMA DEV Terminate, Mask Timer INT, Mask Bus 
> Error, Mask
> Data Transfer End, Mask Host INT), and bits [1:0] (Data Transfer End, 
> Host INT).

   Forgot to mentiom that from this description it's not even clear if 
the int_ctl register bits are cleared when 1 is written to this bit or 
when the controller sets it. :-)

MBR, Sergei
