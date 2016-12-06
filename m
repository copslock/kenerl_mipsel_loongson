Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2016 23:13:51 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:59872 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993381AbcLFWNlTd0bD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Dec 2016 23:13:41 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ad7bda4c;
        Tue, 6 Dec 2016 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Cjd2/OFVw9WdQ/7DL1/RddBOLoA=; b=ofnrtX
        RtebhIFlPu2VLbeQiS12p/Dg7DPaN1fCFe/hLZoBUtlvFAbo3vzJdQF6m57fz3wP
        Dq4zvPS0RJ5W5okBL9/HIW7+Z2ov8TDrHm0BzbACv5si+5eigmcJmAL44PtvkFQF
        rJCRyY2PNp2Ibl3KhwXplaKBRvgKfK4dcbszT4+HV8m8FptYH5EC4EXDZYmybFML
        tO5rVC8SUaskaKLjZxdZeUEeKsVFbFIHvlj8+j7rgctVKxaIDVgnCvqsT4jn6lLz
        fjwYzL/05ZLX+I7R7bMiRsAEl33WxUByQkhNYhifGrOXXUv8CjdesVbIQTSZXvNh
        xbx/I7XMPg1RF4bg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6f3f8093 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 6 Dec 2016 22:08:12 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id a197so144770296wmd.0;
        Tue, 06 Dec 2016 14:13:32 -0800 (PST)
X-Gm-Message-State: AKaTC019NF5phQta2DvWQ75ohGfwuovUvxRReT8YVho04mAXAA9QV8pkinEM9BCi+d0k+ZXgOgOhD4fFvhOexA==
X-Received: by 10.46.71.76 with SMTP id u73mr30443100lja.6.1481062410830; Tue,
 06 Dec 2016 14:13:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.215.12 with HTTP; Tue, 6 Dec 2016 14:13:30 -0800 (PST)
In-Reply-To: <1480685957-18809-2-git-send-email-matt.redfearn@imgtec.com>
References: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com> <1480685957-18809-2-git-send-email-matt.redfearn@imgtec.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 6 Dec 2016 23:13:30 +0100
X-Gmail-Original-Message-ID: <CAHmME9pFdLALj9sigunS7Uk+NqJi4GcoUGP+Tgpbku0v1ADk=w@mail.gmail.com>
Message-ID: <CAHmME9pFdLALj9sigunS7Uk+NqJi4GcoUGP+Tgpbku0v1ADk=w@mail.gmail.com>
Subject: Re: [PATCH 1/5] MIPS: Introduce irq_stack
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55950
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

On Fri, Dec 2, 2016 at 2:39 PM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> +void *irq_stack[NR_CPUS];

I'm curious why you implemented it this way rather than using
DEFINE_PER_CPU and the related percpu helper functions.
