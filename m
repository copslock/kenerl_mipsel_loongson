Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 01:58:48 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:55218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994627AbdCNA6lOZguc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 01:58:41 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id E07AC2047C
        for <linux-mips@linux-mips.org>; Tue, 14 Mar 2017 00:58:36 +0000 (UTC)
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com [209.85.217.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69AB2043C
        for <linux-mips@linux-mips.org>; Tue, 14 Mar 2017 00:58:33 +0000 (UTC)
Received: by mail-ua0-f181.google.com with SMTP id q7so146035941uaf.2
        for <linux-mips@linux-mips.org>; Mon, 13 Mar 2017 17:58:33 -0700 (PDT)
X-Gm-Message-State: AMke39lDUv3wDEcMCTkcIwrxGjtOznhmLK0Un2KuJFXgUIAyYilTRG1KnskinPRCLBkcKOxw+YfUWpDDlX2qDreu
X-Received: by 10.176.1.167 with SMTP id 36mr17478386ual.92.1489453101697;
 Mon, 13 Mar 2017 17:58:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.88.135 with HTTP; Mon, 13 Mar 2017 17:58:01 -0700 (PDT)
In-Reply-To: <20170313221415.9375-1-till.smejkal@gmail.com>
References: <20170313221415.9375-1-till.smejkal@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 Mar 2017 17:58:01 -0700
X-Gmail-Original-Message-ID: <CALCETrWe8uOi3m8qXUbMA4017+rxbi1C8hzZ0bwjVHmfdE4FnQ@mail.gmail.com>
Message-ID: <CALCETrWe8uOi3m8qXUbMA4017+rxbi1C8hzZ0bwjVHmfdE4FnQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
To:     Till Smejkal <till.smejkal@googlemail.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-metag@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        USB list <linux-usb@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <luto@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@kernel.org
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

On Mon, Mar 13, 2017 at 3:14 PM, Till Smejkal
<till.smejkal@googlemail.com> wrote:
> This patchset extends the kernel memory management subsystem with a new
> type of address spaces (called VAS) which can be created and destroyed
> independently of processes by a user in the system. During its lifetime
> such a VAS can be attached to processes by the user which allows a process
> to have multiple address spaces and thereby multiple, potentially
> different, views on the system's main memory. During its execution the
> threads belonging to the process are able to switch freely between the
> different attached VAS and the process' original AS enabling them to
> utilize the different available views on the memory.

Sounds like the old SKAS feature for UML.

> In addition to the concept of first class virtual address spaces, this
> patchset introduces yet another feature called VAS segments. VAS segments
> are memory regions which have a fixed size and position in the virtual
> address space and can be shared between multiple first class virtual
> address spaces. Such shareable memory regions are especially useful for
> in-memory pointer-based data structures or other pure in-memory data.

This sounds rather complicated.  Getting TLB flushing right seems
tricky.  Why not just map the same thing into multiple mms?

>
>             |     VAS     |  processes  |
>     -------------------------------------
>     switch  |       468ns |      1944ns |

The solution here is IMO to fix the scheduler.

Also, FWIW, I have patches (that need a little work) that will make
switch_mm() waaaay faster on x86.

> At the current state of the development, first class virtual address spaces
> have one limitation, that we haven't been able to solve so far. The feature
> allows, that different threads of the same process can execute in different
> AS at the same time. This is possible, because the VAS-switch operation
> only changes the active mm_struct for the task_struct of the calling
> thread. However, when a thread switches into a first class virtual address
> space, some parts of its original AS are duplicated into the new one to
> allow the thread to continue its execution at its current state.

Ick.  Please don't do this.  Can we please keep an mm as just an mm
and not make it look magically different depending on which process
maps it?  If you need a trampoline (which you do, of course), just
write a trampoline in regular user code and map it manually.

--Andy
