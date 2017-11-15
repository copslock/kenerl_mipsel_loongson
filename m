Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2017 00:11:45 +0100 (CET)
Received: from mail-io0-x231.google.com ([IPv6:2607:f8b0:4001:c06::231]:42329
        "EHLO mail-io0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992297AbdKOXLicPuXZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Nov 2017 00:11:38 +0100
Received: by mail-io0-x231.google.com with SMTP id u42so3330063ioi.9;
        Wed, 15 Nov 2017 15:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wpWaR5he9LzJWXMqSdTupjXm3L53DO/MD7rRXhrb7I4=;
        b=XFwuXuNYaZyDLkUaGvGrtON2Y4Cm1MTbplbzSdHfePFf21z+YE1lv5NyAghzSWh1Xq
         7WKu3vb0DfAzjpI9AjlYNmWa+29IytXHECZno64Ql64heUkZrekXpN4cZrWu44rNnZxZ
         eqR/HV5on57YrzTLDytZ0YcYuCMGcOdtcIaW4hjinYftn//8KQWIaUorSbD0vvrkmZMt
         KDybNo/EUL0ytf3u6aNQEka2ChgK4+MtTxunrAA1GraNt1kuUCC5db3SxBsbvNPp9A8+
         88d5ohQhIi7Xw7WaJ8EG3gBUsQvBESrubmwGccbo4OVgINg/71b08sNp3BKrUGy6skzN
         F/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wpWaR5he9LzJWXMqSdTupjXm3L53DO/MD7rRXhrb7I4=;
        b=GH3EPWNUxpJ++/XeXaJ38xdCPSvVHXOAwd3yKdp4eWFOn9ki3OAwNi+H8wkh/NMSad
         3LN6DTSQc580GWT+zldTwDR30Kb/ef3PBVWdPV8YMAGr7o1KKWStWrzathd+i1xzBL+Y
         lx8ZYD+SUb3UoqLwUPdp7MSvV3B1Pd/ALS8Umtcfgmp3bQZLZkmTAibr5vodo6E4Lu3g
         RL2/a4jIDSYi9/FEQ6tYeqK0eS3Djvz1AKzvhKgOO6rlo1izwpepm5NjFZi3ImHxkkWc
         izCRbu8Bpc0T1FCTwjTr17hkLaVWvilj7A2rPBKvnyG1dBgjRIsUtHToCkYOrrlw35MW
         gr9w==
X-Gm-Message-State: AJaThX5MXT5K0gm6C2mSCHf1jKqXKYmNk9svBzmJNG9r2JqwAtAIf2AZ
        X0SVibaajQ9Rh+rig4EPzQL1wUcMs4ajiokXziY=
X-Google-Smtp-Source: AGs4zMYNkWA9vCwI7upmnqei7+u/0IZSnhgrEiurxPcxBSIvFliolaMxdmgHSY6VrD/NGk4X56APi8nTZVD4HbBt42A=
X-Received: by 10.107.69.14 with SMTP id s14mr21192913ioa.113.1510787492246;
 Wed, 15 Nov 2017 15:11:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.46.138 with HTTP; Wed, 15 Nov 2017 15:11:31 -0800 (PST)
In-Reply-To: <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
References: <20171110224259.15930-1-deepa.kernel@gmail.com> <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 15 Nov 2017 15:11:31 -0800
Message-ID: <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] posix_clocks: Prepare syscalls for 64 bit time_t conversion
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>, cohuck@redhat.com,
        David Miller <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, devel@driverdev.osuosl.org,
        gerald.schaefer@de.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Robert Richter <rric@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        sebott@linux.vnet.ibm.com, sparclinux <sparclinux@vger.kernel.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <deepa.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepa.kernel@gmail.com
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

> I had on concern about x32, maybe we should check
> for "COMPAT_USE_64BIT_TIME" before zeroing out the tv_nsec
> bits.

Thanks, I think you are right. I had the check conditional on
CONFIG_64BIT_TIME and then removed as I forgot why I added it. :)

> Regarding CONFIG_COMPAT_TIME/CONFIG_64BIT_TIME, would
> it help to just leave out that part for now and unconditionally
> define '__kernel_timespec' as 'timespec' until we are ready to
> convert the architectures?

Another approach would be to use separate configs:

1. To indicate 64 bit time_t syscall support. This will be dependent
on architectures as CONFIG_64BIT_TIME.
We can delete this once all architectures have provided support for this.

2. Another config (maybe COMPAT_32BIT_TIME?) to be introduced later,
which will compile out all syscalls/ features that use 32 bit time_t.
This can help build a y2038 safe kernel later.

Would this work for everyone?

-Deepa
