Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2018 23:19:12 +0200 (CEST)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:33312
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994621AbeEGVTEWBvRQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 May 2018 23:19:04 +0200
Received: by mail-qk0-x243.google.com with SMTP id c70so23089321qkg.0;
        Mon, 07 May 2018 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=934J5myvKgY8hw1K2PJpRHALc09+msTVy00glGw4t3Y=;
        b=n20Hn1CRr1k8LzYOdztz9ALSsnH2mOuN3CA44NsbZTZ4bX3d1ad+4eOouUpoduyHcq
         OsxPOXfSJUlCkp0eMdKcxdi2tHSI9E/3NaQu0iTZDXw7JDRsEJbPdVWw4WgCDOv7KZ0U
         Y2hkq1ZE9a6X0O5Je4+7s3kNN/6zuv3Z7hCPb+FA1993SQclCKZxZSbP0d7+au7LA7oo
         Di/2xiT52nxmWqz0pmu3wBUhhNa6QvFBLHK8nDK9KB+CXeZLyR0gszmFtZvLHbWl1kvs
         K3+AvRLyz1CT2QG0/pC9lZnKhuy9iIxT254aq0hiwh0cNiK9ADWwY5BLv8TWifwA5I6q
         USZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=934J5myvKgY8hw1K2PJpRHALc09+msTVy00glGw4t3Y=;
        b=ZhNi0KMYYkqjaONxDnuBA7FlX+7DVx0Cddqj4i7WIMIjXMVGij+fSgkbTjf2WG0PE8
         Bqf4lHtOrlY95scwbOkODxdy+zrrubJE8gdgUPtjCDTcb0nI8w/O95EryeBecRZWV2a/
         UlCLTOsZYLv694hH7MNTCagqNM0BI4iqEXZp8740AIkLVSEVa946oS0QdOSjzHJmv95Q
         +b9vCNmJVI7rTp4LqoOfXpZCyakcnKHB/NjHeJPjML5YJt4+xxtNNN8jZ0Y7bTXTHOor
         TPrM8WStXa0vi5joYtubt2ckbgw2Ll3KKZtZoypIsszm3h9d0+PicJHp9TFyd8wod6JM
         Rpsg==
X-Gm-Message-State: ALQs6tBeok1s0lZ+PZm6KcPg6OrgdX1BVllNHCUtYmCn9rMN9R0mAm4e
        D7A0UWVqUp1QLafS0XrpRP8R2AtIwpA7C381WpQ=
X-Google-Smtp-Source: AB8JxZrGV5pczBd5e73Mh00vakGYNiBVCJwMFUQB63biHM9Pf/VDhqfwdKMorJEGOUAkZmGCjiVSBjLamS2j/VXAFTY=
X-Received: by 10.55.124.198 with SMTP id x189mr33659214qkc.224.1525727938100;
 Mon, 07 May 2018 14:18:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.3 with HTTP; Mon, 7 May 2018 14:18:57 -0700 (PDT)
In-Reply-To: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525682212.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525682212.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 May 2018 17:18:57 -0400
X-Google-Sender-Auth: HHC7zavDtcXp1cilpu5kVZLxnqM
Message-ID: <CAK8P3a3Wk+1Emz2g55vb7U7yPU=pPAQYg7ibwj7g4kGZWmmuKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] MIPS: Convert read_persistent_clock() to read_persistent_clock64()
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, chenhc@lemote.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, May 7, 2018 at 5:28 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> Since struct timespec is not y2038 safe on 32bit machines, this patch
> converts read_persistent_clock() to read_persistent_clock64() using
> struct timespec64, as well as converting mktime() to mktime64().
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
