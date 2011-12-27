Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2011 19:52:20 +0100 (CET)
Received: from shards.monkeyblade.net ([198.137.202.13]:59610 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903622Ab1L0SwQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2011 19:52:16 +0100
Received: from localhost (nat-pool-rdu.redhat.com [66.187.233.202])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id pBRIq95Q015881
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Tue, 27 Dec 2011 10:52:10 -0800
Date:   Tue, 27 Dec 2011 13:52:09 -0500 (EST)
Message-Id: <20111227.135209.1552228715466981902.davem@davemloft.net>
To:     shemminger@vyatta.com
Cc:     kumba@gentoo.org, netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20111227103408.01aad10e@nehalam.linuxnetplumber.net>
References: <4EED3A3D.9080503@gentoo.org>
        <4EF95247.7000403@gentoo.org>
        <20111227103408.01aad10e@nehalam.linuxnetplumber.net>
X-Mailer: Mew version 6.4 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Tue, 27 Dec 2011 10:52:11 -0800 (PST)
X-archive-position: 32200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20098

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Tue, 27 Dec 2011 10:34:08 -0800

> On Tue, 27 Dec 2011 00:06:15 -0500
> Joshua Kinard <kumba@gentoo.org> wrote:
> 
>> @@ -95,7 +95,7 @@ struct mace_video {
>>   * Ethernet interface
>>   */
>>  struct mace_ethernet {
>> -	volatile unsigned long mac_ctrl;
>> +	volatile u64 mac_ctrl;
>>  	volatile unsigned long int_stat;
>>  	volatile unsigned long dma_ctrl;
>>  	volatile unsigned long timer;
> 
> 
> This device driver writer needs to read:
>   Documentation/volatile-considered-harmful.txt

This driver has a lot of problems, some of which I've made Joshua aware of
already.
