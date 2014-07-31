Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 07:14:24 +0200 (CEST)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:43705 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821737AbaGaFOWA2IT3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jul 2014 07:14:22 +0200
Received: by mail-ie0-f169.google.com with SMTP id rd18so3088041iec.28
        for <multiple recipients>; Wed, 30 Jul 2014 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6bcp7kJ4D2DGbehWzp4i1x2iHV/gVUQTodTXD5yEAk4=;
        b=qYzl+wCQDWIoQwW10ay8qswhRAnxexphmwaWHd5Oq71VyG6I2gWGjSqthqaYsF1VWZ
         Cg2wBYg6m4R6XNX+Mpu88Gkqaa1ufNJi4b755s5KDuviKwHQ+OLXDte1fA/eRJ0KOWvw
         hgIIXBRxfdd05wiMMQA/a2H1xDmrnANuyKHmsWdwUItKPugCHR31DZrsxuq8YBhoqCw1
         o5cdBxpdO4t5JKr8aews/Dj0OX9yXLvnp4JlF7IQyVir0qvx4X3h2c5rpZTLsQ0L14SK
         i4A33ybjNXlAfGZNeL1TVllL/Cbpn95M4fJYe9Dn8QO0isDWwUYbYIVAre8PZxiVHEts
         bkBg==
MIME-Version: 1.0
X-Received: by 10.43.6.195 with SMTP id ol3mr11630906icb.86.1406783655358;
 Wed, 30 Jul 2014 22:14:15 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Wed, 30 Jul 2014 22:14:15 -0700 (PDT)
In-Reply-To: <53D93E5C.2000706@hauke-m.de>
References: <1406584437-31108-1-git-send-email-hauke@hauke-m.de>
        <CACna6rw_OswnvN7YD7AVnCNKtKJAk8UGXEjUdVJEvaBF3ErAmQ@mail.gmail.com>
        <53D93E5C.2000706@hauke-m.de>
Date:   Thu, 31 Jul 2014 07:14:15 +0200
Message-ID: <CACna6ryCP98zJ9PikqycyX1=Enw1BgRgJu+Www+jmLzr5A9u4w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: make reboot more relaiable
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41835
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

On 30 July 2014 20:50, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 07/30/2014 08:06 PM, Rafał Miłecki wrote:
>> Did you see code in hndmips.c of Broadcom SDK? Maybe we need this
>> magic ASM code they have it there?
>>
>> if (CHIPID(sih->chip) == BCM4785_CHIP_ID)
>>     MTC0(C0_BROADCOM, 4, (1 << 22));
>> si_watchdog(sih, 1);
>> if (CHIPID(sih->chip) == BCM4785_CHIP_ID) {
>>     __asm__ __volatile__(
>>         ".set\tmips3\n\t"
>>         "sync\n\t"
>>         "wait\n\t"
>>         ".set\tmips0");
>> }
>> while (1);
>>
>> Maybe it'll work better and more reliable?
>>
> This looks interesting, I haven't seen this.
>
> Please drop this patch for now, I will create a new one

Ralf, I'm afraid you didn't drop this patch.

-- 
Rafał
