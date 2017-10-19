Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 00:14:21 +0200 (CEST)
Received: from frisell.zx2c4.com ([192.95.5.64]:33965 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992675AbdJSWOKo8WaL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Oct 2017 00:14:10 +0200
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 359b5df5
        for <linux-mips@linux-mips.org>;
        Thu, 19 Oct 2017 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to
        :content-type; s=mail; bh=rCjuzVMJrX8tGBeymmnLZoXwpaM=; b=PykUk3
        oZ6y6sykVUm9jhhH9TZp6MK3cD4pRyjaudPRoYbKnij6++XwsatVi5tgUCspy4Ws
        181BoWF0R23mxeUCAuTLMWytNUUoBPuZExFkTzffaXIIBUpcUIxIVf2x2ZP7DULz
        DEmk12NPZsQtiR4Bc0yARBjHFaN3gHguPEJioQpczekB95Xdc4d8VFVyCqz+QIYI
        Kvm6RTODDxMlHE86TzodHJHbZh4I6Ly7VaAKkEHAZc4JfHafR7DqvX0+zQkTtFyo
        4gGszDLl+GSOHyxpMiYy8WTcn38404dgndc4ywcs83a850iEd6io745mKr4f8y3u
        1E5B/XRs7QUGtbpw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e99d571 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Thu, 19 Oct 2017 22:13:08 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id n82so17354492oig.3
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2017 15:14:02 -0700 (PDT)
X-Gm-Message-State: AMCzsaU1zQNdweixpe1Y08MGAAOmILEoXBhiGpto5PVvBJR4Ogt12anT
        RcsRxOn6k6higeO6Lfo3n0hb9HGwTAAY4rXiFUg=
X-Google-Smtp-Source: ABhQp+SyguT4N9Rf4E83k2grxQUfc3jH24tSCtGOutpkxMchboa+PjplWAKNRqdyDwHcf7SL6GgK25nKEOAbZV0pRaQ=
X-Received: by 10.202.212.195 with SMTP id l186mr1718312oig.174.1508451241940;
 Thu, 19 Oct 2017 15:14:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.41.205 with HTTP; Thu, 19 Oct 2017 15:14:01 -0700 (PDT)
In-Reply-To: <CAHmME9oCnYJV=1cvKsdWTuZeqLD5najE7j3dKS6sR9uj7+uZtA@mail.gmail.com>
References: <CAHmME9oCnYJV=1cvKsdWTuZeqLD5najE7j3dKS6sR9uj7+uZtA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 20 Oct 2017 00:14:01 +0200
X-Gmail-Original-Message-ID: <CAHmME9pLiSmc+ybL7+O+nRuOdpoW5aVQz4VWTfgotb2m9Nt7VQ@mail.gmail.com>
Message-ID: <CAHmME9pLiSmc+ybL7+O+nRuOdpoW5aVQz4VWTfgotb2m9Nt7VQ@mail.gmail.com>
Subject: Re: minimal kernel config for qemu/malta
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

I've actually found that adding CONFIG_CPS=y gets it a bit further in
the boot. And if I enable a bunch of serial drivers and not use
virtio, then I can get it working. However, I'm aiming for an
exclusively virtio platform. Yet virtio doesn't seem to appear on the
PCI bus. Hmm...
