Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 13:00:34 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:63432 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904023Ab1KQMA1 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2011 13:00:27 +0100
Received: by ggnb1 with SMTP id b1so1122101ggn.36
        for <multiple recipients>; Thu, 17 Nov 2011 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WMrES2puG+cXz7EuRgRhxSI+xc6yJ3U9hpClOtSCncI=;
        b=uhKvyuseexeFThqjktmFQYbpGdFO4Mkmy7CqNbG6k0Kt55w2o8rn2wWtqJxwLUTa5+
         5+LtkKBGKKB0dJ9v0YsBILAjdA1pSVovBInOt1gMZLtT8D5eVEMy8m9heZGWAJ56BYIs
         Vj4mnBexLJBKUD08EPGdIc1wVMfpBIojpC2FY=
Received: by 10.236.200.135 with SMTP id z7mr8727617yhn.33.1321531221169; Thu,
 17 Nov 2011 04:00:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.102.141 with HTTP; Thu, 17 Nov 2011 03:59:39 -0800 (PST)
In-Reply-To: <4EC4F470.4090605@mvista.com>
References: <1321458148-7894-1-git-send-email-manuel.lauss@googlemail.com> <4EC4F470.4090605@mvista.com>
From:   Manuel Lauss <manuel.lauss@googlemail.com>
Date:   Thu, 17 Nov 2011 12:59:39 +0100
Message-ID: <CAOLZvyH4Hy8DpkSV4RHq0GgXrNE8ec=_2DaVx2ktRaVwpY8a9A@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: Alchemy: db1200: improve PB1200 detection.
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14405

On Thu, Nov 17, 2011 at 12:48 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.

>> diff --git a/arch/mips/alchemy/devboards/db1200.c
>> b/arch/mips/alchemy/devboards/db1200.c
>> index 1181241..6721991 100644
>> --- a/arch/mips/alchemy/devboards/db1200.c
>> +++ b/arch/mips/alchemy/devboards/db1200.c
>> @@ -66,19 +66,33 @@ static int __init detect_board(void)
>>  {
>>        int bid;
>>
>> -       /* try the PB1200 first */
>> +       /* try the DB1200 first */
>> +       bcsr_init(DB1200_BCSR_PHYS_ADDR,
>> +                 DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
>> +       if (BCSR_WHOAMI_DB1200 ==
>> BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI))) {
>> +               unsigned short t = bcsr_read(BCSR_HEXLEDS);
>> +               bcsr_write(BCSR_HEXLEDS, ~t);
>> +               if (bcsr_read(BCSR_HEXLEDS) != t) {
>> +                       bcsr_write(BCSR_HEXLEDS, t);
>> +                       return 0;
>> +               }
>> +       }
>> +
>> +       /* okay, try the PB1200 then */
>>        bcsr_init(PB1200_BCSR_PHYS_ADDR,
>>                  PB1200_BCSR_PHYS_ADDR + PB1200_BCSR_HEXLED_OFS);
>>        bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
>>        if ((bid == BCSR_WHOAMI_PB1200_DDR1) ||
>> -           (bid == BCSR_WHOAMI_PB1200_DDR2))
>> -               return 0;
>> +           (bid == BCSR_WHOAMI_PB1200_DDR2)) {
>> +               unsigned short t = bcsr_read(BCSR_HEXLEDS);
>> +               bcsr_write(BCSR_HEXLEDS, ~t);
>> +               if (bcsr_read(BCSR_HEXLEDS) != t) {
>> +                       bcsr_write(BCSR_HEXLEDS, t);
>> +                       return 0;
>> +               }
>
>   Isn't it worth putting the repetitive code into a subroutine?

If another Au1200-based reference board with similar hw design crops
up, maybe.   The lines saved now however seemed not worth the effort.

Manuel
