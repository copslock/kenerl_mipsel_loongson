Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2004 01:34:15 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:44263 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8226036AbUEOAeN>;
	Sat, 15 May 2004 01:34:13 +0100
Received: (qmail 23280 invoked from network); 15 May 2004 00:21:59 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.187)
  by mail.ict.ac.cn with SMTP; 15 May 2004 00:21:59 -0000
Message-ID: <40A60DA7.1080405@ict.ac.cn>
Date: Sat, 15 May 2004 08:31:35 -0400
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: wuming <wuming@ict.ac.cn>, linux-mips@linux-mips.org
Subject: Re: problems on D-cache alias in 2.4.22
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B1@server1.RightHand.righthandtech.com> <40A43601.70307@ict.ac.cn> <20040515001255.GA20773@linux-mips.org>
In-Reply-To: <20040515001255.GA20773@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

We are using ide disk with ext3 filesystem, DMA is on( PIIX4 chip),but 
it seems PIO/DMA
does not affect the failures.

Ralf Baechle wrote:

>Wuming,
>
>what kind of filesystem or storage are you using?
>
>  Ralf
>
>
>
>  
>
