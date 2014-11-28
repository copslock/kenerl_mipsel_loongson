Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 16:04:09 +0100 (CET)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:48502 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007476AbaK1PEHyCd1o convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Nov 2014 16:04:07 +0100
Received: by mail-ie0-f175.google.com with SMTP id x19so1073970ier.34
        for <multiple recipients>; Fri, 28 Nov 2014 07:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=coPCUyxc+vrMiBwjdQ/88NqIHbKZycQx5l3yydsslFw=;
        b=LUwPnTt6wRFXFwz5pxU+vLOeKZ3wBI7UNZaTA86DwrYSdqo84+aCJ7lbCweMnyyjt5
         IynrYgL9D5NRZ6YK0iJ4Br4SJeRn0SY2LcSJeRyWsGuAt1C+ejkMVkFfCYixPL0gge/j
         dkXc0N4zC4K+FsVqDghMI5FfUoQP+Rmux/vbyVzO9a7bco4qJTuMgeSMHVJ/N3XUGRxf
         cqn8113td0Sdxw7E/kEZ9gkVAKbj/MzPw48Csq5eVYB+s4obcJ5fFWCDcx1u6fHusd1C
         Geh8AzmY8IyHe7Y0fGBxbdkNyL28LLJGhmat3sezyvI7qvrsGvu5vGZgwB7PrYjmrb91
         RjWg==
X-Received: by 10.42.197.134 with SMTP id ek6mr13666725icb.7.1417187041970;
 Fri, 28 Nov 2014 07:04:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.246.168 with HTTP; Fri, 28 Nov 2014 07:03:41 -0800 (PST)
In-Reply-To: <tencent_60EBDA3907E4C1985C37621B@qq.com>
References: <1416561389-1046-1-git-send-email-chenhc@lemote.com>
 <CAAVeFu+CUCja6jxb0XONj80-6te1t31A49F4owNkWkoy7PcHuQ@mail.gmail.com> <tencent_60EBDA3907E4C1985C37621B@qq.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Sat, 29 Nov 2014 00:03:41 +0900
Message-ID: <CAAVeFuJZAxvVCpH0vQmYvF48F0XRoGNThFpDXjCPxQ_rrakHyg@mail.gmail.com>
Subject: Re: [PATCH V5 2/7] MIPS: Cleanup Loongson-2F's gpio driver
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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

On Fri, Nov 28, 2014 at 10:14 PM, 陈华才 <chenhc@lemote.com> wrote:
> I'm afraid that ARCH_HAVE_CUSTOM_GPIO_H cannot be simply removed, because ARCH_HAVE_CUSTOM_GPIO_H is slected by CONFIG_MIPS, other MIPS CPU (not Loongson) may need it.

Mmm, but all the custom gpio.h are in the mach- subdirectories, so
shouldn't this option be selected by each individual machine instead
of CONFIG_MIPS? If the MIPS maintainers agree with that, please add
one patch to do this change - otherwise just ignore my comment.
