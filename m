Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 12:33:48 +0200 (CEST)
Received: from mail-ua0-x243.google.com ([IPv6:2607:f8b0:400c:c08::243]:33110
        "EHLO mail-ua0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990757AbeGRKdpvXvh5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2018 12:33:45 +0200
Received: by mail-ua0-x243.google.com with SMTP id i4-v6so2612669uak.0
        for <linux-mips@linux-mips.org>; Wed, 18 Jul 2018 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w/EtiM7nS2y94StdvKrCs47sFnQw5wDrCw76FqY+8Ps=;
        b=knN8RoHKkPKPo4XYdMABxVMEFgO4yypfODjsjUR28Qg9gvCCLWfod/KevWZEUt5OlL
         1E3cYBas4rGi/0t46Bu/Jxn1s41NWXVcxDjutNBqbSiLoAtDgFMQ1i8474/X4eYc7+ZU
         1JQvnUEucQ9OmPpn/O9wl7l0OmQ0vg/yQeKsNbDBkh3uTUV/06DpSXesUfn6kDLZoXmn
         DWwW4N2CDB4umEiK6j+c/v92HcbWfO+qcbx3xvDaatfHDslt1O+NrAioGJXIdZrAyYMe
         8KLXG0KT1VGe43Z3in+U8I+lEzDfiH5N5yV85VBzY6mZSqkXVNr0dGaCF3OCYOpjsup/
         2jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w/EtiM7nS2y94StdvKrCs47sFnQw5wDrCw76FqY+8Ps=;
        b=po3A20BbCtfObNPZGYJHEDqmRlxdqKDW9N4+f44G0jW8+mBYuKBiXiiupsbkUwETUV
         mv3DXspQpv3FtNQ+wcbNxcLt6B8mwyyorTXBBuJkB1di6xVBDMQuuc2n7scnwGss3fZo
         hpvzO4sQZV7HUlgeBRIDJ30Aff5xwebWGzqoz4UGNNZBxyTf/wMUKiqloflTnHjIeFur
         OG/iDHPuCdW5IafI+2m0NvjqodcsEHauaK7SFCEFAZxBYTU3GM0tfU9qB2fh0D5Nh0NH
         3oF0YaedVy+g5HBDdCgKfnwueBR+kg34nHMkP7ppYQCRqP8gOSEZG0jSD2SUaNXgptxF
         A83g==
X-Gm-Message-State: AOUpUlFTn7wV/kh14Ci1Z9nqdt1/NLhy74f6k/zswfBx9M95R8iVwcyL
        vKOLcZRua1dM+FbD73b8yB6FO4B6LSTMHC6XSWU=
X-Google-Smtp-Source: AAOMgpeR78oueyb1O0lLFA6KLVCfltg6G/bM9qN/gzP2JaUd6Yz6BrCpFVaZu7wDjKYZsN8cxL4c7WqzcC/e8fiA+6g=
X-Received: by 2002:ab0:1b93:: with SMTP id k19-v6mr3556456uai.122.1531910019667;
 Wed, 18 Jul 2018 03:33:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:33:39
 -0700 (PDT)
In-Reply-To: <20180717221301.GF3211@piout.net>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com> <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
 <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com>
 <20180717214212.GE3211@piout.net> <CAHp75VdEkQ=AC8xUBno7qp0E+cXqwq03WOtVB3sX+Z6zthDJSw@mail.gmail.com>
 <20180717221301.GF3211@piout.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 13:33:39 +0300
Message-ID: <CAHp75VfvP7s-ud0XRUfESjTNRdbaZH_qKRpXbkCzKqp8j5e6kg@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Wed, Jul 18, 2018 at 1:13 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 18/07/2018 00:54:21+0300, Andy Shevchenko wrote:
>> On Wed, Jul 18, 2018 at 12:42 AM, Alexandre Belloni
>> <alexandre.belloni@bootlin.com> wrote:
>> > On 18/07/2018 00:30:49+0300, Andy Shevchenko wrote:

>> > Well, I'm not sure how far this can be backported. It also seems nobody
>> > ever hit that while our hardware will hit it at every boot.

>> No-one enabled CONFIG_DEBUG_SHIRQ?

> Nope, this is a real HW IRQ. I meant find out up to when it can be
> sanely backported.

I meant that before your case no-one tested with that option enabled
which will behave like you describe (IRQ gets fired as soon as being
registered).

-- 
With Best Regards,
Andy Shevchenko
