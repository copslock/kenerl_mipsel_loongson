Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2010 20:37:29 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:44877 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492463Ab0EJShV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 May 2010 20:37:21 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id o4AIbBRJ025672;
        Mon, 10 May 2010 11:37:12 -0700
Received: from [192.168.65.41] ([192.168.65.41]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 10 May 2010 11:36:32 -0700
Message-ID: <4BE85256.9010709@mips.com>
Date:   Mon, 10 May 2010 11:37:10 -0700
From:   Chris Dearman <chris@mips.com>
Organization: MIPS Technologies
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix abs.[sd] and neg.[sd] emulation for NaN operands
References: <20091012215522.30362.49399.stgit@localhost.localdomain>    <20091012215718.30362.67068.stgit@localhost.localdomain> <20100510.234946.229279777.anemo@mba.ocn.ne.jp>
In-Reply-To: <20100510.234946.229279777.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 May 2010 18:36:32.0967 (UTC) FILETIME=[B6A34570:01CAF06F]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Excuse me for too late comment.
> 
> On Mon, 12 Oct 2009 14:57:18 -0700, Chris Dearman <chris@mips.com> wrote:
>> From: Nigel Stephens <nigel@mips.com>
>>
>> This patch ensures that the sign bit is always updated
>> for NaN operands.
> ...
>> @@ -76,15 +74,12 @@ ieee754dp ieee754dp_abs(ieee754dp x)
>>  	CLEARCX;
>>  	FLUSHXDP;
>>  
>> +	/* Clear sign ALWAYS, irrespective of NaN */
>> +	DPSIGN(x) = 0;
>> +
>>  	if (xc == IEEE754_CLASS_SNAN) {
>> -		SETCX(IEEE754_INVALID_OPERATION);
>> -		return ieee754dp_nanxcpt(ieee754dp_indef(), "neg");
>> +		return ieee754dp_nanxcpt(ieee754dp_indef(), "abs");
>>  	}
>>  
>> -	if (ieee754dp_isnan(x))	/* but not infinity */
>> -		return ieee754dp_nanxcpt(x, "abs", x);
>> -
>> -	/* quick fix up */
>> -	DPSIGN(x) = 0;
>>  	return x;
>>  }
> 
> Is there any reason for removal of SETCX(IEEE754_INVALID_OPERATION)
> line here?
> 
> The older version of this fix ("Fix absd emulation" by Raghu Gandham)
> did not remove the line.
> 
> Without this line, a signaling NaN will not raise a signal.  It seems
> not expected behaviour.

ieee754dp/sp_nanxcpt also sets the invalid exception bit so I think this 
is duplicated code. I think the same fix should have been applied to 
ieee754sp_neg/ieee754dp_neg for consistency.

Chris

-- 
Chris Dearman               Desk: +1 408 530 5092  Cell: +1 408 398 5531
MIPS Technologies Inc            955 East Arques Ave, Sunnyvale CA 94085
