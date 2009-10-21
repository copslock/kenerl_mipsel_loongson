Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 18:10:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4595 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493640AbZJUQKB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 18:10:01 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4adf324a0001>; Wed, 21 Oct 2009 09:09:46 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 Oct 2009 09:09:37 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 Oct 2009 09:09:37 -0700
Message-ID: <4ADF3240.9040900@caviumnetworks.com>
Date:	Wed, 21 Oct 2009 09:09:36 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"wilbur.chan" <wilbur512@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Got trap No.23 when booting mips32 ?
References: <e997b7420910210740l4a8fefai27c81152a6c288ef@mail.gmail.com>
In-Reply-To: <e997b7420910210740l4a8fefai27c81152a6c288ef@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2009 16:09:37.0741 (UTC) FILETIME=[E352C7D0:01CA5268]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

wilbur.chan wrote:
> Hi all,
> 
> 
> I've got some problem when booting mips32.
> 
> 
> I got a No.23 trap when calling start_kernel --->  local_irq_enable :
> 
> 
> irq 23, desc: 802a98a0, depth: 1, count: 0, unhandled: 0
> ->handle_irq():  80148c6c, handle_bad_irq+0x0/0x2b4
> ->chip(): 8029f738, 0x8029f738
> ->action(): 00000000
>   IRQ_DISABLED set
> unexpected IRQ # 23
> 
> 

IRQ != c0_cause.ExcCode

You should look up your kernel's IRQ to  interrupt source mapping to see 
what is connected to IRQ 23.

David Daney
