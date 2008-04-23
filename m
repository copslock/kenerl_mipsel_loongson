Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2008 19:45:06 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.158]:2585 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28585429AbYDWSpD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Apr 2008 19:45:03 +0100
Received: by fg-out-1718.google.com with SMTP id d23so10036568fga.32
        for <linux-mips@linux-mips.org>; Wed, 23 Apr 2008 11:45:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=Pvzy8l5pav9yxoSjGNNtexejPzk2r/qxbVVKWCz62uw=;
        b=V1r2pRVzAvzmTeQAfMASRSOvmcpb5ioUgdqTdfcTiBZaiyWT3R7Z9Zse28N9Ry8f5xSO5d4fkZFxL59jw9dMN8ZY0AutNlYO++NH8BP6aV3VjFP1TdNV5s1a86RoZWN9H5myQIuk/Sv3BE1T+w4CR4MXNFZ6KfY6tJ0aiOGS2Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mt18noNfN/q701Su/2HT2u9VvY2onadi1dyZ2aitjLJIDMWNCmGIu8V9oxodfZp8dXv3to5FvCSgh+VQs8MElXtUmcDvDzN28WFfmLtBEMwiNSYSKjApDNTSdeGrm49FwTEoAUl3VSKPMs7FgwO/UC5GEX4qS08Vfosd/f6tJ/c=
Received: by 10.86.31.18 with SMTP id e18mr3773355fge.38.1208976300312;
        Wed, 23 Apr 2008 11:45:00 -0700 (PDT)
Received: from ?192.168.1.3? ( [85.140.76.196])
        by mx.google.com with ESMTPS id l12sm433032fgb.8.2008.04.23.11.44.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 23 Apr 2008 11:44:58 -0700 (PDT)
Message-ID: <480F83A6.50308@gmail.com>
Date:	Wed, 23 Apr 2008 22:44:54 +0400
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14ubu (X11/20080306)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] [MIPS] add DECstation DS1287 clockevent
References: <20080423085140.a693b2e5.yoichi_yuasa@tripeaks.co.jp>	<200804222353.m3MNr8m4025538@po-mbox303.hop.2iij.net> <20080423.115528.59033169.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20080423.115528.59033169.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto пишет:
> On Wed, 23 Apr 2008 08:52:45 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
>> add DECstation DS1287 clockevent
>>
>> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> ...
>> --- linux-orig/arch/mips/kernel/Makefile	2008-04-22 19:01:43.957134178 +0900
>> +++ linux/arch/mips/kernel/Makefile	2008-04-22 18:03:05.427649422 +0900
>> @@ -9,8 +9,9 @@ obj-y		+= cpu-probe.o branch.o entry.o g
>>  		   time.o topology.o traps.o unaligned.o
>>  
>>  obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
>> -obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
>> +obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
>>  obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
>> +obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
>>  obj-$(CONFIG_CEVT_SB1250)	+= cevt-sb1250.o
>>  obj-$(CONFIG_CEVT_TXX9)		+= cevt-txx9.o
>>  obj-$(CONFIG_CSRC_BCM1480)	+= csrc-bcm1480.o
> 
> Why CONFIG_CEVT_R4K line was moved?  The order is important?
> 
>> --- linux-orig/arch/mips/kernel/cevt-ds1287.c	1970-01-01 09:00:00.000000000 +0900
>> +++ linux/arch/mips/kernel/cevt-ds1287.c	2008-04-22 18:03:05.455637018 +0900
> ...
>> +static void ds1287_set_mode(enum clock_event_mode mode,
>> +			    struct clock_event_device *evt)
>> +{
>> +	unsigned long flags;
>> +	u8 val;
>> +
>> +	spin_lock_irqsave(&rtc_lock, flags);
> 
> You do not have to use irqsave here, while set_mode is always called
> with interrupts disabled.  And for rtc_lock ... I don't know if this
> code could be used on SMP :-)
> 

After I had saved a DECstation 5000/200 from a junkyard a few years
ago (very neat hardware, actually), I did some research on this brand.
AFAICT, all MIPS-based DECstation models were UP.

Dmitri
