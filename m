Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 14:19:09 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:43690
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992314AbdKMNTCTq4mS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 14:19:02 +0100
Received: by mail-qt0-x242.google.com with SMTP id j58so19445613qtj.0
        for <linux-mips@linux-mips.org>; Mon, 13 Nov 2017 05:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HG7cNdmsTYF3pfC7WJBn4JhV6KAI6O1srQPz1Cir5pU=;
        b=Yd05VZLDTwjNhUCbFOlExOmEVLgc7/F51GG+0P3ldRpACl3sSNVzACBvsiohrvr1Pf
         1ZaoWNJpXpaU3sqiYbEfPAkZPohYLTpd0BrnrRDDQm8fGgUByb+zDua/YtOZ1nKUxFh+
         6QR9Jb3zI7Jct1V/vEUNEN2/kIrXEPWg5PhTDC6jxRTgqhiTeBC0b57rtYVKv/nx0SFJ
         mHcCw2TEu3wxC4RM6rZpUYDwO6w6E5GrmhL1UH8cf2/YhClhaN7MmNAHwEVND2rPL7Ax
         FG9Lx9voMN1Lz+TJ25deUAoWBnz5aMnOEW3zNe0g7LXz/pdAq9/yLCKQLjj4DKwHovtz
         n0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HG7cNdmsTYF3pfC7WJBn4JhV6KAI6O1srQPz1Cir5pU=;
        b=K1EjuQsBQJsnNID8PHbQpPg3HrRLpYn7kJXZo5fNL8l1W0HnXC3Zpn9HItVeA2XeRc
         ylOT1p9zFDXDNbE4oXSVEiSpmvzrit45QVDfgGWYy2dtX1cvg2XAlv3gaCJ7F61EIe4j
         +Gs4qmRQ21BFGziGAWGfZ0YCpZe5HBm5WNcefhoS153h8aEmcjC2zGUA5u6bma14gEft
         aA132Zu7sLab07c4ZDr73IxcM+8OJozqIZsS4O2EbtxRkFpGFaAU2oCmn/9eJWHAYoKO
         e7dhreaH3ZpFATwNCThb+THtvObIzKjyDgHoU/2SufCHWisGg2Fi9fxNvSnniTANtX1g
         7zLQ==
X-Gm-Message-State: AJaThX4jQswW5qOoiMNmQliYbBjtDLEEQ2Y7SjZgdt2QNJOONHzEI0Ba
        oMzXZmKRzWSbxQxTnvAxBLRbqVNvlUxQ+UNekHunVA==
X-Google-Smtp-Source: AGs4zMajr/xreRhoUEFoAqYRwbp8+x5UlME87vk9y4nJjmtFrvbrIUR0YNcXsrwsfdJaR7fD97ZuTnWW/s/69QBxVbk=
X-Received: by 10.237.35.102 with SMTP id i35mr14671984qtc.49.1510579136199;
 Mon, 13 Nov 2017 05:18:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.53.26 with HTTP; Mon, 13 Nov 2017 05:18:55 -0800 (PST)
In-Reply-To: <1510576953.9806.1.camel@chimera>
References: <1510420788-25184-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
 <20171113112312.GZ15260@jhogan-linux> <CAMuHMdUtHhSLbrgmOW7gkEUg8pif+Ddc-zZgWzCZ4WL3JTeOKg@mail.gmail.com>
 <1510576953.9806.1.camel@chimera>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Nov 2017 14:18:55 +0100
X-Google-Sender-Auth: 970NQo4r6VSbV39tr31jT4WHf7Q
Message-ID: <CAMuHMdUN-3ycB8qgZw62V_18ZjjMnuCe1HdKqf0MT5cE3qy5nQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: implement a "bootargs-append" DT property
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60870
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

Hi Daniel,

On Mon, Nov 13, 2017 at 1:42 PM, Daniel Gimpelevich
<daniel@gimpelevich.san-francisco.ca.us> wrote:
> On Mon, 2017-11-13 at 13:31 +0100, Geert Uytterhoeven wrote:
>> I've seen other use cases, e.g. the extension of the du node's
>> "clocks" and
>> "clock-names" properties from arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> to
>> arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts.
>>
>> To avoid the proliferation of "-append" versions of existing
>> properties, what
>> about handling this in dtc, by adding support for an
>> "/append-property/"
>> keyword?
>
> That would not address use case #2 that I mentioned, where the dtb would
> have a "bootargs-append" property but no "bootargs" property.

For use case #2, you were talking about kernel configuration?
Isn't that something completely different?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
