Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 19:20:43 +0200 (CEST)
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33348 "EHLO
        mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009059AbbCaRUm24zvs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 19:20:42 +0200
Received: by qgfa8 with SMTP id a8so20702378qgf.0
        for <linux-mips@linux-mips.org>; Tue, 31 Mar 2015 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0Y7tzaa3pLj6+E9tmeoGc+JoXiSte9XJCR5VHMy0iHE=;
        b=YQncY2SHi+J93/Kmgdd3r5lyyS0a8cQveaBlL/DSU89lGqVDDHG/yP/e3lUcazHgE1
         a4SLEwVOQG032SA5pPWJiQtFgQhSrjV6jkadQ5KcnCPJlBNgK9lAVm+Kaz6my5lkgXHa
         8UFTjAmaUqmp9aDbaXoTn6Wq2jp5FEEoYrIlDBcJORf+P+R4Yec4kBUWHJZGUn3mKqDC
         wYd/HjV+FdaEjSMdi9qt7wfHu376a6ZX1Ly1IaLeG5IvTSngP0bna4BTzlUypmloTKJJ
         gwJVj4ZtXybYBqCkWdgt1pdPAZLEdDGdBa+duqdv7/k2G6F6LNFn3MYHBKwUuF3nIZjE
         JTlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0Y7tzaa3pLj6+E9tmeoGc+JoXiSte9XJCR5VHMy0iHE=;
        b=FOAt559L37soCUzA4Ss3/LFsnt/XdtheSJthrbxdTQzp3mH/5nfi4ij/b+0bUCaW65
         awJGuvi5EgZXluXveEgQVEq1Yh7fcDaZz+0dAACD2oGcVtS5yxZ5VeWscJ6nQl8VoNwe
         zj6rOjpUvbChWA29wkWqIiXcMe1atdrDFFtz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0Y7tzaa3pLj6+E9tmeoGc+JoXiSte9XJCR5VHMy0iHE=;
        b=AvNYtYoQhFl9FWFZ0MFQA/PXNPAKkWOj0duA0yrj86BLaQBHZL/wRh4ji946SuCIkv
         jDCABD9VwMkonfe0wb3AHKQ4L3bdg2C4wowIgi+BMIHHipSgC5gy4VVs2HgvgQkIZ0Ii
         iHW6cdqGvdQ/sesg7kmhVeRAfJH2aD3AoB5mBU/8ESHKiM5H5eL3bprus1rj+GD6l7MO
         YSpM130m/mto9/CRLgLuJ1r5KPxixXSDQxXxbbf2Om4TXwxtD4PNDz4Laz6Y7/TlKa9S
         oxvC7U11VvBIfIR1et7rrQ8Ejoeeeuetn4IJK2Zz1hnJ1BLVvoJf/d50BZszhI7ZusKb
         CkmA==
X-Gm-Message-State: ALoCoQnuMsKJAFP32WszJ+B3q5zAZ5Zs6GiTaUQeIpcZV1m9mwOcCCTGPsMGtbfDQZ+oI3M81ba0
MIME-Version: 1.0
X-Received: by 10.55.55.4 with SMTP id e4mr79971673qka.97.1427822437637; Tue,
 31 Mar 2015 10:20:37 -0700 (PDT)
Received: by 10.140.19.104 with HTTP; Tue, 31 Mar 2015 10:20:37 -0700 (PDT)
In-Reply-To: <20150331140034.GE28951@linux-mips.org>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
        <20150331140034.GE28951@linux-mips.org>
Date:   Tue, 31 Mar 2015 10:20:37 -0700
X-Google-Sender-Auth: U_POoJEBNBQcw1MNtBR4sE1lJmM
Message-ID: <CAL1qeaFd0dz0wirFzCRfetprjs1vJqm6RrmuPj0sBiEg_mc6pg@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] pinctrl: Support for IMG Pistachio
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Tue, Mar 31, 2015 at 7:00 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Mar 30, 2015 at 04:16:53PM -0700, Andrew Bresticker wrote:
>
>> This series adds support for the system pin and GPIO controller on the IMG
>> Pistachio SoC.  Pistachio's system pin controller manages 99 pins, 90 of
>> which are MFIOs which can be muxed between multiple functions or used
>> as GPIOs.  The GPIO control for the 90 MFIOs is broken up into banks
>> of 16.  Pistachio also has a second pin controller, the RPU pin controller,
>> which will be supported by a future patchset through an extension to this
>> driver.
>>
>> Test on an IMG Pistachio BuB.  Based on mips-for-linux-next which inluces my
>> series adding Pistachio platform support [1].  A branch with this series is
>> available at [2].
>
> Does this mean you want me to funnel this through the MIPS tree?  If so,
> could I have an Ack from the maintainers?

Linus mentioned in v1 that if the only dependency was a Kconfig symbol
that he could take it through his tree.  I'm fine either way, though
it would be slightly more convenient for it to go through the MIPS
tree.  Linus?

Thanks,
Andrew
