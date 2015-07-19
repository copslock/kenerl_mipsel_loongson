Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Jul 2015 02:22:32 +0200 (CEST)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35728 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011087AbbGSAW2N10XZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Jul 2015 02:22:28 +0200
Received: by wibxm9 with SMTP id xm9so64596918wib.0;
        Sat, 18 Jul 2015 17:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3NGujuSRVfooRqfOgZKnhWhlglcqkT6NrZMY8ULujqA=;
        b=plndmh/cJgLr5+CHo2Pqh8sWMu3ukEufExGHbnNzlXK3kde3cr4CV+raX23igTorCI
         lB9J4eVyJn4Z1ba0pi11KPp4dE6o1qEolWDhglUlwWuf11A5cw4mVwoYx51yEIhvUyed
         0XD2vs1FrQsvabbfBP0sJt4U3+9LBSyYU4ihzq87tI6Unm722GUiuUrwhFpvvkvTElsg
         yH6GWl5GDCiJzZsRmEThKq+9uztBdnby2H0oWbOR+QQN6pGsvWQy4aiHhYPmMqaE3lRa
         woLgUp6MPzNzsoSh2DBvT5ALHlTXcFA61ZhRSpN21NKKmLIqWVC0DEQ60qlbhZfawgYq
         R7tg==
X-Received: by 10.194.172.8 with SMTP id ay8mr41979763wjc.106.1437265342835;
 Sat, 18 Jul 2015 17:22:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.236.38 with HTTP; Sat, 18 Jul 2015 17:21:53 -0700 (PDT)
In-Reply-To: <1436540426-10021-5-git-send-email-paul.burton@imgtec.com>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com> <1436540426-10021-5-git-send-email-paul.burton@imgtec.com>
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Sat, 18 Jul 2015 20:21:53 -0400
X-Google-Sender-Auth: 4RDI3XboQowl75N78VoIJhkUfQE
Message-ID: <CAP=VYLr-DAi0TGuDiSZSeceKQ=Bb6Z9UXNZ=eBKVeP0g1SpOhg@mail.gmail.com>
Subject: Re: [PATCH 04/16] MIPS: use struct mips_abi offsets to save FP context
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <james.hogan@imgtec.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <paul.gortmaker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

On Fri, Jul 10, 2015 at 11:00 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> When saving FP state to struct sigcontext, make use of the offsets
> provided by struct mips_abi to obtain appropriate addresses for the
> sc_fpregs & sc_fpc_csr fields of the sigcontext. This is done only for
> the native struct sigcontext in this patch (ie. for O32 in CONFIG_32BIT
> kernels or for N64 in CONFIG_64BIT kernels) but is done in preparation
> for sharing this code with compat ABIs in further patches.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>  arch/mips/kernel/r4k_fpu.S       | 151 +++++++++++++++++++++------------------
>  arch/mips/kernel/signal-common.h |   6 ++
>  arch/mips/kernel/signal.c        |  85 +++++++++++++++-------
>  3 files changed, 145 insertions(+), 97 deletions(-)
>

 The current version of this in linux-next picked up a booger in transit.

$ git show 6775b4ea74d5922e5310b7b7a902a8fbe61a0c9d|diffstat
 arch/mips/kernel/r4k_fpu.S       |  151 ++++++++++++++++++++-------------------
 arch/mips/kernel/signal-common.h |    6 +
 arch/mips/kernel/signal.c        |   85 ++++++++++++++-------
 index.html                       |   16 ++++
 4 files changed, 161 insertions(+), 97 deletions(-)

Guessing it happened at Ralf's end.

Paul.
--
