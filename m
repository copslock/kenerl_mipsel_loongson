Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Mar 2010 16:13:15 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.156]:55846 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491868Ab0CBPNM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Mar 2010 16:13:12 +0100
Received: by fg-out-1718.google.com with SMTP id d23so166329fga.6
        for <multiple recipients>; Tue, 02 Mar 2010 07:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=y6SA0qJy0uuBvYZMW5YE7cDsjIlO3VOpEV7Mo/tWzzM=;
        b=XMUemizOrxbN71ljOCr/tsmJML2wyNJuK07dZ4sammeqvchBu/7K1m4x7jdl8oC1U9
         i05oT0Hpe/lg7eatGgSmZ5o9obyemYG6KQrtFGC5Ocm1RztRlKvOtGDIV3kd/1UdMs8W
         6Is4+Y5LQyDin52Lx7/RfT4fDfJSYjyAAuek8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=PPQ0r/9CHIylOGUv7vbVV1Siz6rw8KKsLvTaNLwrLZQhVai7Zk/5yg/Lp1p1AEmyEm
         3QCTaFsXR56e0LGblfj5joYGZMmuVG4IGQTupJRAdnjJSfaZdzAkyW6NUHY8xuA6lemT
         X4eY1bqaOoZroXQIJOWFnsCucpDutspT+QXnY=
MIME-Version: 1.0
Received: by 10.87.65.9 with SMTP id s9mr9877496fgk.48.1267542791131; Tue, 02 
        Mar 2010 07:13:11 -0800 (PST)
In-Reply-To: <20100301023316.GB23086@linux-sh.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
         <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
         <20100301023316.GB23086@linux-sh.org>
Date:   Tue, 2 Mar 2010 16:13:11 +0100
X-Google-Sender-Auth: 718d2b274871f915
Message-ID: <9cdbb57f1003020713x4e897af9ka87e348bf782f380@mail.gmail.com>
Subject: Re: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     Paul Mundt <lethal@linux-sh.org>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

2010/3/1 Paul Mundt <lethal@linux-sh.org>:
Hi Paul,
   thanks for your reply.

> I'll apply the sh part by itself, and I suppose Ralf will do the same for
> MIPS. I'm a bit confused as to why these were lumped together when 65 out
> of 66 oneliner patches made no use of ad-hoc grouping.

After the experience with GregKH, I was looking for others maintainer
interested in code cleanup. So I sent some patches over random files.
If you care, I can checkpatch.pl all mips subtree and send you patches (if any).

Thanks a lot for your work,
Andrea
