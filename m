Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2015 05:05:19 +0100 (CET)
Received: from mail-qg0-f51.google.com ([209.85.192.51]:49199 "EHLO
        mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006561AbbBUEFRLh-2l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Feb 2015 05:05:17 +0100
Received: by mail-qg0-f51.google.com with SMTP id z60so17282143qgd.10
        for <linux-mips@linux-mips.org>; Fri, 20 Feb 2015 20:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PfcwKwRJ3bcaX8KiXY7DYvOUDXsiAjk6jFo7Qe7YZLQ=;
        b=EOcXFkwm/dp0+mQuYGTpTI186/ULTyXOIFhIg0B1ppNYlDyXQG48QSwjIDarUL2ymk
         1BhspvhDjAM68VT2rn8Vf3/r7wrAJR/pJcOyWJVH9jDRHR88ISMsVm/4jEjIM2KCdS78
         RVkIETWloSfxm1mIHv76ocm2/ZvMVqIIG+8MTGJD+HR9qZjNGrvDfmYN55DNrhbUfWur
         +0LUyEwDEIwymg69QBVnymGVMEP+MhZrLFbjHsrsdwLRMIVUhJrCTkYL0E9GSwFVLQ0f
         lrzSx/rn8EtzJHginxgti1P853YhKo+snmk/PLJviU8pLSY3yznwLvuJzdg49kR5hPb5
         UBzg==
X-Received: by 10.229.197.134 with SMTP id ek6mr2200148qcb.21.1424491511766;
 Fri, 20 Feb 2015 20:05:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.168.4 with HTTP; Fri, 20 Feb 2015 20:04:51 -0800 (PST)
In-Reply-To: <CAEdQ38HVxBug9ukgE1oXLo_e+8FDB_yuY0vn1d84puoThhdYCA@mail.gmail.com>
References: <alpine.LFD.2.11.1502200445290.26212@localhost> <CAEdQ38HVxBug9ukgE1oXLo_e+8FDB_yuY0vn1d84puoThhdYCA@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 20 Feb 2015 20:04:51 -0800
Message-ID: <CAEdQ38F5jWX8Ujs4Jj6scxPAqtZw55gn4exL_rj9HCmf5YJgCA@mail.gmail.com>
Subject: Re: what is the purpose of the following LE->BE patch to arch/mips/include/asm/io.h?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Feb 20, 2015 at 8:00 PM, Matt Turner <mattst88@gmail.com> wrote:
> On Fri, Feb 20, 2015 at 1:53 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>>
>>   was recently handed a MIPS-based dev board (can't name the vendor,
>> NDA) that *typically* runs in LE mode but, because of a proprietary
>> binary that must be run on the board and was compiled as BE, has to be
>> run in BE mode.
>>
>>   the vendor supplied a yoctoproject layer that seems to work fine
>> but, in changing the DEFAULTTUNE to big-endian, the following patch
>> had to be applied to the 3.14 kernel tree to the file
>> arch/mips/include/asm/io.h in order to get output from the console
>> port as the system was booting:
>>
>> 326c326,333
>> <               *__mem = __val;                                         \
>> ---
>>>       {                                                                               \
>>>               if (sizeof(type) == sizeof(u32))                \
>>>               {                                                                       \
>>>                       *__mem = __cpu_to_le32(__val);  \
>
> They're byte swapping a value if they're in big endian mode.
>
>>>               }                                                                       \
>>>               else                                                            \
>>>                       *__mem = __val;                                         \
>
> And they don't seem to really understand the __cpu_to_le32 macro...

Sorry, I should be more precise. They're byte swapping 32-bit values
if they're in big endian mode, and copying everything else without
conversion.
