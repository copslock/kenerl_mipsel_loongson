Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 21:27:05 +0200 (CEST)
Received: from mail-oa0-f45.google.com ([209.85.219.45]:42039 "EHLO
        mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834666AbaFXT1DCbgb4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 21:27:03 +0200
Received: by mail-oa0-f45.google.com with SMTP id o6so907330oag.18
        for <multiple recipients>; Tue, 24 Jun 2014 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=F8SPeHRnJNvo6u5tuygkh1Tft/1e3liItK//wm0/x70=;
        b=l1rnD2KZu5Ca7hpa1GiaydlK0ocd02vv+bCoyIpfoW73X8vjLpb0s5SB861qQAP4jR
         0srmXPhY465si1MkOnPkqlKRIfPjhZO8M6fMCQGPyC60aE06Tgtqs6Tz9327ekRk9UES
         O4VebzwnvR9CK7LTq52xxv3/1ivNyjgzwKbuqKaabONuWxt0rektaULgeNQDpP4UNaIm
         9cSTzpMKcurbSNv+W2wdeB4lqBjec1pQSvLD8yxRxuaZ3TM7U+NdrWK9rzOdDvMLvjTr
         4KfG+B725DmSvlPpDbtBVHFOI/QATlGbRb4LPNSdJ9pvf5zMMcPsykoUXiao8EmQI5Fg
         0fEQ==
X-Received: by 10.60.143.37 with SMTP id sb5mr3107626oeb.38.1403638016038;
 Tue, 24 Jun 2014 12:26:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.9.82 with HTTP; Tue, 24 Jun 2014 12:26:15 -0700 (PDT)
In-Reply-To: <1403624918.29061.16.camel@joe-AO725>
References: <20140624153959.GA19564@google.com> <1403624918.29061.16.camel@joe-AO725>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Tue, 24 Jun 2014 12:26:15 -0700
X-Google-Sender-Auth: qKePAIqC5fWPDNaDxdjIM_Yglyk
Message-ID: <CAGVrzcbgds+zHbTJWnUi48Nn1xPiEjGV7PGRmUX46da2CD+G=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ar7: replace mac address parsing
To:     Joe Perches <joe@perches.com>
Cc:     Daniel Walter <dwalter@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2014-06-24 8:48 GMT-07:00 Joe Perches <joe@perches.com>:
> On Tue, 2014-06-24 at 16:39 +0100, Daniel Walter wrote:
>> Replace sscanf() with mac_pton().
> []
>> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
> []
>> @@ -307,10 +307,7 @@ static void __init cpmac_get_mac(int instance, unsigned char *dev_addr)
>>       }
>>
>>       if (mac) {
>> -             if (sscanf(mac, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
>> -                                     &dev_addr[0], &dev_addr[1],
>> -                                     &dev_addr[2], &dev_addr[3],
>> -                                     &dev_addr[4], &dev_addr[5]) != 6) {
>> +             if (!mac_pton(mac, dev_addr)) {
>
> There is a slight functional change with this conversion.
>
> mac_pton is strict about leading 0's and requires a 17 char strlen.

I do not have my devices handy, but I am fairly positive the use of
sscanf() was exactly for that, we may or may not have leading zeroes.
I am feeling a little uncomfortable with random code changes like that
without being actually able to test on real hardware that has a
variety of bootloaders and environment variables.

>
> sscanf will accept 0:1:2:3:4:5, mac_pton will not.
>
>>                       pr_warning("cannot parse mac address, "
>>                                       "using random address\n");
>
> could be coalesced and pr_warn
>
>                         pr_warn("cannot parse mac address - using random address\n");
>
>
>



-- 
Florian
