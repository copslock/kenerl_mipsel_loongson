Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 04:12:18 +0100 (CET)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36795 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006151AbbCYDMRe0stV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 04:12:17 +0100
Received: by wgra20 with SMTP id a20so11790928wgr.3;
        Tue, 24 Mar 2015 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=updNu9hUOE3rdSMIenmuv6MWnvIlRxuM88tqZua+gO4=;
        b=JR8xXeN5Xl3IUB81xkSF+G0nt5bzyzsQcCvEcpWlXD1rS72xK0+jK4k8bB3aKYTUn6
         I7+/PBtUfcDnsbifNZYmJTOxJeyuasvQeQ++QI6TLHEqhNaNkH0l3kdet7ybA1bifoEF
         L+QzfZ/YorpU6w4XliEKXz85otzuKCib5p/U1Mn93CoSR82aW6l8kK5QbPZ1empTFdsx
         qdb//GZu5D5NjdSTI0NBBp4vma7ZN1ARO3hPYrPz49ycTpgbejqmzad1E9C1DPthRh6f
         og0WPcmNDJ3+LcE+o/VXvkJZXCYwQLmCeklL3PnewT3i55T/NJGpsfAN89b6fDsoJV+R
         fKiw==
MIME-Version: 1.0
X-Received: by 10.180.73.146 with SMTP id l18mr19354136wiv.89.1427253133273;
 Tue, 24 Mar 2015 20:12:13 -0700 (PDT)
Received: by 10.28.62.131 with HTTP; Tue, 24 Mar 2015 20:12:13 -0700 (PDT)
In-Reply-To: <CAAVeFuLF7tHgqXbX1MAikM67DwSu729eG0JcBiipSAG=AeBfOQ@mail.gmail.com>
References: <1426213595-28454-1-git-send-email-chenhc@lemote.com>
        <CAAVeFuLytDZwo-=Q3DSxS7jLWbr4Jgf8BsBr9VGptBBu4SzZZg@mail.gmail.com>
        <CAAhV-H5i+ysaJi1=6ftyY_82yGBZnCqpUmCV2ayMVMDFw0uWVQ@mail.gmail.com>
        <CAAVeFuLF7tHgqXbX1MAikM67DwSu729eG0JcBiipSAG=AeBfOQ@mail.gmail.com>
Date:   Wed, 25 Mar 2015 11:12:13 +0800
X-Google-Sender-Auth: XMBp4Lm41Xob4RDO6YCpC5X77i8
Message-ID: <CAAhV-H7Q1EkRZEjzBb+mPZO9YZUWa8hKBF90RakYW8cW1ka2Vw@mail.gmail.com>
Subject: Re: [PATCH V8 3/8] MIPS: Cleanup Loongson-2F's gpio driver
From:   Huacai Chen <chenhc@lemote.com>
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

It seems Ralf is very very busy, I have some bugfixing patches queued
for a long time and no response. Maybe Steven can give a ACK for this?

Huacai

On Wed, Mar 25, 2015 at 10:19 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Wed, Mar 25, 2015 at 10:15 AM, Huacai Chen <chenhc@lemote.com> wrote:
>> I think these three patches can go to GPIO tree, because it has no
>> relationship with others in this series.
>
> In that case we would need a ack from the MIPS maintainers to move the
> code into drivers/gpio/.
>
>>
>> Huacai
>>
>> On Mon, Mar 23, 2015 at 2:29 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
>>> On Fri, Mar 13, 2015 at 11:26 AM, Huacai Chen <chenhc@lemote.com> wrote:
>>>> This cleanup is prepare to move the driver to drivers/gpio. Custom
>>>> definitions of gpio_get_value()/gpio_set_value() are dropped.
>>>
>>> I suppose this is starting to look ok, at least patches 3, 4 and 5
>>> which are of interest for GPIO. I wonder which tree they should be
>>> merged through, MIPS or GPIO? Not seeing the rest of the series, I
>>> cannot make a suggestion.
>>>
>
