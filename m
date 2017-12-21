Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 14:36:27 +0100 (CET)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:44365
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990437AbdLUNgUh8AFZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2017 14:36:20 +0100
Received: by mail-it0-x243.google.com with SMTP id b5so10696577itc.3;
        Thu, 21 Dec 2017 05:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7mqLHAp94DQ5OB9P3PMI8QtMybZxgIN202VcOV3hAOs=;
        b=JwUUI7aWx1nF3b8sex6dgnU9yhG5Wax/xqOXVIdUkJfY+Dv6grL3U1JJlMM5nA7A/h
         d5Nw45D2PlpDkh8j0O+LoQZoOaYp/FaMYvdxNoE1F07cwx6OkvWPq0jpRZ9Xa5h+Ip5C
         9Qp0K4BnwyLUr02SsnAFP6UH5ExIQaFxgP3Fru5TnIW4OhPnBcwQX/vEYxSJcx8X0SvL
         MI1Acquk18MD2BvKe/aAmmVdsvQUcdXUtJQZKZ2WOg2v1r5M2pN+DWCBLgXKQqyjE/M3
         kQVMZMospqwkR9hw5WR2ZqIHV4CxqM5Ic3GiBmicL8vzu1ffgbBycVE4UNidPzppiHWP
         RN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7mqLHAp94DQ5OB9P3PMI8QtMybZxgIN202VcOV3hAOs=;
        b=rvFvS3RSeb9nIn4F+XWkEqAzxNLOSSlSgz5wtq2Rs2+HtrYTIWnkExJlxbvw7QPCh3
         gnv0XgQuHeDr5w9tFlAPNMmtHFYLem5ZED2914GA1I/yGherqLa+AuyT8wA6882lP8dM
         REghbTP0eZU1xuyzxIakt2NkkhvEEe2JHzDHJKtr9zlXN88wGs40fufU1EaDu5v/nMhV
         2uSo6UCbVH7TanrWiXPOgPbKwlNn5d6ET0R7/KjrQIzMVujWbi1/+3qO0d6qhw42DM3n
         8X4/7JrEOQQJFopu/EQwJSH7HM2giTfzargthyCsop+AYp2OHmfSsmSTQ6g7rQSMHVda
         49Hw==
X-Gm-Message-State: AKGB3mJ6eHuNuv1LLhVQqMCzEOLx9101wuvxkKzgUy1cR7dnc9SOFvO9
        X5wfS/AJX+xBM1nGFy13vbhyO9vZ5aI1qsudAVA=
X-Google-Smtp-Source: ACJfBou3GQAAKOrsriqiv6YwQPxMOr2Z55FFHtMN4At3NzYp3pzG4QEmzigliQDZz/hIwNE0pEe2Q/BDI5WcYeHHXdU=
X-Received: by 10.36.70.146 with SMTP id j140mr10077927itb.66.1513863374348;
 Thu, 21 Dec 2017 05:36:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.169.20 with HTTP; Thu, 21 Dec 2017 05:36:13 -0800 (PST)
In-Reply-To: <20171219200915.GP15162@piout.net>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
 <20171208154618.20105-10-alexandre.belloni@free-electrons.com>
 <CANc+2y4BroVz4eZOeb_ygYH42kg4WPP0y_t4OUuVd50OBSDgXQ@mail.gmail.com> <20171219200915.GP15162@piout.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Thu, 21 Dec 2017 19:06:13 +0530
Message-ID: <CANc+2y5JFuVhgcen48yjE3GuzzZttmuU_NeKpSzxBQ2AidsDwQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] MIPS: mscc: Add initial support for Microsemi
 MIPS SoCs
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Alexandre,

On 20 December 2017 at 01:39, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 19/12/2017 at 20:27:02 +0530, PrasannaKumar Muralidharan wrote:
>> Given the fact that setup code is very small and most of it is generic
>> code I strongly believe that it is plausible to make use of generic
>> code completely. Please have a look at [1] and [2].
>>
>> 1. https://patchwork.kernel.org/patch/9655699/
>> 2. https://patchwork.kernel.org/patch/9655697/
>>
>> PS: My rb tag stays if this could not be done immediately.
>>
>
> I think we had that discussion on the previous version:
> https://www.linux-mips.org/archives/linux-mips/2017-11/msg00532.html
>
> I can't test on the sead3 so I'd prefer not changing its code right now.
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

Sorry I missed it. Your v1 did not show up in my mailbox somehow even
though I am subscribed to linux-mips mailing list. Hope generic code
can be used in future.

Regards,
PrasannaKumar
