Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 02:15:38 +0100 (CET)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33292 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009656AbbCYBPhk2J3O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 02:15:37 +0100
Received: by wgbcc7 with SMTP id cc7so9806978wgb.0;
        Tue, 24 Mar 2015 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uJZC8fRBaD7bOIbVTThiQUnn6Q3TU91IeWArN1kv/g8=;
        b=QYZrzJa2r5js/1B/mONi1FSn/SSbCY7InatSI7g9H4wLzQOqenLwg9mcuk51LfrpHz
         9o3Xp4mmM7806WOUK0E++SBxc+32u1wzpt/XOHz4j67O3wFubnfgAjuub81WCmi9Uzgy
         hOxXTdXLykRg4L500nWfVtpT7N7nvC0/6kw7K5VHbVp4GHAjDA32Z6Hr6g9cptvi4rcD
         afviqkJGyXNsvi/u6iuF4k75PJir0gcgIlFQd/1zFiQ/PzCCL6SEwABkbvNiEMMVWovB
         weNyZycd/Ocd4jywY2MFjBaYM2nnCAiQBvzovas7QLdppJRGMdFILuJqKymEdyCD8GcT
         qCng==
MIME-Version: 1.0
X-Received: by 10.180.98.137 with SMTP id ei9mr32245871wib.92.1427246133398;
 Tue, 24 Mar 2015 18:15:33 -0700 (PDT)
Received: by 10.28.62.131 with HTTP; Tue, 24 Mar 2015 18:15:33 -0700 (PDT)
In-Reply-To: <CAAVeFuLytDZwo-=Q3DSxS7jLWbr4Jgf8BsBr9VGptBBu4SzZZg@mail.gmail.com>
References: <1426213595-28454-1-git-send-email-chenhc@lemote.com>
        <CAAVeFuLytDZwo-=Q3DSxS7jLWbr4Jgf8BsBr9VGptBBu4SzZZg@mail.gmail.com>
Date:   Wed, 25 Mar 2015 09:15:33 +0800
X-Google-Sender-Auth: _HKxAEPQbKW_vORK1D4Bljq_fUs
Message-ID: <CAAhV-H5i+ysaJi1=6ftyY_82yGBZnCqpUmCV2ayMVMDFw0uWVQ@mail.gmail.com>
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
X-archive-position: 46510
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

I think these three patches can go to GPIO tree, because it has no
relationship with others in this series.

Huacai

On Mon, Mar 23, 2015 at 2:29 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Fri, Mar 13, 2015 at 11:26 AM, Huacai Chen <chenhc@lemote.com> wrote:
>> This cleanup is prepare to move the driver to drivers/gpio. Custom
>> definitions of gpio_get_value()/gpio_set_value() are dropped.
>
> I suppose this is starting to look ok, at least patches 3, 4 and 5
> which are of interest for GPIO. I wonder which tree they should be
> merged through, MIPS or GPIO? Not seeing the rest of the series, I
> cannot make a suggestion.
>
