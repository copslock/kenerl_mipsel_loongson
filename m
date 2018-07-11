Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 14:09:37 +0200 (CEST)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:36374
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeGKMJZdwGZ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 14:09:25 +0200
Received: by mail-lf0-x243.google.com with SMTP id b22-v6so8650033lfa.3;
        Wed, 11 Jul 2018 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dNIP4uUIQON7/U4uGNehcu4msTo5LeEM3caAO8C4BuI=;
        b=NKerhMBGUe2V9J9W1Z24CjhUMsBIBhsIY4JtkYbF+My8CPQ5/7JhILxyVtwkrY1N28
         wCDp72m81oNE2oucGqG0EBXpYwvP28Rb3LAMxBeXPJcbWXR3wqWgF7P+P+znQgHeSmXJ
         mpqodjw2wQuoXzw86/F8yWrVack8p6AeemnKfw6FmyuNjgE6oYjKccA1G7Zy15RtJrHV
         rcwtvCzYUqrU/uxEySy90V3LMfILtcnyQtcARink6tL+hxMZM/5VC4aIAQKA0r/Tqsam
         PoumWG8ckx7vdL7tqYZZXAgASSs6t92nG6i3BmfoL03eAY9MSX03vXmG4SzWPttS/v4A
         RtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dNIP4uUIQON7/U4uGNehcu4msTo5LeEM3caAO8C4BuI=;
        b=RlUnNjlUHfxBjiWg9DfBYDQ2XpYw95gabHrrjqQrsdUeOZgMK0bP8blBC9STd+gSyP
         NAfum1TCJoEMJ3wg1Vmo6IrxgQvo9G1f3kkENaXsrgboZViY4bscUdboR8FZud/ol6ko
         5z8HDEI9G9cMsdTPVWT4kpx4N/g6OjTBweG+9GqOjdTs2GGlU4E4CtB3vkfaDYKssXe5
         cIsSB7kiowkSx7WmfkcqdoseHYp0s6UN9J9ZDrpO9t7dhWqNQZFzouOK4GCYdGLBAVDm
         CKbSJvVFkJ04RrDysu/LzVDxWw+QJWO9LLcEYESkSMSgZh+b5TBsEjxQi2Im48x6H7Pa
         4qTw==
X-Gm-Message-State: APt69E2WNLFWXjKPZvRCIkPaShm3v5kJgHR0oJNyuJC9foJizyS833i+
        4nsmujYBoa2idK+Wgxv9jS8HfNKzOjUpgHQWYbY=
X-Google-Smtp-Source: AAOMgpdGbnXIrj5YPlUmKtht6X5GPg3wAcSRx7WG9X/X1fbKRgSrFcO5hINjG9YWg/V8gTdysQKPbioR5+NUUKN54uQ=
X-Received: by 2002:a19:5c06:: with SMTP id q6-v6mr5990004lfb.6.1531310959898;
 Wed, 11 Jul 2018 05:09:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 05:09:19
 -0700 (PDT)
In-Reply-To: <20180711133236.67726256@bbrezillon>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
 <20180709200945.30116-5-boris.brezillon@bootlin.com> <20180711131626.732967be@bbrezillon>
 <CAK8P3a1CR_sN2KW4fZjADHrbKyB1ZSi=6+hPAPYoVeAeLGK_3g@mail.gmail.com> <20180711133236.67726256@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 14:09:19 +0200
X-Google-Sender-Auth: vHkqrLK68-DK_rJfucUaO-n060w
Message-ID: <CAK8P3a2Ar0itsfXBMDoJwq106KBYT-mx55znVF5cd478FqzJsQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/24] mtd: rawnand: s3c2410: Allow selection of this
 driver when COMPILE_TEST=y
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Jul 11, 2018 at 1:32 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Wed, 11 Jul 2018 13:27:53 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Wed, Jul 11, 2018 at 1:16 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > On Mon,  9 Jul 2018 22:09:25 +0200
>> > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>> >
>> >> It just makes NAND maintainers' life easier by allowing them to
>> >> compile-test this driver without having ARCH_S3C24XX or ARCH_S3C64XX
>> >> enabled.
>> >>
>> >> We add a dependency on HAS_IOMEM to make sure the driver compiles
>> >> correctly, and a dependency on !IA64 because the {read,write}s{bwl}()
>> >> accessors are not defined for this architecture.
>> >
>> > I see that SPARC does not define those accessors either. So I guess we
>> > should add depends on !SPARC.
>> >
>> > Arnd, any other way to know when the platform implements
>> > {read,write}s{bwl}() accessors?
>>
>> I'd just consider that a bug, and send a patch to fix sparc64 if it's broken.
>> sparc32 appears to have these, and when Thierry sent the patch
>> to implement them everywhere[1], he said that he tested sparc64 as
>> well, so either something regressed since then, or his testing
>> was incomplete. Either way, the correct answer IMHO would be to
>> make it work rather than to add infrastructure around the broken
>> configurations.
>
> I guess the same goes for IA64 then.

Right. FWIW, I just tried it out and sent the respective arch patches.

      Arnd
