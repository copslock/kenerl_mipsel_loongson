Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 11:29:07 +0200 (CEST)
Received: from mail-vn0-f49.google.com ([209.85.216.49]:34393 "EHLO
        mail-vn0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011719AbbD1J3EhxGwZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 11:29:04 +0200
Received: by vnbf190 with SMTP id f190so15351357vnb.1
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GBiLpQJQ3OfTJ9xKD/9f6GAs1LondpZwdepN4b/JZJc=;
        b=EuQ+8zh2/uXCO/5+0fceNZcAPardAOWbpLEMYH50ttTKT3OQCmFWVSPAvTz8xDStR2
         7AgFxQDkcRnFTsfyPKZqydF6O2BCzX3O9B+E4hMv6u5VVQ2u0eqhZxIfNjYhI8u1Xe5k
         AwwkCV29Bu3918DR8OOIRZaeo6lAKrqB9RV+nTZMqLjry2OexD4FnpSuFyF+e0Ans0GV
         B9ZUfJLicG+1pVoG2MVmWG/b+G6DIwMGiO21lIzyMDBEzIQr4f9qc//FNnTv2ilBnOdw
         m/GoDQNEd7gBOgbM2SNfpAdFFeLOGwGRvIb6KXdGhmr1SxAN7r0PrGU402VoP/Q/EL+C
         ElbQ==
X-Received: by 10.52.26.229 with SMTP id o5mr1212612vdg.27.1430213339229; Tue,
 28 Apr 2015 02:28:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.4.73 with HTTP; Tue, 28 Apr 2015 02:28:38 -0700 (PDT)
In-Reply-To: <1430174880-27958-7-git-send-email-paul.gortmaker@windriver.com>
References: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com> <1430174880-27958-7-git-send-email-paul.gortmaker@windriver.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 28 Apr 2015 12:28:38 +0300
Message-ID: <CAHNKnsQkVQh-JNf8LKF+ain+B3xF-xdCTZ39wD6JoA+W6p322Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] mips/ath25: remove legacy __cpuinit section that
 crept in
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2015-04-28 1:47 GMT+03:00 Paul Gortmaker <paul.gortmaker@windriver.com>:
> We removed __cpuinit support (leaving no-op stubs) quite some time ago.
> However this one crept back in as of commit 43cc739fd98b8c517ad45756d869f
> ("MIPS: ath25: add common parts")
>
> Since we want to clobber the stubs soon, get this removed now.
>
> Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Looks like I missed that this macro is scheduled for removing.

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

-- 
Sergey
