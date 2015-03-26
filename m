Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 14:42:03 +0100 (CET)
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33173 "EHLO
        mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006155AbbCZNmCQn5wB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 14:42:02 +0100
Received: by qgfa8 with SMTP id a8so91629950qgf.0;
        Thu, 26 Mar 2015 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=H6FsLOwWe3EQhI/jgrdG/5M4CTSNO/Zi6dRhkL8qDG0=;
        b=kOA1qK9KN7E/8qZS4ownoDLYaG/s4y/3CSNbM4bIc+nOSs57g7enYL4/OgXrvBtIGm
         qoPDJCRquYK6qaGhx4CbBQjlDlRW6BblGUiHvDTZ6eIf3GiODErfVye/Iox4tzSXzuH5
         93Umsm6Y9LIlFAzPKfi2EU24NV3UnxyX6gg0+Z80xnBW66k9RUY6g6w9wKqi7OtAEr7K
         usX+S/ai/kmthbh+EJ9KU2TiJzuwiyNhvnDhELs6OgYkGGjj7f8LH8/8hO6aOl16fm2+
         UwIhF9sAgZxa+UJXA7W4mU/FGm1PZ/IQH8JLyJ76RpHWh2sMjqxMk/116EUSWNDXfG2F
         NSZQ==
X-Received: by 10.55.41.80 with SMTP id p77mr29457324qkh.67.1427377316552;
 Thu, 26 Mar 2015 06:41:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.90.18 with HTTP; Thu, 26 Mar 2015 06:41:36 -0700 (PDT)
In-Reply-To: <CAD3Xx4LMq1F8cDSR=17c3ViOML2ZYaL4d1ApkEog6bftSwKAPQ@mail.gmail.com>
References: <CAD3Xx4LMq1F8cDSR=17c3ViOML2ZYaL4d1ApkEog6bftSwKAPQ@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Thu, 26 Mar 2015 06:41:36 -0700
Message-ID: <CAJiQ=7DxwwWFts_ckcsusxRgTW+FYd2S32pgj48Pb2xYqKJ8LA@mail.gmail.com>
Subject: Re: MIPS: BMIPS: broken select on RAW_IRQ_ACCESSORS
To:     Valentin Rothberg <valentinrothberg@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>,
        Andreas Ruprecht <rupran@einserver.de>,
        hengelein Stefan <stefan.hengelein@fau.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Thu, Mar 26, 2015 at 3:47 AM, Valentin Rothberg
<valentinrothberg@gmail.com> wrote:
> Hi Kevin,
>
> your commit dd6d84812b1a ("MIPS: BMIPS: Enable additional peripheral
> and CPU support in defconfig") adds a select on the Kconfig symbol
> RAW_IRQ_ACCESORS.   However, this symbol is not defined in Kconfig so
> that the select turns out to be a NOOP.
>
> Is there a patch scheduled somewhere to add this symbol to Kconfig?

Oops, that is left over from an earlier attempt at getting the irqchip
drivers to run on 3384 in BE mode:

http://patchwork.linux-mips.org/patch/8254/

We wound up configuring this through DT rather than Kconfig.

Ralf, would you prefer an incremental patch or a whole new submission?
