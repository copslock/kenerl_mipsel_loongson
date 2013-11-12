Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2013 19:30:31 +0100 (CET)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43974 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822311Ab3KLSa3OTbhD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Nov 2013 19:30:29 +0100
Received: by mail-pd0-f176.google.com with SMTP id r10so1906424pdi.7
        for <linux-mips@linux-mips.org>; Tue, 12 Nov 2013 10:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FEgzxxBifyjhQI+mZi24K/06rU0yrRTAysqZyiLmL0E=;
        b=xjGm8tNop5Wjm81TgUhAvwdjC5+eU4bdh9AlqGQ1RRgWvNsmUjiZV+paX9pO6cN0Jf
         oUWUlKFSOHT8RHNYw5UbbJy62y7xlaGxB68r/2wyQyvBvPvmSf7PmIXfaJw1n9maeH9q
         wRJR8TmD2agzmRWi49eWz+rAHgVwS8VXNtf/Yavvd1zsqr0IoYE6/38CNp0IV0SAM1Gr
         dyYqtptOutqxtmhLka7Q4gAuWYttw7RqbNQpGN3KNrFEQavEQIF2DhNNTu121nrsi2aa
         QcvTjyUTYcbOrqo6XaY0ht0+gDnwoYBijoQ7HDI5mQvO0THCRDE6xtNylmUNAGBC8Iet
         Kf1w==
X-Received: by 10.68.251.133 with SMTP id zk5mr36863053pbc.69.1384281022611;
 Tue, 12 Nov 2013 10:30:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.10.162 with HTTP; Tue, 12 Nov 2013 10:29:42 -0800 (PST)
In-Reply-To: <528246BA.10607@imgtec.com>
References: <528246BA.10607@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 12 Nov 2013 10:29:42 -0800
Message-ID: <CAGVrzcYV7f4zN23nSMOp3r9aiSme-mJPEz2OkyLUFDWKfWtGqw@mail.gmail.com>
Subject: Re: Release of Linux MTI-3.10-LTS kernel.
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     LMOL <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2013/11/12 Steven J. Hill <Steven.Hill@imgtec.com>:
> Imagination Technologies is pleased to announce the release of its 3.10 LTS
> (Long-Term Support) MIPS kernel. The changelog below is based off the stable
> Linux 3.10.14 release done by Greg Kroah-Hartman in commit
> 8c15abc94c737f9120d3d4a550abbcbb9be121f6 back on October 1st. The code
> repository is hosted at the Linux/MIPS project GIT:
>
> http://git.linux-mips.org/?p=linux-mti.git;a=summary
>
> We look forward to any comments or feedback.

Nice job! Do you have a rough idea of the delta between your LTS
kernel and the current status of mainline/pending submissions?

Thanks!
-- 
Florian
