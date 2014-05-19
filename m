Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2014 17:36:56 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:55788 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824847AbaESPgu6AMzW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 May 2014 17:36:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 709B5234B3
        for <linux-mips@linux-mips.org>; Mon, 19 May 2014 23:16:00 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HLrPsAFQXs2J for <linux-mips@linux-mips.org>;
        Mon, 19 May 2014 23:15:42 +0800 (CST)
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com [209.85.215.42])
        (Authenticated sender: chenj@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPSA id CAE7421D30
        for <linux-mips@linux-mips.org>; Mon, 19 May 2014 23:15:40 +0800 (CST)
Received: by mail-la0-f42.google.com with SMTP id el20so4225417lab.1
        for <linux-mips@linux-mips.org>; Mon, 19 May 2014 08:15:35 -0700 (PDT)
X-Received: by 10.112.143.99 with SMTP id sd3mr25821767lbb.11.1400512535359;
 Mon, 19 May 2014 08:15:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.176.137 with HTTP; Mon, 19 May 2014 08:15:15 -0700 (PDT)
In-Reply-To: <20140519100244.GL63315@pburton-linux.le.imgtec.org>
References: <1400401410-32600-1-git-send-email-chenj@lemote.com>
 <CAAhV-H6zvhUvjoQiG9-e5HHGBkbLJvN_LkbEZWEzfjJEmrmLgg@mail.gmail.com> <20140519100244.GL63315@pburton-linux.le.imgtec.org>
From:   Chen Jie <chenj@lemote.com>
Date:   Mon, 19 May 2014 23:15:15 +0800
Message-ID: <CAGXxSxWD2ryrv0JHnOUpDkjXGGKLk=5=RYH_aEXsq9kCu40LfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?UTF-8?B?546L6ZSQ?= <wangr@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

2014-05-19 18:02 GMT+08:00 Paul Burton <paul.burton@imgtec.com>:
> On Sun, May 18, 2014 at 10:39:20PM +0800, Huacai Chen wrote:
>> Due to Wang Rui's tests, Loongson-3's EI/DI instructions don't have
>> correct behaviors, its Status.FR is also different with MIPS64R2. So,
>> I don't want to select CPU_MIPS64_R2.
>
> Out of curiosity, how do ei & di misbehave?
In our test, it may cause machine stall if use ei&di in kernel,
especially in smp case.
