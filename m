Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2011 18:15:47 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:44945 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491137Ab1EGQPk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 May 2011 18:15:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id DAD688ACA;
        Sat,  7 May 2011 18:15:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QM64tl2acck1; Sat,  7 May 2011 18:15:35 +0200 (CEST)
Received: from [192.168.0.151] (dyndsl-085-016-167-129.ewe-ip-backbone.de [85.16.167.129])
        by hauke-m.de (Postfix) with ESMTPSA id 7F9FD8AC9;
        Sat,  7 May 2011 18:15:35 +0200 (CEST)
Message-ID: <4DC57027.2010806@hauke-m.de>
Date:   Sat, 07 May 2011 18:15:35 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] MIPS: BCM47xx: Fix mac address parsing.
References: <1304771263-10937-1-git-send-email-hauke@hauke-m.de> <1304771263-10937-6-git-send-email-hauke@hauke-m.de> <4DC55F80.7010409@mvista.com>
In-Reply-To: <4DC55F80.7010409@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

On 05/07/2011 05:04 PM, Sergei Shtylyov wrote:
> Hello.
> 
> Hauke Mehrtens wrote:
> 
>> Some devices like the Netgear WGT634u are using minuses between the
>> blocks of the mac address and other devices are using colons to
>> separate them.
> 
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  arch/mips/include/asm/mach-bcm47xx/nvram.h |   11 +++++++++--
>>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
>> diff --git a/arch/mips/include/asm/mach-bcm47xx/nvram.h
>> b/arch/mips/include/asm/mach-bcm47xx/nvram.h
>> index 9759588..fcdeca7 100644
>> --- a/arch/mips/include/asm/mach-bcm47xx/nvram.h
>> +++ b/arch/mips/include/asm/mach-bcm47xx/nvram.h
>> @@ -39,8 +39,15 @@ extern int nvram_getenv(char *name, char *val,
>> size_t val_len);
>>  
>>  static inline void nvram_parse_macaddr(char *buf, u8 *macaddr)
>>  {
>> -    sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0],
>> &macaddr[1],
>> -           &macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
>> +    if (strchr(buf, ':')) {
>> +        sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0],
>> &macaddr[1],
>> +            &macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
>> +    } else if (strchr(buf, '-')) {
>> +        sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx", &macaddr[0],
>> &macaddr[1],
>> +            &macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
>> +    } else {
>> +        printk(KERN_WARNING "Can not parse mac address: %s\n", buf);
>> +    }
>>  }
>>  
>>  #endif
> 
>    checkcptach.pl says:
> 
> WARNING: line over 80 characters
> #21: FILE: arch/mips/include/asm/mach-bcm47xx/nvram.h:43:
> +        sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0],
> &macaddr[1],
> 
> WARNING: line over 80 characters
> #24: FILE: arch/mips/include/asm/mach-bcm47xx/nvram.h:46:
> +        sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx", &macaddr[0],
> &macaddr[1],
> 
> total: 0 errors, 2 warnings, 17 lines checked
> 
> patches/MIPS-BCM47xx-Fix-mac-address-parsing.patch has style problems,
> please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
>    Additionally, though the script doesn't warn about this, {} are not
> necessary -- every branch is really a single statement.
> 
> WBR, Sergei
Hi Sergei,

I will fix this and send a new version. I checked it with checkpatch,
but changed some parts after that. ;-)

Hauke
