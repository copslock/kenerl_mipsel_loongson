Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 00:45:14 +0000 (GMT)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:32545
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133833AbVKCAo4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 00:44:56 +0000
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 2 Nov 2005 16:45:40 -0800
Message-ID: <43695DB4.7060708@avtrex.com>
Date:	Wed, 02 Nov 2005 16:45:40 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	sjhill@realitydiluted.com
CC:	crossgcc@sources.redhat.com,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: linux kernel building for mips malta target board
References: <E1EXLJV-0005R4-K3@real.realitydiluted.com>
In-Reply-To: <E1EXLJV-0005R4-K3@real.realitydiluted.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Nov 2005 00:45:40.0843 (UTC) FILETIME=[EA3573B0:01C5E00F]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

sjhill@realitydiluted.com wrote:
>>>I would like to build latest kernel (ie kernel 2.6.13) for mips malta
>>>board. Can any one advise me the cross-compiler tools version to be 
>>>used for building the linux kernel.
>>>
>>
>>I use both gcc-3.3.1 and gcc-3.4.3 to build 2.6.x mips linux kernels.  I 
>>think for the 2.6.13 kernel any of the latest released versions of 
>>3.3.x, 3.4.x, or 4.0.x would work.  Use the latest binutils (2.16.91 
>>20050817 is what I am using).
>>
> 
> Also, make sure to NOT use any of the 4.1 GCC stuff with Linux/MIPS
> kernels. I am still tracking down errors with it.
> 

Is this the problem you are seeing?:
In file included from include/linux/nfs_fs.h:15,
                  from init/do_mounts.c:12:
include/linux/pagemap.h: In function ‘fault_in_pages_readable’:
include/linux/pagemap.h:236: error: read-only variable ‘__gu_val’ used 
as ‘asm’ output
include/linux/pagemap.h:236: error: read-only variable ‘__gu_val’ used 
as ‘asm’ output
include/linux/pagemap.h:236: error: read-only variable ‘__gu_val’ used 
as ‘asm’ output
include/linux/pagemap.h:236: error: read-only variable ‘__gu_val’ used 
as ‘asm’ output

The compiler behavior has changed since 4.0.1, but I think the new 
behavior is correct.  I am blaming the __get_user macro in 
include/asm-mips/uaccess.h.  It should be possible to fix it there.  The 
alternative is to hack up include/linux/pagemap.h.

David Daney
