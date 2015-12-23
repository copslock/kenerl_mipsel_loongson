Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Dec 2015 15:21:39 +0100 (CET)
Received: from mail-io0-f170.google.com ([209.85.223.170]:35931 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007994AbbLWOVe7eZv- convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Dec 2015 15:21:34 +0100
Received: by mail-io0-f170.google.com with SMTP id o67so216850241iof.3;
        Wed, 23 Dec 2015 06:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=k8ePj0OUs0RbLUTnoDmDoUNFWW4GEYjcoMd7Rp9672c=;
        b=fK+5zpj0a0BL28YbL6Sf5X+vAC0LOzGQ0VwT2eZDpzULBjPxhJb8ycBM5G2V3AMkLW
         nR0b7Hbt8rNtEaVl56nruJCPWnf1d9lCRUMr1lun7m4V0s2HrDiEqnmZUYEocadH7YyW
         OLTHRYHxY/9gIqOm9bJwnCbOx6fclemXrTMR85uATOrIsPnVO/ZpH4HaHajFBOtT8E+/
         YqMQjwotyqQ8PC+a5kNdr49qwLyKgNaHw/inwVO9vAbyZxBt/9dDg0uzuURwCg0Cfis2
         kHXGijnZ8uUNC2WU1TJkRHTd36fzvRJVenU/fpAZZ+oG4hY1K+cTzt9uZ1IxTUuGEPih
         Q5NQ==
MIME-Version: 1.0
X-Received: by 10.107.148.12 with SMTP id w12mr36830260iod.115.1450880489085;
 Wed, 23 Dec 2015 06:21:29 -0800 (PST)
Received: by 10.107.9.97 with HTTP; Wed, 23 Dec 2015 06:21:29 -0800 (PST)
In-Reply-To: <87egedfmsm.fsf@free-electrons.com>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
        <20151222212350.GF30172@localhost>
        <87egedfmsm.fsf@free-electrons.com>
Date:   Wed, 23 Dec 2015 15:21:29 +0100
X-Google-Sender-Auth: G-e9hANbGL9o3_S-FmQbLRUDDzc
Message-ID: <CAMuHMdVJY6+vFvO44kQkzbPJGDkY8SfRz3Dwt4-_RVJL2o=pdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions" node
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Olof Johansson <olof@lixom.net>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "arm@kernel.org" <arm@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Olof, Gregory,

On Wed, Dec 23, 2015 at 12:04 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
>  On mar., déc. 22 2015, Olof Johansson <olof@lixom.net> wrote:
>> On Mon, Dec 21, 2015 at 11:33:44AM +0100, Geert Uytterhoeven wrote:
>>> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
>>> property to "partitions" node"), which is in v4.4-rc6, the "partitions"
>>> subnode of an SPI FLASH device node must have a compatible property. The
>>> partitions are no longer detected if it is not present.
>>>
>>> However, several DTSes in -next have already been converted to the
>>> "partitions" subnode without "compatible" property, introduced by
>>> commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
>>> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
>>> partitions in a special 'partitions' subnode"). Hence all of these are
>>> now broken in -next, and will be broken in upstream during the merge
>>> window.
>>
>> So, if I understand this correctly, the partitions format was added for v4.4,
>> then this non-backwards compatible change was added in -rc6. But, there were
>> also DT files that had the new-for-v4.4 partitions nodes in them that then
>> stopped working in -rc6?
>
> At least for the mvebu dts, the change was added for v4.5 not
> v4.4. Currently it is only in the next branches (and also in your
> arm-soc tree in next/dt).

The same is true for the shmobile changes: they are queued up for v4.5.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
