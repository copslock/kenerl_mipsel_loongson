Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 01:42:12 +0000 (GMT)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:17607
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225250AbVCVBl6>;
	Tue, 22 Mar 2005 01:41:58 +0000
Received: from [192.168.0.35] ([192.168.0.35] unverified) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 21 Mar 2005 17:41:54 -0800
Message-ID: <423F77DF.2060808@avtrex.com>
Date:	Mon, 21 Mar 2005 17:41:51 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	linux-mips@linux-mips.org
Subject: Re: NPTL support for the kernel
References: <20050316141151.GA23225@nevyn.them.org> <20050321203445.GA7082@nevyn.them.org> <423F7305.2030908@gentoo.org>
In-Reply-To: <423F7305.2030908@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2005 01:41:54.0184 (UTC) FILETIME=[5384F080:01C52E80]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> Daniel Jacobowitz wrote:
> 
>>
>> Ping?
>>
> 
> Doesn't this need the glibc side of things to be effective?, or is it 
> testable  w/o that component?

I think the main point is that it should not break existing code.

We need NPTL support in all three of GCC, Linux kernel and glibc before 
it can be tested.  If it doesn't break existing code, I think it should 
go in the kernel so that we have something on which to test gcc and glibc.

Just my $0.02

David Daney.
