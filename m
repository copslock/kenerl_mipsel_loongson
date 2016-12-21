Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2016 02:23:23 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:41205 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992703AbcLUBXNT6r2A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Dec 2016 02:23:13 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 40d38f5c;
        Wed, 21 Dec 2016 01:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Ik4Uf3iAfpA4cGQDDTzY3pCWo78=; b=lWyDao
        tCUdpToN7BU6foh2fgZvbHzSdCiz85VgAkgbf9vLC7BcLIvUzTVMpV0fK3bI4fnA
        Xs82me2Q4hn5bcARHJKIbSRVNb6u7spRxs1rqL0F+m2S00EHfoHdL7//fAHDyTut
        0gGn5qpeVLSrZg3qz874CKrd9h1aymvD55yRTjAZDeFXGsP3jHpooKqNG9KzpsCv
        j4Nlidjz+rO+ZI0SfnHpgXcWtSjrukAsFCpf8zoajD0BcssmoDFhCydXHxnr1vE3
        6dSw/DRZcYz0U3jM8MwnY/PIxJ3CBT+jusd+ePdDSOSFgnnpCl0LXnht1zc11oeS
        CcqZLAe2fg/HahVg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ed9dbfb4 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 21 Dec 2016 01:15:57 +0000 (UTC)
Received: by mail-oi0-x232.google.com with SMTP id v84so195553549oie.3;
        Tue, 20 Dec 2016 17:23:04 -0800 (PST)
X-Gm-Message-State: AIkVDXJuMgLYw3/DPdMEVFj+6vxa+Z4w8HI9lHK+nQDDPmthyUySYKTlHG81ZQL/BWBdA1012hVR5bBq8VuccA==
X-Received: by 10.202.4.214 with SMTP id 205mr1181381oie.113.1482283083363;
 Tue, 20 Dec 2016 17:18:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.97.7 with HTTP; Tue, 20 Dec 2016 17:18:02 -0800 (PST)
In-Reply-To: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 21 Dec 2016 02:18:02 +0100
X-Gmail-Original-Message-ID: <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
Message-ID: <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
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
X-archive-position: 56110
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

Hi Matt,

Thanks for the v3. For the whole series:

Acked-by: Jason A. Donenfeld <jason@zx2c4.com>

Jason
