Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 03:19:32 +0100 (CET)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37631 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009895AbbCYCTan1H2t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 03:19:30 +0100
Received: by igcxg11 with SMTP id xg11so14416751igc.0;
        Tue, 24 Mar 2015 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K86FSHzYIuckpJuvFqU+ahuAanzpRivEhkr8WEHXI2Y=;
        b=jaTkVeX+9vJq/tDWW5rXJmHnqJN4+vH3/naoVeTLoj6mIZxe6iBpgF4uBQgv/acoRX
         Umzj2WpH6RIFoxsmBaEo4ePC6zyA6Fh6y6GpcBi2wGT4ww1/dLyuxCMg1Q8xHKXynwWH
         L1+Hwq8oYLHirsAWATSQk91No+Pmg8e3uwoBWUtEWsPtLxXR915CvXutGhQp/BVe62VG
         uqZ9xnRZHehCwD3h4KDd+2aGljWaNKr4rEohxBEBEfFiWo7TLh97XpXdtbGRrgSRhUQB
         mjwxM2vauIPqkyV+1WKj54rC6HwpKpdWoZnem/CtF2++LT2tJ9qpAWHwZErHU2iNUGD3
         xnNQ==
X-Received: by 10.42.106.204 with SMTP id a12mr29930677icp.90.1427249961375;
 Tue, 24 Mar 2015 19:19:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.41 with HTTP; Tue, 24 Mar 2015 19:19:01 -0700 (PDT)
In-Reply-To: <CAAhV-H5i+ysaJi1=6ftyY_82yGBZnCqpUmCV2ayMVMDFw0uWVQ@mail.gmail.com>
References: <1426213595-28454-1-git-send-email-chenhc@lemote.com>
 <CAAVeFuLytDZwo-=Q3DSxS7jLWbr4Jgf8BsBr9VGptBBu4SzZZg@mail.gmail.com> <CAAhV-H5i+ysaJi1=6ftyY_82yGBZnCqpUmCV2ayMVMDFw0uWVQ@mail.gmail.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Wed, 25 Mar 2015 11:19:01 +0900
Message-ID: <CAAVeFuLF7tHgqXbX1MAikM67DwSu729eG0JcBiipSAG=AeBfOQ@mail.gmail.com>
Subject: Re: [PATCH V8 3/8] MIPS: Cleanup Loongson-2F's gpio driver
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46511
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

On Wed, Mar 25, 2015 at 10:15 AM, Huacai Chen <chenhc@lemote.com> wrote:
> I think these three patches can go to GPIO tree, because it has no
> relationship with others in this series.

In that case we would need a ack from the MIPS maintainers to move the
code into drivers/gpio/.

>
> Huacai
>
> On Mon, Mar 23, 2015 at 2:29 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
>> On Fri, Mar 13, 2015 at 11:26 AM, Huacai Chen <chenhc@lemote.com> wrote:
>>> This cleanup is prepare to move the driver to drivers/gpio. Custom
>>> definitions of gpio_get_value()/gpio_set_value() are dropped.
>>
>> I suppose this is starting to look ok, at least patches 3, 4 and 5
>> which are of interest for GPIO. I wonder which tree they should be
>> merged through, MIPS or GPIO? Not seeing the rest of the series, I
>> cannot make a suggestion.
>>
