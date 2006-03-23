Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Mar 2006 17:04:32 +0000 (GMT)
Received: from 67-129-173-13.dia.static.qwest.net ([67.129.173.13]:24719 "EHLO
	alfalfa.fortresstech.com") by ftp.linux-mips.org with ESMTP
	id S8133538AbWCWREX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Mar 2006 17:04:23 +0000
Received: from [172.27.1.132] ([172.27.1.132]) by alfalfa.fortresstech.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 23 Mar 2006 12:14:23 -0500
Message-ID: <4422D5FB.5050806@fortresstech.com>
Date:	Thu, 23 Mar 2006 12:08:11 -0500
From:	Steve Lazaridis <slaz@fortresstech.com>
Reply-To:  slaz@fortresstech.com
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	Steve Lazaridis <slaz@fortresstech.com>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	oprofile-list@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: au1550 oprofile
References: <441A1D53.6080305@fortresstech.com> <20060317145657.GD3771@linux-mips.org> <441B04AC.3090406@fortresstech.com>
In-Reply-To: <441B04AC.3090406@fortresstech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2006 17:14:23.0764 (UTC) FILETIME=[3B41D540:01C64E9D]
Return-Path: <SLaz@fortresstech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: slaz@fortresstech.com
Precedence: bulk
X-list: linux-mips

I figured out the problem.
Only I'm not sure if it's actually a bug or not. :)

It seems as if it's in the userspace oprofile tools.

I commented out the following from oprofile/daemon/opd_trans.c   and it 
works fine now.

/* FIXME: this logic is perhaps too harsh? */
if (trans->current->ignored || (trans->last && trans->last->ignored)) {
       verbprintf(vmisc, "in the harsh logic\n");
       goto out;
}


Maybe it's just too harsh for MIPS platforms?  The same version of 
oprofile worked fine on my x86 workstation.


Thanks,
Steve



Steve Lazaridis wrote:
> Thats true,
> But my problem is that timer mode isn't even working
> 
> Ralf Baechle wrote:
>> On Thu, Mar 16, 2006 at 09:22:11PM -0500, Steve Lazaridis wrote:
>>
>>> Has anyone successfully ran oprofile on an au1550?
>>> If so, was it in BigEndian mode?
>>>
>>> Are there any known issues with oprofile on au1xxx platforms?
>>
>> Alchemy processors don't implement performance counters, so there are
>> by definition no issues ;-)  That unfortunately means you're stuck
>> with timer mode.
>>
>>   Ralf
