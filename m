Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 00:32:59 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:37567 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993869AbdAJXcxHuJg7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jan 2017 00:32:53 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id da3231dc;
        Tue, 10 Jan 2017 23:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ldXK7MO5Xl7Ewp1fOl60Z6GvN/o=; b=2WJBvB
        BSNOtE1As/osWMZhecmqXL1dL+zt1dKt+jWFN9mHTvOUxa4W3FiiYfcPPWb32NVg
        aA4F3IkrmqfhYFM92q0s7lTOaELRJjvfQkSXAxBc1prB2uOaFTCm+Px9SlrIBiF+
        fYNsBnAuBTGwtHztXp0MIMhvZxFExA+8JBCJa4eWLdjN0VfEYzwopPSnSCSSJN3g
        nAY+L+Gx8xhAtBF2b23kryY48PGuLteETMd0fl6gpBZGaFbie0kRR0VEqVs0w+Ku
        NIkeKfUuNtZbVurSay2AA3yP8MlzA2FFD9ViEe+7h2zpbSYqLTb9IvIrYmGP69zD
        ibrS25a/j9SmydzA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c96586d4 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 10 Jan 2017 23:22:52 +0000 (UTC)
Received: by mail-oi0-f43.google.com with SMTP id w204so68871666oiw.0;
        Tue, 10 Jan 2017 15:32:39 -0800 (PST)
X-Gm-Message-State: AIkVDXJmJo+BkagN5cq206AIwlO04mDq0aqGYaipYUPYm9jCxx0JUaYfSRaS02gER+ZpedqKK/x+ogowUuOY1A==
X-Received: by 10.157.12.217 with SMTP id o25mr2584344otd.94.1484091158901;
 Tue, 10 Jan 2017 15:32:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.14.167 with HTTP; Tue, 10 Jan 2017 15:32:38 -0800 (PST)
In-Reply-To: <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com> <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 11 Jan 2017 00:32:38 +0100
X-Gmail-Original-Message-ID: <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com>
Message-ID: <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] MIPS: Add per-cpu IRQ stack
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56252
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

Was this ever picked up for 4.10 or 4.11?
