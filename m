Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Nov 2010 20:13:54 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11727 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491995Ab0KHTNv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Nov 2010 20:13:51 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cd84c120000>; Mon, 08 Nov 2010 11:14:26 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 8 Nov 2010 11:14:27 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 8 Nov 2010 11:14:27 -0800
Message-ID: <4CD84BEA.6010607@caviumnetworks.com>
Date:   Mon, 08 Nov 2010 11:13:46 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Robert Millan <rmh@gnu.org>
CC:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
References: <1289133059.1547.0@thorin>
In-Reply-To: <1289133059.1547.0@thorin>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Nov 2010 19:14:27.0520 (UTC) FILETIME=[298F0400:01CB7F79]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 11/07/2010 04:30 AM, Robert Millan wrote:
> El 04/11/10 19:43:08, en/na Robert Millan va escriure:
>> David Daney a écrit :
>>> You are claiming that all loongson2 are loongson-2f.  Is that
>>> really true?  Or are there other types of loongson2 that are not
>>> loongson-2f?
>>
>> I'll figure out how to distinguish them and send a new patch.
>
> I looked at details about CPU identification, and this
> seems to be broken.
>
> See the the notes about PRId in pages 72 and 66, respectively:
> http://dev.lemote.com/files/resource/documents/Loongson/ls2f/Loongson2FUserGuide.pdf
>
> In both 2E and 2F, the implementation field is the same (0x63).
>
> Revision field is the same too, according to docs, and it can't
> be used anyway (no garantee of consistency).

I seems weird to me that you cannot get this information from the PRId 
register.  Perhaps the documentation is defective.

The Chinese version of the Loongson2E user guide seems to say something 
about the two lower nibbles of the PRId, but being a non-chinese reader, 
I have no idea if it would be relevant.

I would think that the low order bits of the register can reliably 
differentiate these two parts.

David Daney



>
> I'm sending a new patch that uses machtype instead. Yes, I know
> it's a bit of a kludge, but it really seems to be the only way.
>
>> Well I appreciate consistency with GCC flag names,
>
> Actually, I missread GCC flag (it's dashless).  I'm using
> "loongson2f" as David requested.
>
