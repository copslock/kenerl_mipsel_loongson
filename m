Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Oct 2005 00:15:38 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:1309
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133583AbVJGXPV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Oct 2005 00:15:21 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 7 Oct 2005 16:15:19 -0700
Message-ID: <43470187.3070104@avtrex.com>
Date:	Fri, 07 Oct 2005 16:15:19 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Cross-compiling Linux problem
References: <002d01c5cb89$a4f1b830$0400a8c0@buzz> <4346F65B.6050800@avtrex.com> <4346FD34.8000100@total-knowledge.com>
In-Reply-To: <4346FD34.8000100@total-knowledge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2005 23:15:19.0694 (UTC) FILETIME=[FC3642E0:01C5CB94]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ilya A. Volynets-Evenbakh wrote:
> CVS is not where development happens, but it is still updated, according 
> to Ralf.
> 

Perhaps, but the reason I mentioned this is that I saw this warning:

arch/mips/mm/tlbex.c:516:5: warning: "CONFIG_64BIT" is not defined

Which is fixed in the git repository, but not CVS

David Daney

> David Daney wrote:
> 
>> Kyle Unice wrote:
>>
>>> I am using gcc-3.4.4 and the cvs checkout of linux-mips.org tree.
>>> Kyle
>>
>>
>>
>> Not withstanding Maciej's comment about the real problem being the 
>> broken header file, I give you a quote from 
>> http://www.linux-mips.org/wiki/Git : "At this time only the linux.git 
>> repository is in production use.... all other archives are only 
>> historical."
>>
>> You might consider getting your code from the git repository as the 
>> CVS repository is no longer being maintained.
>>
>> David Daney
>>
>>
> 
