Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 01:19:25 +0000 (GMT)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:33291
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133838AbVKCBTH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 01:19:07 +0000
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 2 Nov 2005 17:19:51 -0800
Message-ID: <436965B7.3000606@avtrex.com>
Date:	Wed, 02 Nov 2005 17:19:51 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Stuart Anderson <anderson@netsweng.com>
CC:	crossgcc@sources.redhat.com,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: linux kernel building for mips malta target board
References: <E1EXLJV-0005R4-K3@real.realitydiluted.com> <43695DB4.7060708@avtrex.com> <Pine.LNX.4.61.0511022000410.3511@trantor.stuart.netsweng.com>
In-Reply-To: <Pine.LNX.4.61.0511022000410.3511@trantor.stuart.netsweng.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2005 01:19:51.0618 (UTC) FILETIME=[B090E220:01C5E014]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Stuart Anderson wrote:
> On Wed, 2 Nov 2005, David Daney wrote:
> 
>> Is this the problem you are seeing?:
>> In file included from include/linux/nfs_fs.h:15,
>>                 from init/do_mounts.c:12:
>> include/linux/pagemap.h: In function fault_in_pages_readable:
>> include/linux/pagemap.h:236: error: read-only variable __gu_val 
>> used as asm output
>> include/linux/pagemap.h:236: error: read-only variable __gu_val 
>> used as asm output
>> include/linux/pagemap.h:236: error: read-only variable __gu_val 
>> used as asm output
>> include/linux/pagemap.h:236: error: read-only variable __gu_val 
>> used as asm output
>>
>> The compiler behavior has changed since 4.0.1, but I think the new 
>> behavior is correct.  I am blaming the __get_user macro in 
>> include/asm-mips/uaccess.h. It should be possible to fix it there.  
>> The alternative is to hack up include/linux/pagemap.h.
> 
> 
> __get_user() is unhappy, with tpyes that are "const". It uses __typeof()
> to create a local variable that it wants to write to. I've intended to
> have offer up a patch by now, but, too manyunexpected thing have 
> happened in the firs thalf of this week.
> 

That is my analysis as well.  The typeof converts the const char * into 
a const char which is then unsuitable as the destination in an inline asm.

David Daney
