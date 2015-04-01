Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 13:20:17 +0200 (CEST)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34266 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008635AbbDALUQ1qgzN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Apr 2015 13:20:16 +0200
Received: by igcau2 with SMTP id au2so29353888igc.1;
        Wed, 01 Apr 2015 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7YQrGudHsH0W7lPVQOQYshk0M5KPL16dFe2gxJmzh08=;
        b=BUvU+39o3wS6mlCflhyotfRzriJpOGjDFI3CuvSwAAkXD0Tu8Qz3huXt+1HM9TbddB
         P7H4c1KtYMzUekLOtUgXl3/FCIkN0L3rqv7Sn0OPqkazj6FvVuIgDNOFQPRntVdgOSn7
         ZchVaygbhwy+3i46pzKiPlsuW9ngY0leqWupkhCFrkqXYp+gTDi5wTHIWhy36BrH3+lC
         Sg623Onb6OwoS+qwTcv3nnQIxL/GakZibKx9YgZprvJD8VA+nntoy4/o6gapd2ZLRTKp
         3GG2Zm+2+MQjS6sWfym79+VitVPJ/a3zXAEpMBucoyZbQ5BcCL5Rxc6X0P2MYJGgf2Cg
         89hA==
MIME-Version: 1.0
X-Received: by 10.50.131.196 with SMTP id oo4mr11394526igb.2.1427887211869;
 Wed, 01 Apr 2015 04:20:11 -0700 (PDT)
Received: by 10.107.52.205 with HTTP; Wed, 1 Apr 2015 04:20:11 -0700 (PDT)
In-Reply-To: <551BD33B.5030707@cogentembedded.com>
References: <1427869385-23333-1-git-send-email-zajec5@gmail.com>
        <551BD33B.5030707@cogentembedded.com>
Date:   Wed, 1 Apr 2015 13:20:11 +0200
Message-ID: <CACna6ry-vFUPuwp1GLv9PbE219zug7n9S=Xr=1mrdTx=JStnvQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: BCM47XX: Include io.h directly and fix brace indent
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 1 April 2015 at 13:15, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 4/1/2015 9:23 AM, Rafał Miłecki wrote:
>
>> We use IO functions like readl & ioremap_nocache, so include linux/io.h
>
>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> ---
>>   arch/mips/bcm47xx/nvram.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>
>
>> diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
>> index 6a97732..2357ea3 100644
>> --- a/arch/mips/bcm47xx/nvram.c
>> +++ b/arch/mips/bcm47xx/nvram.c
>
> [...]
>>
>> @@ -203,7 +204,7 @@ int bcm47xx_nvram_getenv(const char *name, char *val,
>> size_t val_len)
>>                 if (eq - var == strlen(name) &&
>>                     strncmp(var, name, eq - var) == 0)
>>                         return snprintf(val, val_len, "%s", value);
>> -               }
>> +       }
>
>
>    Unrelated (and undescribed) change.

Described in the commit message, skipped in the description.

I was feeling a bit unsure about sending two so trivial patches: one
for single-line include, second for single-line indent. So I merged
them.

-- 
Rafał
