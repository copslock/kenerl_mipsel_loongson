Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 00:38:12 +0100 (BST)
Received: from zcars0m9.nortelnetworks.com ([IPv6:::ffff:47.129.242.157]:53416
	"EHLO zcars0m9.nortelnetworks.com") by linux-mips.org with ESMTP
	id <S8225479AbUC3XiL>; Wed, 31 Mar 2004 00:38:11 +0100
Received: from zcard309.ca.nortel.com (zcard309.ca.nortel.com [47.129.242.69])
	by zcars0m9.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id i2UNc3K25520
	for <linux-mips@linux-mips.org>; Tue, 30 Mar 2004 18:38:03 -0500 (EST)
Received: from zcard0k6.ca.nortel.com ([47.129.242.158]) by zcard309.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id GXT6MLTB; Tue, 30 Mar 2004 18:38:03 -0500
Received: from americasm01.nt.com (wcary3hh.ca.nortel.com [47.129.112.118]) by zcard0k6.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id DNVQHQTP; Tue, 30 Mar 2004 18:38:03 -0500
Message-ID: <406A04DA.8070604@americasm01.nt.com>
Date: Tue, 30 Mar 2004 18:38:02 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Lijun Chen" <chenli@nortelnetworks.com>
Organization: Nortel Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: "Lijun Chen" <chenli@nortelnetworks.com>
Subject: Re: exception priority for BCM1250
References: <4069F90D.9060903@americasm01.nt.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chenli@nortelnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenli@nortelnetworks.com
Precedence: bulk
X-list: linux-mips

Further to my last email, another question is if multiple simultaneous 
exceptions occur, or kernel is
handling an exception, another exception occurs, how linux handles this?

Thanks,
Lijun

Chen, Lijun [CAR:7Q28:EXCH] wrote:

> Hi,
>
> Does anybody know which mips family SB1 core on bcm1250 falls into?
> It is a MIPS64 processor, does it belong to 5K family or 20Kc?
>
> What about the exception priorities, such as cache error exception, 
> bus error
> exception, and so on? Are they maskable or non-maskable? It is not 
> clear from
> BCM1250 and sb1 core manuals.
>
> Thanks a lot.
>
> Lijun
>
>
>
