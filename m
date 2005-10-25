Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2005 10:13:40 +0100 (BST)
Received: from p549F5CB2.dip.t-dialin.net ([84.159.92.178]:26795 "EHLO
	p549F5CB2.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133529AbVJZJLL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Oct 2005 10:11:11 +0100
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:10762
	"EHLO avtrex.com") by linux-mips.net with ESMTP id <S870889AbVJYPBx>;
	Tue, 25 Oct 2005 17:01:53 +0200
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Oct 2005 08:01:31 -0700
Message-ID: <435E48CB.6040607@avtrex.com>
Date:	Tue, 25 Oct 2005 08:01:31 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Matej Kupljen <matej.kupljen@ultra.si>
CC:	linux-mips@linux-mips.org
Subject: Re: Where is op_model_mipsxx.c ?
References: <4343525A.6080605@avtrex.com>	 <20051005104437.GG2699@linux-mips.org> <1130239559.25742.19.camel@localhost.localdomain>
In-Reply-To: <1130239559.25742.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2005 15:01:31.0977 (UTC) FILETIME=[FC26EB90:01C5D974]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Matej Kupljen wrote:
> Hi
> 
> 
>>I've got oprofile support for MIPS32 / MIPS64 style counters in the queue.
>>It still needs some debugging to become actually useful but anyway, I'm
>>going to check those patches into git in a few minutes.
> 
> 
> Can these be used on the AMD AU1200 core?
> (I don't see Register 25 on Coprocessor 0)
> 
> If OProfile cannot be used, what can I use to profile the kernel?
> 

If there are no performance counters, OProfile can still use the system 
timer to take samples each clock tick.  This is the way I am using it.

To use it in this manner you have to hack up the code a bit so that the 
return value of oprofile_arch_init() (in oprofile/common.c) is -ENODEV.

David Daney.
