Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 13:58:33 +0200 (CEST)
Received: from [192.95.5.64] ([192.95.5.64]:45959 "EHLO frisell.zx2c4.com"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993878AbdDDL6YtEfYF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Apr 2017 13:58:24 +0200
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d49de20f;
        Tue, 4 Apr 2017 11:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=vTHK61w40CP+tzgFTR4d+Jqclhk=; b=dcfoiK
        O7VRhj1U7hdda6Li1guOFk/diPbAxWv2rapaGDSOZJ2KuHtjQmnlAAYjLzrMsCBp
        ZgCjcn0Qc+bPVAJEMltPtR/KNxPLVlE0FyO9YHgHf3x12HQnBKCXogST9UyUZRrF
        NhPDX7FwmowIUJIiEcnZ8JPyvAKGnOGjt26NMdOV/tarbwibv9CV1kFE7kOyuPdU
        hB+HSeVXowCNceaGik1bVCJTgyA1sHd5/5ZM0Ma2M+YYU0yhApwr5lQU0TKkF5BU
        J8LotrjEPwc2/SMFTmMWrcI78vUujukjpcPCNjP4KBREljF0OoHYL5gWKaARLTDO
        Pj1lcb/52PNZSfJw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7690ecee (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 4 Apr 2017 11:52:03 +0000 (UTC)
Received: by mail-oi0-f51.google.com with SMTP id b187so159580920oif.0;
        Tue, 04 Apr 2017 04:58:05 -0700 (PDT)
X-Gm-Message-State: AFeK/H1o7Jc4Y9aE7861VN/j3OFVB8HjErg6Pyy+hOjxYNK/NVaM0vw9tGiHpybw2MPomY9+m2h3wUJ1KjU+pQ==
X-Received: by 10.157.52.143 with SMTP id g15mr12685696otc.161.1491307085080;
 Tue, 04 Apr 2017 04:58:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.58.68 with HTTP; Tue, 4 Apr 2017 04:58:04 -0700 (PDT)
In-Reply-To: <1490107945-21553-1-git-send-email-matt.redfearn@imgtec.com>
References: <1490107945-21553-1-git-send-email-matt.redfearn@imgtec.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 4 Apr 2017 13:58:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9p_Yw7Xi2P=zs4snEM3vGo8OkgM8cddpOy69KssNHqsmA@mail.gmail.com>
Message-ID: <CAHmME9p_Yw7Xi2P=zs4snEM3vGo8OkgM8cddpOy69KssNHqsmA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: IRQ Stack: Unwind IRQ stack onto task stack
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57555
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

This indeed is useful. Out of curiosity, are other archs using a
similar technique? In anycase,

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
