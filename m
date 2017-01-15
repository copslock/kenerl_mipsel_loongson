Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2017 15:15:51 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:48226 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992036AbdAOOPoja6bF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 Jan 2017 15:15:44 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 849ea90c;
        Sun, 15 Jan 2017 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=E09HGUiFqU+fYj9j//ubKmpJjKQ=; b=0Pul0V
        oYahyyijL4EkCSDXyV7p242e7gyaXKtM9rGwSbyjH9RiYnYpHpTK8GD5w8J2lfOA
        7jZ3ukhFRj+8wUbcMKnSVt4RYpeil/DZBpIWfwNXJrgFDQ3HdO3z/K67LuVxyphw
        HU5TsgOEqsXJgMmUvhI9OT+ilwieWScRO57yzMgZ3VBLJqKAKohe7GAJk23tiJgF
        btoMDpSq5uHEAUHx1B302Tpa7wKmOFhGX63nzArWWIfBH7Qm+HFNTAtRcmuCFbEC
        bGzXNMoSe1XMP5lCFYamy3RvUXWSCvU4TqJcg9QqD3iIZT3CbdYPyIznB0eV3kvK
        OrK8JdWqlZisgI2Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 23d5fe0f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 15 Jan 2017 14:05:14 +0000 (UTC)
Received: by mail-oi0-f49.google.com with SMTP id u143so87628360oif.3;
        Sun, 15 Jan 2017 06:15:37 -0800 (PST)
X-Gm-Message-State: AIkVDXLh9q0DVp3dgoMLGJ4/BFemhS00EkpeCwdoLi1SnhLUdPNgfSesFQu/TekleX2lKSUfmSunhetMSr2Dhw==
X-Received: by 10.202.53.2 with SMTP id c2mr14793125oia.80.1484489736139; Sun,
 15 Jan 2017 06:15:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.14.167 with HTTP; Sun, 15 Jan 2017 06:15:35 -0800 (PST)
In-Reply-To: <CAHmME9q04CwkmorTJaGTWKS9gvJpOpyp4FGuhySKHC7CySDWHw@mail.gmail.com>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
 <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
 <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com>
 <20170111012032.GE31072@linux-mips.org> <CAHmME9qXeO=qFvWXenVO6gVAftk1M2vdQt7nwABRDqvDcV3dPg@mail.gmail.com>
 <20170113094939.GI10569@jhogan-linux.le.imgtec.org> <CAHmME9oG65MFwT=5m8uaeLw8uf5kS8nC9oBBLf9_v11bTsiAsg@mail.gmail.com>
 <20170115134848.GA27658@kroah.com> <CAHmME9q04CwkmorTJaGTWKS9gvJpOpyp4FGuhySKHC7CySDWHw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 15 Jan 2017 15:15:35 +0100
X-Gmail-Original-Message-ID: <CAHmME9oQ-HYQktU4JDZbnvj58WW8EE_40u8Nq-PxeJWHcvXmcQ@mail.gmail.com>
Message-ID: <CAHmME9oQ-HYQktU4JDZbnvj58WW8EE_40u8Nq-PxeJWHcvXmcQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] MIPS: Add per-cpu IRQ stack
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
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
X-archive-position: 56314
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

On Sun, Jan 15, 2017 at 3:11 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> According to Ralf, it's queued up for 4.11? Is that right?

It's in -next:

Part 1: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=fe8bd18ffea5327344d4ec2bf11f47951212abd0
Part 2: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=d42d8d106b0275b027c1e8992c42aecf933436ea
Part 3: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=510d86362a27577f5ee23f46cfb354ad49731e61
Part 4: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=dda45f701c9d7ad4ac0bb446e3a96f6df9a468d9
Part 5: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=3cc3434fd6307d06b53b98ce83e76bf9807689b9
