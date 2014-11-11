Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 13:44:18 +0100 (CET)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:64849 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013386AbaKKMoM2bSU- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 13:44:12 +0100
Received: by mail-ig0-f180.google.com with SMTP id h3so900456igd.1
        for <multiple recipients>; Tue, 11 Nov 2014 04:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gDtRfq+dKHqvWt/ALrgi+cudX6+q8XvK405MmHxjDDM=;
        b=R16s28XFg5D9YzF0sNC2ydP0Hpm+G1QKG1jWDVTGRMGQlmKyGlLfKQP0SsRIubBovX
         7tKIAhhaOWalP1iGYkaUQ5+dpEfP64dHy/UtUR/j4Thj5qK7Fi8m4kF5ix8J9dpk2Rlz
         /WqfifioqUQYxvWnUpQ7+78WLEz4ifYiIeKMJukWWBqR6gyRXzcmkb8nrB8Tm5Z6T6wc
         h+1i39xoPJqEUcHv5LyAm5koISseLnQEm1wFjQJrNyMB1DkzPqoFYfaXcYjwPfaRA6lk
         vO7W9IxcycxH4rwNsHFZlwyjf3shKrzoao/RX7fyQ6GMKEH9HcfmPrVVzLzsR1DhjMn4
         T4mg==
MIME-Version: 1.0
X-Received: by 10.107.172.68 with SMTP id v65mr9763749ioe.60.1415709846600;
 Tue, 11 Nov 2014 04:44:06 -0800 (PST)
Received: by 10.64.176.211 with HTTP; Tue, 11 Nov 2014 04:44:06 -0800 (PST)
In-Reply-To: <20141111102332.GI27259@linux-mips.org>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
        <1415081610-25639-9-git-send-email-chenhc@lemote.com>
        <20141111102332.GI27259@linux-mips.org>
Date:   Tue, 11 Nov 2014 20:44:06 +0800
X-Google-Sender-Auth: oWG-2Q0iP0VfidBt2xNiMi-z4gw
Message-ID: <CAAhV-H48kzra2e75mSrkjVzLZXY9uyZtADWPOQRGDOHuWP6bQA@mail.gmail.com>
Subject: Re: [PATCH V2 08/12] MIPS: Loongson-3: Add CPU Hwmon platform driver
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43998
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

CPU temperature is always available, not depend on machine type, so I
make it be built unconditionally.

On Tue, Nov 11, 2014 at 6:23 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Nov 04, 2014 at 02:13:29PM +0800, Huacai Chen wrote:
>
> Does it make sense to force this driver unconditionally on everybody
> building a kernel for a LOONGSON3 CPU?  It is generally preferred to
> control drivers individually through a separate Kconfig symbol.
>
>   Ralf
>
