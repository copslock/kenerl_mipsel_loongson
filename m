Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2010 16:27:28 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:63647 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492272Ab0F3O1V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jun 2010 16:27:21 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o5UERBoq001100;
        Wed, 30 Jun 2010 07:27:11 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Wed, 30 Jun 2010 07:27:11 -0700
Received: from phils-poker.wrs.com ([172.25.35.76]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Wed, 30 Jun 2010 07:27:11 -0700
Message-ID: <4C2B543E.2010309@windriver.com>
Date:   Wed, 30 Jun 2010 07:27:10 -0700
From:   Phil Staub <phils@windriver.com>
Reply-To: phils@windriver.com
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc11 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Adam Jiang <jiang.adam@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: How to detect STACKOVEFLOW on mips
References: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com>
In-Reply-To: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2010 14:27:11.0204 (UTC) FILETIME=[53CCAA40:01CB1860]
X-archive-position: 27282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phils@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20245

On 06/29/2010 10:59 PM, Adam Jiang wrote:
> Hello, list.
>
> I'm having a problem with kernel mode stack on my box. It seems that
> STACKOVERFLOW happened to Linux kernel. However, I can't prove it
> because the lack of any detection in __do_IRQ() function just like on
> the other architectures. If you know something about, please help me
> on following two questions.
> - Is there any possible to do this on MIPS?

The mechanisms I know about for detecting stack overflow include:

1. Use of the MMU - stack ends at a page boundary, adjacent page is
either unmapped or mapped read-only and causes an exception if violated.

2. Hooks inserted into toolchain to cause any stack decrement to be
first tested against a limit.

3. Fill entire stack with a recognizable pattern before first
use. After suspected stack overflow, check to see if the pattern has
been disturbed in the area of the stack limit.

(Disclaimer: I've used all of these in some form on other OSes, but
not on Linux. Someone else may have a more directly relevant answer.)

> - or, more simple question, how could I get the address $sp pointed by
> asm() notation in C?

How about something like:

{
	long x;
	...
	asm("move %0,$29":"=g"(x));
	...
}

Phil

>
> Any suggestion from you will be appreciated.
>
> Best regards,
> /Adam
>
>


-- 
Phil Staub, Senior Member of Technical Staff, Wind River
Direct: 702.290.0470 Fax: 702.982.0085
