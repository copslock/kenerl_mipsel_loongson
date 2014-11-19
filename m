Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 09:11:59 +0100 (CET)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:57415 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013960AbaKSIL6C1YMf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 09:11:58 +0100
Received: by mail-ig0-f177.google.com with SMTP id uq10so537151igb.10
        for <multiple recipients>; Wed, 19 Nov 2014 00:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QFLwH1j5WFHFNLKZvZPEZkFHzb6kx+8XmCsSbv6qK08=;
        b=jAdiMjzOrgmaRZvg8UtR9PKMl7OjuSawIWHV5ZQi8WSCmzCX8Djw6jDqxxU/VY9iXK
         UykoON/RNc6x5xjQct2soofOCEG1Aif7qjkoltAwDOjD4+ZmOP/9QA380ej6TITsT/tS
         LOiT2Coy1Bq0Q95Z3ugekCg3BTjPOPK2fFWXEcnxHiRxJGHE778VT14ko+6W9LEM4VSj
         HXxaAV5TRmRrQ0JVCpU4iN2pAsSpR1UcbujmoadDPo6XDbZj4ca7zwYhdlfqCCX3hjIp
         oRFENC93My8z0d77wmrkBTnK/MVd5D0auEZPcJl0EOCblMonjbJXq0twIenMucwbU9oW
         Yv5g==
X-Received: by 10.107.166.141 with SMTP id p135mr43750815ioe.16.1416384712168;
 Wed, 19 Nov 2014 00:11:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.246.168 with HTTP; Wed, 19 Nov 2014 00:11:32 -0800 (PST)
In-Reply-To: <1415891560-8915-1-git-send-email-chenhc@lemote.com>
References: <1415891560-8915-1-git-send-email-chenhc@lemote.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Wed, 19 Nov 2014 17:11:32 +0900
Message-ID: <CAAVeFuKYgXhV_372FBQnArEFT4xEVB73P+yurJ9mF0CkKCx7eQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/6] MIPS: Move Loongson GPIO driver to drivers/gpio
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44282
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

On Fri, Nov 14, 2014 at 12:12 AM, Huacai Chen <chenhc@lemote.com> wrote:
> Move Loongson-2's GPIO driver to drivers/gpio and add Kconfig options.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Guess this should go through the GPIO tree once the platform
maintainers have acked this?
