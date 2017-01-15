Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2017 19:07:23 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:34923 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991346AbdAOSHQ3DolH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 Jan 2017 19:07:16 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 653204c1;
        Sun, 15 Jan 2017 17:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=DzbUH49ei9VmL1kN+Dxg9bJ4LJM=; b=Bw44u3
        WaNkfrExy+ElfOs2MNCL+wKmRmjKEzyOu63dz1vh7zQeOl1j/7vWCOfIp83uurR0
        cLcyacC8t28ocKH8dKk6mVCSIC4dbuZm/lZaykvn0tzZwOgIrsYgw8uc4V6DLEFK
        j3xrp4x0dFlp1n8Kt6Ny2btpgRFxhv/FB9aZXnDTJyU+soPls2KqJMSvfexVBL5Y
        214/Rsa8TTl0vr8i+Pf/ElzuECD+eSD04/coCjJfomsmg6gZOWZF7yZLilfVC7yl
        bh7J5fOE/z1OTtl7PPzivJpf/AzR1EBn6ZlHC/+Y9Q9fCaFl6rKuCJ8cUhfmoHLo
        4b/lEBJFN+oL/n2A==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fabc018e (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 15 Jan 2017 17:56:41 +0000 (UTC)
Received: by mail-ot0-f172.google.com with SMTP id f9so32554161otd.1;
        Sun, 15 Jan 2017 10:07:05 -0800 (PST)
X-Gm-Message-State: AIkVDXKOwdFu7ukWRor4dQRJQTcanJwR71bmfybJj0KSGi/VFxm9KDfyM73wFrUWqP3U7uQerri2kBmGmZ0G2w==
X-Received: by 10.157.12.217 with SMTP id o25mr13176560otd.94.1484503624152;
 Sun, 15 Jan 2017 10:07:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.14.167 with HTTP; Sun, 15 Jan 2017 10:07:03 -0800 (PST)
In-Reply-To: <20170115143019.GA24619@kroah.com>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
 <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
 <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com>
 <20170111012032.GE31072@linux-mips.org> <CAHmME9qXeO=qFvWXenVO6gVAftk1M2vdQt7nwABRDqvDcV3dPg@mail.gmail.com>
 <20170113094939.GI10569@jhogan-linux.le.imgtec.org> <CAHmME9oG65MFwT=5m8uaeLw8uf5kS8nC9oBBLf9_v11bTsiAsg@mail.gmail.com>
 <20170115134848.GA27658@kroah.com> <CAHmME9q04CwkmorTJaGTWKS9gvJpOpyp4FGuhySKHC7CySDWHw@mail.gmail.com>
 <CAHmME9oQ-HYQktU4JDZbnvj58WW8EE_40u8Nq-PxeJWHcvXmcQ@mail.gmail.com> <20170115143019.GA24619@kroah.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 15 Jan 2017 19:07:03 +0100
X-Gmail-Original-Message-ID: <CAHmME9o9smxMjoZj8jAxHrffRFC4As0DxHHOecT+N+DSG_MmtA@mail.gmail.com>
Message-ID: <CAHmME9o9smxMjoZj8jAxHrffRFC4As0DxHHOecT+N+DSG_MmtA@mail.gmail.com>
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
X-archive-position: 56316
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

FYI, LEDE/OpenWRT is shipping this patchset now:
https://github.com/lede-project/source/commit/1708644f1915eb7587a904d81da0ef0b559d1567
