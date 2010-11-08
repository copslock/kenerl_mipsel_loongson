Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Nov 2010 23:50:54 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17393 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492040Ab0KHWuv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Nov 2010 23:50:51 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cd87ef00000>; Mon, 08 Nov 2010 14:51:28 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 8 Nov 2010 14:51:29 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 8 Nov 2010 14:51:29 -0800
Message-ID: <4CD87EC3.2060405@caviumnetworks.com>
Date:   Mon, 08 Nov 2010 14:50:43 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Robert Millan <rmh@gnu.org>
CC:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
References: <1289133059.1547.0@thorin>  <4CD84BEA.6010607@caviumnetworks.com> <AANLkTikCD_HjshMiP0ubyYZkPDoRb8nkFScUPE3GB2F4@mail.gmail.com>
In-Reply-To: <AANLkTikCD_HjshMiP0ubyYZkPDoRb8nkFScUPE3GB2F4@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2010 22:51:29.0502 (UTC) FILETIME=[7B43C7E0:01CB7F97]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 11/08/2010 02:27 PM, Robert Millan wrote:
> 2010/11/8 David Daney<ddaney@caviumnetworks.com>:
>> I seems weird to me that you cannot get this information from the PRId
>> register.  Perhaps the documentation is defective.
>
> Yes, I agree it's really shortsighted of them, but I don't
> see any way around it.
>
>> The Chinese version of the Loongson2E user guide seems to say something
>> about the two lower nibbles of the PRId, but being a non-chinese reader, I
>> have no idea if it would be relevant.
>>
>> I would think that the low order bits of the register can reliably
>> differentiate these two parts.
>
> There are English versions for both 2E and 2F.  See page 66
> of the Loongson 2F document:
>
> http://dev.lemote.com/files/resource/documents/Loongson/ls2f/Loongson2FUserGuide.pdf
>
> <quote>
> The revision number can distinguish some chip revisions, however there
> is no guarantee
> that changes to the chip will necessarily be reflected in the PRId
> register, or that changes to
> the revision number necessarily reflect real chip changes. For this
> reason, software should
> not rely on the revision number in the PRId register to characterize the chip.
> </quote>
>
> Page 72 of the Loongson 2E document
> (http://www.lemote.com/upfiles/godson2e-user-manual-V0.6.pdf) has the
> same text.
>
> In both documents, the lower byte is defined as "Revision number",
> and its value is 0x02 (for both 2E and 2F).
>
> If you'd rather not assume the docs are correct, I can test if
> my Yeeloong (Loongson 2F) has 0x02, but then in case it's
> something higher, would you be willing to assume:
>
>    rev<= 0x02  -->   2E
>    rev>  0x02  -->  2F
>

No, I refuse to assume that.


Look at the description of the register in this document:

http://dev.lemote.com/files/resource/documents/Loongson/ls2e/godson2e.user.manual.pdf

On page 49, it says that bits 0-3 contain the minor version number and 
bits 4-7 are the major version number (according to a workmate that 
reads Chinese).

I don't know for certain, but it seems plausible that the 2E and 2F will 
differ in bits 4-7, and bits 0-3 can be ignored.



> or similar logic?  This seems risky if we take into account
> that there's no guarantee from the vendor.
>
