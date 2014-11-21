Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2014 16:28:47 +0100 (CET)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:46669 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006529AbaKUP2pvYOA0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Nov 2014 16:28:45 +0100
Received: by mail-ie0-f178.google.com with SMTP id tp5so5141765ieb.9
        for <multiple recipients>; Fri, 21 Nov 2014 07:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ReJ9Yxi/C9VvgFAmnrXBCyMTgMTOxT0CYNoYHiDD1m0=;
        b=Ot7GTL+jlrjRI53BaH6bF8lrRTewPI8V6Jp1GYgxtlvRJc/JQO4XhOJ807gYrKkqBc
         cMcsNCCniT0zCB9fHU6gfJmunanz0yFgjeE/xy3/tzOQa9PlPWelS6KSGByja9UIgDP5
         GV9wNB6RzzDY/zcPp5uIlcLrCirlUtuqYKIqlEc2luiZW57ccjVcsBbSwpIcd54URdzo
         9CwtN4zukJmBb6fcTwkXaX7ZN5X8GhjuhdMO7JzggjrRRBwWXYznuL3/lB8J7UxGXGKN
         Jqsd6UYjnV2iyzvtf7PNkFiKmLBJ2MA5Wm3s6u5tyXsIXxnhVMdcRZI9VjoPMnRokfgd
         lRTw==
X-Received: by 10.50.39.67 with SMTP id n3mr16067219igk.43.1416583719920; Fri,
 21 Nov 2014 07:28:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.246.168 with HTTP; Fri, 21 Nov 2014 07:28:19 -0800 (PST)
In-Reply-To: <tencent_15D766A360D879F4553C1872@qq.com>
References: <1415891560-8915-1-git-send-email-chenhc@lemote.com>
 <CAAVeFuKYgXhV_372FBQnArEFT4xEVB73P+yurJ9mF0CkKCx7eQ@mail.gmail.com>
 <CAAVeFuJoo3X9aNYdrn5TJ-PjTzvFuEm5QTPmKYMy9NyWFy1_WA@mail.gmail.com>
 <20141119101157.GB7213@linux-mips.org> <tencent_15D766A360D879F4553C1872@qq.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Sat, 22 Nov 2014 00:28:19 +0900
Message-ID: <CAAVeFu+bHZdDgqWGg-dKhGkvV81_5JA=O-whqSgpN=6T8fpqRA@mail.gmail.com>
Subject: Re: [PATCH V4 2/6] MIPS: Move Loongson GPIO driver to drivers/gpio
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
X-archive-position: 44343
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

On Wed, Nov 19, 2014 at 11:25 PM, 陈华才 <chenhc@lemote.com> wrote:
> Hi, Ralf and Alexandre,
>
> So, I need three patches: clean up, move to drivers/gpio, and improve it to support Loonson-3A/3B?

Exactly. Before accepting a new driver in drivers/gpio we would like
to make sure it is up-to-date with respect to the current GPIO drivers
practices.

Thanks,
Alex.
