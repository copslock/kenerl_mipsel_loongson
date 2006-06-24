Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2006 14:57:43 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:51471 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S8133565AbWFXN5e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jun 2006 14:57:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id C08E77F4028
	for <linux-mips@linux-mips.org>; Sat, 24 Jun 2006 15:57:28 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17798-01 for <linux-mips@linux-mips.org>;
	Sat, 24 Jun 2006 15:57:28 +0200 (CEST)
Received: from [192.168.1.140] (port-83-236-238-37.static.qsc.de [83.236.238.37])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTP id 5A14F7F4024
	for <linux-mips@linux-mips.org>; Sat, 24 Jun 2006 15:57:28 +0200 (CEST)
Mime-Version: 1.0 (Apple Message framework v750)
In-Reply-To: <20060623204835.GA2548@linuxtv.org>
References: <5B414347-B938-4E68-812E-627AED1A38B0@caiaq.de> <20060623204835.GA2548@linuxtv.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <03F81313-6053-4704-83F5-DF73BC6D1CEC@caiaq.de>
Content-Transfer-Encoding: 7bit
From:	Daniel Mack <daniel@caiaq.de>
Subject: Re: smc91x ethernet an DBAU1200
Date:	Sat, 24 Jun 2006 15:57:23 +0200
To:	linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.750)
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips


On Jun 23, 2006, at 10:48 PM, Johannes Stezenbach wrote:

>> 	nfs: server 192.168.1.200 not responding, still trying
>> 	nfs: server 192.168.1.200 not responding, still trying
>
> I had similar issues with smc91x.c on a different platform,
> where the bus it is connected to was rather slow (and no DMA)
> -> dropped packets.
>
> Try to use NFS via TCP, or force a 10Mbit connection
> with ethtool or by hacking the driver (ctl_rspeed).
> (For me tcp works.)

Thanks Johannes, using TCP works fine here, too.

Daniel
