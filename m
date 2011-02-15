Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 19:08:51 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:14485 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab1BOSIt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Feb 2011 19:08:49 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5ac1350000>; Tue, 15 Feb 2011 13:08:53 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 15 Feb 2011 10:08:46 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 15 Feb 2011 10:08:46 -0800
Message-ID: <4D5AC12D.3080108@caviumnetworks.com>
Date:   Tue, 15 Feb 2011 10:08:45 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Alexandre Oliva <aoliva@redhat.com>
CC:     linux-mips <linux-mips@linux-mips.org>, GCC <gcc@gcc.gnu.org>,
        binutils <binutils@sourceware.org>,
        Prasun Kapoor <prasun.kapoor@caviumnetworks.com>
Subject: Re: RFC: A new MIPS64 ABI
References: <4D5990A4.2050308@caviumnetworks.com> <orzkpx6v2m.fsf@livre.localdomain>
In-Reply-To: <orzkpx6v2m.fsf@livre.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2011 18:08:46.0219 (UTC) FILETIME=[634175B0:01CBCD3B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/15/2011 09:56 AM, Alexandre Oliva wrote:
> On Feb 14, 2011, David Daney<ddaney@caviumnetworks.com>  wrote:
>
>> Current MIPS 32-bit ABIs (both o32 and n32) are restricted to 2GB of
>> user virtual memory space.  This is due the way MIPS32 memory space is
>> segmented.  Only the range from 0..2^31-1 is available.  Pointer
>> values are always sign extended.
>
>> The proposed new ABI would only be available on MIPS64 platforms.  It
>> would be identical to the current MIPS n32 ABI *except* that pointers
>> would be zero-extended rather than sign-extended when resident in
>> registers.
>
> FTR, I don't really know why my Yeeloong is limited to 31-bit addresses,
> and I kind of hoped an n32 userland would improve that WRT o32, without
> wasting memory with longer pointers like n64 would.
>
> So, sorry if this is a dumb question, but wouldn't it be much easier to
> keep on using sign-extended addresses, and just make sure the kernel
> never allocates a virtual memory range that crosses a sign-bit change,
> or whatever other reason there is for addresses to be limited to the
> positive 2GB range in n32?
>

No, it is not possible.  The MIPS (and MIPS64) hardware architecture 
does not allow userspace access to addresses with the high bit (two bits 
for mips64) set.

Your complaint is a good summary of why I am thinking about n32-big.

David Daney
