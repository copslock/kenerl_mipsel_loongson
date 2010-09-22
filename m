Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 19:16:26 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:51934 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491078Ab0IVRQX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Sep 2010 19:16:23 +0200
Received: by fxm4 with SMTP id 4so624383fxm.36
        for <multiple recipients>; Wed, 22 Sep 2010 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=MYfrTL9Mf0jqxdZ7TY0xlBnTA6Jy5fUNbUi4mBFZauI=;
        b=dy8XXLppDJID3QtkFjv406Osy+1IwNtKQ3AR93dW7UX4BWqtU/scEmACPBFW8gZ4tv
         /SoNPTBGVb1+JQFz80BSUKlOxOux5g6V42JiNHszHXeZbzBzm19QEwQkuOJX9aiCnvlt
         pVWlOxOO+Lu5Sd+o3c24gmA99MS503IgVkQ/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=aPx7F2INxMQ5uuUMVUVvJl9r8/BmtGg6CxEGAb8XUrokRVZonQgBlLBulv3rcrLjgy
         Utnam0889TkKaqjfCQpPxMBW2e9wLToenaycZdi/e/wJbDD12+8G29EZstzMj85tmQ4i
         3e3dhXrJnRIQ1HnGGRWinjAsU6nAR7UatBqXA=
MIME-Version: 1.0
Received: by 10.223.107.20 with SMTP id z20mr650322fao.37.1285175777323; Wed,
 22 Sep 2010 10:16:17 -0700 (PDT)
Received: by 10.223.126.141 with HTTP; Wed, 22 Sep 2010 10:16:17 -0700 (PDT)
In-Reply-To: <4C9A327E.6030109@caviumnetworks.com>
References: <1285135150-14772-1-git-send-email-wuzhangjin@gmail.com>
        <4C9A327E.6030109@caviumnetworks.com>
Date:   Wed, 22 Sep 2010 19:16:17 +0200
X-Google-Sender-Auth: 5JohCMEFDUdlVxmQ5u29lVf-DYk
Message-ID: <AANLkTimkia5CcVLo973v0puRnXZ8c-PE4ocJ+pVq2Kf5@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Make EARLY_PRINTK selectable for !EMBEDDED
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     wuzhangjin@gmail.com, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 27795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17386

On Wed, Sep 22, 2010 at 18:44, David Daney <ddaney@caviumnetworks.com> wrote:
> On 09/21/2010 10:59 PM, wuzhangjin@gmail.com wrote:
>>
>> From: Wu Zhangjin<wuzhangjin@gmail.com>
>>
>> When EMBEDDED is disabled, the EARLY_PRINTK option will be hiden and we
>> have no way to disable it.
>>
>> For EARLY_PRINTK is not necessary for !EMBEDDED, we should make it
>> selectable and only enable it by default for EMBEDDED.
>>
>> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
>> ---
>>  arch/mips/Kconfig.debug |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
>> index 43dc279..77eba81 100644
>> --- a/arch/mips/Kconfig.debug
>> +++ b/arch/mips/Kconfig.debug
>> @@ -7,9 +7,9 @@ config TRACE_IRQFLAGS_SUPPORT
>>  source "lib/Kconfig.debug"
>>
>>  config EARLY_PRINTK
>> -       bool "Early printk" if EMBEDDED
>> +       bool "Early printk"
>>        depends on SYS_HAS_EARLY_PRINTK
>> -       default y
>> +       default y if EMBEDDED
>
> I hate to be a pedant, but how about if we don't make it depend on EMBEDDED
> at all?  I.E. just: 'default y'

That's what it was.

> If the system has SYS_HAS_EARLY_PRINTK, the overhead of enabling
> EARLY_PRINTK is low, although it may slow down booting.  But it is really
> not at all related to EMBEDDED.

Originally, not the _value_ of EARLY_PRINTK depended on EMBEDDED,
but the option to _change_ the value.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
