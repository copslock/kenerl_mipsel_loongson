Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 13:31:48 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:51709
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdKMMbknN4ES (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 13:31:40 +0100
Received: by mail-qt0-x242.google.com with SMTP id e19so14432674qte.8
        for <linux-mips@linux-mips.org>; Mon, 13 Nov 2017 04:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MunAEG4Ln7rd7ZQAEBZt4Tibzj3bVFHmXRfGlZaax9A=;
        b=aTjMR+VCRif6kCp+Yegns2f93LRePayOgTzaBrW6vbFgSJ1fiuHJ88KkhNdkjQmv4O
         sGFcpWuj4HgSwI589WEhgpkfOkhDtZRj5f4S0af5xXxSBLaoZpqnkNCRL76Rvb98N0AI
         sWFwFVA8jKVQr6UslnnxHg47mDiIGZ56d9dHBayXvbdBcGDHDKLToGiXz6h66BBt7FAd
         cKh6+beK8mxSGwjvbv4ltPT/PN/YHZ0OGfb1PwXStTq1nejj9G/lwaw7fVGrenMfUYl4
         BSfSpF0RcM9aVALzJpgbEwd8cqHBwZYR43QRE8bxl8XGtGzM3i9Axeyg18GS7qTme40n
         Zmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MunAEG4Ln7rd7ZQAEBZt4Tibzj3bVFHmXRfGlZaax9A=;
        b=OQIp4hYNYZtvgO9pybUI0G4hb2oW2hX7Upbj87RmgXXf16OZ5Bf6pICmeDk7pdURbr
         NcsHawIK0NxNFnW5iUu/DSLj/340wuoRq41I527sg3kTB/pZu42Gl1yFjNs6xRH2vgBT
         urxXM7OXBIEqiK7+aFX56c5rjIID4Q8euixsCzDPRBwscdVJgZ7OvnncDF0l9MWsE7Ce
         9pGed+zhArqB9uWq8uTVVgDJjRt0AyiUMM/A9qJdow8764mYApLFny/ozfcAEvzXDBo5
         DZ50dnvj7hdLuxH86TJOj4Jim6FYzA14dV9Wk6J4DLcPVGdeb1b35Tdf1d5pqSYYq6rZ
         Jfzw==
X-Gm-Message-State: AJaThX6bYtRYOJVVkX/S8OyyapbWTAK2v+1EgkYGzbj/iU9cD94KO508
        UEVykMHDjtXl6mPIx6Pws5UWTVio/ZnCPP/aRn0=
X-Google-Smtp-Source: AGs4zMaypa88GzZsXaX7R0wv0B6mLSaGs+Wylh9anODgx/KA80IhjwzHFmzFyrbXy7zWZ54gJbVimiqQGtl2xMQ05eo=
X-Received: by 10.200.55.75 with SMTP id p11mr13786468qtb.298.1510576294436;
 Mon, 13 Nov 2017 04:31:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.53.26 with HTTP; Mon, 13 Nov 2017 04:31:33 -0800 (PST)
In-Reply-To: <20171113112312.GZ15260@jhogan-linux>
References: <1510420788-25184-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
 <20171113112312.GZ15260@jhogan-linux>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Nov 2017 13:31:33 +0100
X-Google-Sender-Auth: UyYUYbEQk_o8a8btCJoqsvaCnxo
Message-ID: <CAMuHMdUtHhSLbrgmOW7gkEUg8pif+Ddc-zZgWzCZ4WL3JTeOKg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: implement a "bootargs-append" DT property
To:     James Hogan <james.hogan@mips.com>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60851
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

Hi James, Daniel,

On Mon, Nov 13, 2017 at 12:23 PM, James Hogan <james.hogan@mips.com> wrote:
> On Sat, Nov 11, 2017 at 09:19:48AM -0800, Daniel Gimpelevich wrote:
>> There are two uses for this:
>>
>> 1) It may be useful to split a device-specific kernel command line between
>> a .dts file and a .dtsi file, with "bootargs" in one and "bootargs-append"
>> in the other, such as for variations of a reference board.

I've seen other use cases, e.g. the extension of the du node's "clocks" and
"clock-names" properties from arch/arm64/boot/dts/renesas/r8a7795.dtsi to
arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts.

To avoid the proliferation of "-append" versions of existing properties, what
about handling this in dtc, by adding support for an "/append-property/"
keyword?

     bootargs = "first part"
     ...
     /append-property/ bootargs = " second part".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
