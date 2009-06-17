Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 21:28:51 +0200 (CEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:44942 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492094AbZFQT2p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jun 2009 21:28:45 +0200
Received: by bwz25 with SMTP id 25so673316bwz.0
        for <multiple recipients>; Wed, 17 Jun 2009 12:27:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rJP8DPmX5qx1iB6xa9P3FVs5wIhf9n9aer9vanrRb0M=;
        b=EVb+F8qs02Q0VXPEwkqQRyAu4EkMozD5Xn8VK2TPKq6NVu+9YNVYekDtR8K4IP+eKW
         ITkAZ++iNRIUmNt59cO4Isk1Wnx6ax2VlB1QbQfKSYnnUYNw98oOmO2fbjFvgR07Lxa5
         JmV75tWSEhjz99UT9YLvNVeIrAklfb6AiPnic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=s3ID58D5n2H4JBbt6FElAmW2qYn68CtgZnxZ7CWRCvDAvV/RQr4zMl4s4xh7sbDC3l
         UCGz4A9m1O1LwRaMD9eSRuGCdrCWfP/Arxdd7RLDUwhX4iEYoUweqgPZ+7N3Rq0rZNL/
         UCLHisCr9bGgQ5AAWXCN/vr1V222Azjekc4NY=
MIME-Version: 1.0
Received: by 10.103.176.20 with SMTP id d20mr401371mup.27.1245266832902; Wed, 
	17 Jun 2009 12:27:12 -0700 (PDT)
In-Reply-To: <4A390E47.1010801@caviumnetworks.com>
References: <4A38A173.9010508@gmail.com> <4A390E47.1010801@caviumnetworks.com>
Date:	Wed, 17 Jun 2009 21:27:12 +0200
Message-ID: <f861ec6f0906171227w650cd9bbiaab861a2ab34a1be@mail.gmail.com>
Subject: Re: [PATCH] -git compile fixes for MIPS
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Jun 17, 2009 at 5:39 PM, David Daney<ddaney@caviumnetworks.com> wrote:
> Manuel Lauss wrote:
>>
>> Quick fixes for some compile failures which have cropped up
>> in linus-git in the last 24 hours:
>>
>>  CC      arch/mips/kernel/time.o
>> In file included from linux-2.6.git/include/linux/bug.h:4,
>>                 from linux-2.6.git/arch/mips/kernel/time.c:13:
>> linux-2.6.git/arch/mips/include/asm/bug.h:10: error: expected '=', ',',
>> ';', 'asm' or '__attribute__' before 'BUG'
>> linux-2.6.git/arch/mips/include/asm/bug.h: In function '__BUG_ON':
>> linux-2.6.git/arch/mips/include/asm/bug.h:26: error: implicit declaration
>> of function 'BUG'
>>
>>  CC      arch/mips/mm/uasm.o
>> In file included from linux-2.6.git/arch/mips/mm/uasm.c:21:
>> linux-2.6.git/arch/mips/include/asm/bugs.h: In function 'check_bugs':
>> linux-2.6.git/arch/mips/include/asm/bugs.h:34: error: implicit declaration
>> of function 'smp_processor_id'
>> linux-2.6.git/arch/mips/mm/uasm.c: In function 'uasm_copy_handler':
>> linux-2.6.git/arch/mips/mm/uasm.c:514: error: implicit declaration of
>> function 'memcpy'
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>>  arch/mips/include/asm/bug.h  |    2 +-
>>  arch/mips/include/asm/bugs.h |    1 +
>>  arch/mips/mm/uasm.c          |    1 +
>>  3 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
>> index 08ea468..92b372a 100644
>> --- a/arch/mips/include/asm/bug.h
>> +++ b/arch/mips/include/asm/bug.h
>> @@ -7,7 +7,7 @@
>>
>>  #include <asm/break.h>
>>
>> -static inline void __noreturn BUG(void)
>> +static inline void __attribute__((noreturn)) BUG(void)
>
> That isn't correct.
>
> __noreturn is defined in linux/compiler.h  You should figure out why that
> definition is not being used.

I did a quick check, seems to be an include ordering problem; bug.h is included
before compiler.h... I don't know what exactly changed or whether the fact that
it worked previously was purely by accident.  The "right" thing to do I think is
to include compiler.h in asm/bug.h.

Manuel Lauss
