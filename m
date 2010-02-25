Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 18:32:11 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11343 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491872Ab0BYRcE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 18:32:04 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b86b41c0000>; Thu, 25 Feb 2010 09:32:12 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 25 Feb 2010 09:31:44 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 25 Feb 2010 09:31:44 -0800
Message-ID: <4B86B3FA.2030902@caviumnetworks.com>
Date:   Thu, 25 Feb 2010 09:31:38 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Optimize spinlocks.
References: <1265311909-1679-1-git-send-email-ddaney@caviumnetworks.com> <20100224155336.GA5130@linux-mips.org> <4B8559F0.6080908@caviumnetworks.com> <20100225141548.GB29565@linux-mips.org>
In-Reply-To: <20100225141548.GB29565@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2010 17:31:44.0552 (UTC) FILETIME=[6664BA80:01CAB640]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/25/2010 06:15 AM, Ralf Baechle wrote:
> On Wed, Feb 24, 2010 at 08:55:12AM -0800, David Daney wrote:
>
>> It is possible that by choosing a better nudge_writes()
>> implementation for R10K, that the 3% degradation could be erased.
>> Perhaps:
>>
>> #define nudge_writes() do { } while (0)
>
> raw_spin_unlock must provide a barrier so this wouldn't be a valid
> implementation for nudge_writes().

That barrier is separate (and present).  The sole purpose of 
nudge_writes() is to make speed up the global visibility of the 
releasing write, it does not have anything to do with locking semantics.

>  Implementing it as barrier() this
> is a pure compiler barrier is the most liberal valid implementation.

No, the most liberal would be a true NOP: 'do { } while (0)'.

>
>> Basically you want something that is fast, but that also forces the
>> write to be globally visible as soon as possible.  Some processors
>> have a prefetch instruction that does this.  On other processors a
>> NOP is optimal as they don't combine writes in the write back
>> buffer.
>>
>> There is a wbflush() function that could potentially be used, but
>> its implementation is too heavy on Octeon.
>
> For IP27 which is a strongly ordered system nudge_writes() is implemented
> as barrier().
>
> Another experiment I did was alignment.  A branch on an R10000 has a
> significant execution time penalty if it's delay slot is overlapping a
> 128 byte S-cache boundary.  Suitable alignment however didn't not seem
> to make any difference at all on R10000.
>
>    Ralf
>
