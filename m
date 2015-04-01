Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 13:23:53 +0200 (CEST)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35412 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008551AbbDALXvrzWxs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 13:23:51 +0200
Received: by lbdc10 with SMTP id c10so33498489lbd.2
        for <linux-mips@linux-mips.org>; Wed, 01 Apr 2015 04:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KA91BnWRrsq2Hv7SKEhQxGadTosFck9tY1IQ3FRDNoo=;
        b=KgGvlqk3WoK8SgFcAoZVhn2QMT3/v7qccnZjhqNmPBDPHPcx+330I6HN/fgjPy7yXT
         dFWMq4D53LR0HL0x+YNNOv2GXQnWNwFEs5tA8/5O8z8JcJYEA5Ag+nKnNLryRXIjtL+1
         nILbFwkA2cSQwfM6Uwz+VEf0d0R4aJahk7H/U8HOuGrI2o4E4xgDlWrxQNtkAPUhCp68
         fEBaUZ5SYYQgznLo0NR6xiGIyRTOxJDHN8F7rurGvcC3WOysLS3rQdFJMibMS5AKtlz4
         QSd3dNVbkny+qvaoAwIxCji0vVG/gH96xnG2nJDAnXIFVUnlWm2kHZ57eBIScTPfQs4F
         vmPw==
X-Gm-Message-State: ALoCoQklzPym0WuxGug/OlLm+Xzq1UM95pvhDr4gCUnl2SMqZBqntrE3f7Ga+sw/5MzjfzivYLms
X-Received: by 10.112.170.132 with SMTP id am4mr34999376lbc.89.1427887427358;
        Wed, 01 Apr 2015 04:23:47 -0700 (PDT)
Received: from [192.168.3.154] (ppp85-141-196-14.pppoe.mtu-net.ru. [85.141.196.14])
        by mx.google.com with ESMTPSA id x4sm349184lba.22.2015.04.01.04.23.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 04:23:46 -0700 (PDT)
Message-ID: <551BD541.7080707@cogentembedded.com>
Date:   Wed, 01 Apr 2015 14:23:45 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 1/3] MIPS: BCM47XX: Include io.h directly and fix brace
 indent
References: <1427869385-23333-1-git-send-email-zajec5@gmail.com>        <551BD33B.5030707@cogentembedded.com> <CACna6ry-vFUPuwp1GLv9PbE219zug7n9S=Xr=1mrdTx=JStnvQ@mail.gmail.com>
In-Reply-To: <CACna6ry-vFUPuwp1GLv9PbE219zug7n9S=Xr=1mrdTx=JStnvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 4/1/2015 2:20 PM, Rafał Miłecki wrote:

>>> We use IO functions like readl & ioremap_nocache, so include linux/io.h

>>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>>> ---
>>>    arch/mips/bcm47xx/nvram.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)

>>> diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
>>> index 6a97732..2357ea3 100644
>>> --- a/arch/mips/bcm47xx/nvram.c
>>> +++ b/arch/mips/bcm47xx/nvram.c
>> [...]
>>> @@ -203,7 +204,7 @@ int bcm47xx_nvram_getenv(const char *name, char *val,
>>> size_t val_len)
>>>                  if (eq - var == strlen(name) &&
>>>                      strncmp(var, name, eq - var) == 0)
>>>                          return snprintf(val, val_len, "%s", value);
>>> -               }
>>> +       }

>>     Unrelated (and undescribed) change.

> Described in the commit message, skipped in the description.

    Ah, sorry, missed you summary...

> I was feeling a bit unsure about sending two so trivial patches: one
 > for single-line include, second for single-line indent. So I merged
 > them.

    No need to be unsure about this. Doing one thing per patch is perfectly 
legal and certainly better than doing 2 unrelated things. :-)

WBR, Sergei
