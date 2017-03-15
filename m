Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 17:52:10 +0100 (CET)
Received: from mail-vk0-x236.google.com ([IPv6:2607:f8b0:400c:c05::236]:33094
        "EHLO mail-vk0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991867AbdCOQwArCU-J convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 17:52:00 +0100
Received: by mail-vk0-x236.google.com with SMTP id d188so11835639vka.0
        for <linux-mips@linux-mips.org>; Wed, 15 Mar 2017 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LteANNsru7YLqURl3GZx8rYiHwwCxzbEI1x1MIRwrE4=;
        b=TjN2Q0A9qhZRlVkr4TRWkxpUqKt7qLQVchXLy/FPGCkn1v+U6FU/tz4/jNHFOVMunQ
         PgWtLlYe/+4pazbG2vcQJ3klj8yR3euEZhczmPDntqC2FXr5jGTS5jRSUZdVShK9v5gt
         VjIczqC3fRjR17LaVGAxiQ5BBwcvV5irEvPynUl1nVi3nMWC0DXeZLcD1DpyxdyNNn98
         NGdZRw78Nh/JgMPgplYznzaJhyCQAnxcU7zs2Ofy/seGYunqSpEbnncQBhNYyLTR/ysk
         t+g3cqw7sevuTYLrW3PUgiuNopU82aDBp7eiwa4mah/hKVBwXTSU3kuYng2H722lLLTD
         MUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=LteANNsru7YLqURl3GZx8rYiHwwCxzbEI1x1MIRwrE4=;
        b=o6wFp1svX633UZsRyn1IqEF4N4kivpc+7/Q9ANetwwR+EFBtWOWr974t9mjcR5YHim
         4Q69nxLjVt/+PCAYPuwdTsVqTZj+clVgWeRnj3hdj37ozc66aNw6Ds/XIKl5UeEvLAOh
         BmoWulUqu5a1HniL9ka88Y5uBu9UPFNp6CVF6h7QTvhkh1WUXqlUoVkTyPalJuPer+2b
         XFx9rZ+8uy6Si6aVoN0+y+SStINfx3zlKM2vPFcBEDzL0RJQLgTc3gBMOYEFgRvAOd6o
         5JAfBkR6hej9O18TVmb9PSem5EI2ajBQEX3DqmXLI5LlB35EGLVcd/iP/L46OWftWXor
         A+sg==
X-Gm-Message-State: AFeK/H3ytj942pQcztpvKMpuj57p7ZA5BM40XVL02IUpfU23eLIO3IHg6syTR0ve6mNqf4NRhQ3r1k2nJI/BGfER
X-Received: by 10.31.75.67 with SMTP id y64mr1290492vka.51.1489596712500; Wed,
 15 Mar 2017 09:51:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.88.135 with HTTP; Wed, 15 Mar 2017 09:51:31 -0700 (PDT)
In-Reply-To: <20170314161229.tl6hsmian2gdep47@arch-dev>
References: <CALCETrXKvNWv1OtoSo_HWf5ZHSvyGS1NsuQod6Zt+tEg3MT5Sg@mail.gmail.com>
 <20170314161229.tl6hsmian2gdep47@arch-dev>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 15 Mar 2017 09:51:31 -0700
Message-ID: <CALCETrX5gv+zdhOYro4-u3wGWjVCab28DFHPSm5=BVG_hKxy3A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
To:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Till Smejkal <till.smejkal@googlemail.com>,
        Richard Henderson <rth@twiddle.net>,
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
Content-Transfer-Encoding: 8BIT
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Tue, Mar 14, 2017 at 9:12 AM, Till Smejkal
<till.smejkal@googlemail.com> wrote:
> On Mon, 13 Mar 2017, Andy Lutomirski wrote:
>> On Mon, Mar 13, 2017 at 7:07 PM, Till Smejkal
>> <till.smejkal@googlemail.com> wrote:
>> > On Mon, 13 Mar 2017, Andy Lutomirski wrote:
>> >> This sounds rather complicated.  Getting TLB flushing right seems
>> >> tricky.  Why not just map the same thing into multiple mms?
>> >
>> > This is exactly what happens at the end. The memory region that is described by the
>> > VAS segment will be mapped in the ASes that use the segment.
>>
>> So why is this kernel feature better than just doing MAP_SHARED
>> manually in userspace?
>
> One advantage of VAS segments is that they can be globally queried by user programs
> which means that VAS segments can be shared by applications that not necessarily have
> to be related. If I am not mistaken, MAP_SHARED of pure in memory data will only work
> if the tasks that share the memory region are related (aka. have a common parent that
> initialized the shared mapping). Otherwise, the shared mapping have to be backed by a
> file.

What's wrong with memfd_create()?

> VAS segments on the other side allow sharing of pure in memory data by
> arbitrary related tasks without the need of a file. This becomes especially
> interesting if one combines VAS segments with non-volatile memory since one can keep
> data structures in the NVM and still be able to share them between multiple tasks.

What's wrong with regular mmap?

>
>> >> Ick.  Please don't do this.  Can we please keep an mm as just an mm
>> >> and not make it look magically different depending on which process
>> >> maps it?  If you need a trampoline (which you do, of course), just
>> >> write a trampoline in regular user code and map it manually.
>> >
>> > Did I understand you correctly that you are proposing that the switching thread
>> > should make sure by itself that its code, stack, … memory regions are properly setup
>> > in the new AS before/after switching into it? I think, this would make using first
>> > class virtual address spaces much more difficult for user applications to the extend
>> > that I am not even sure if they can be used at all. At the moment, switching into a
>> > VAS is a very simple operation for an application because the kernel will just simply
>> > do the right thing.
>>
>> Yes.  I think that having the same mm_struct look different from
>> different tasks is problematic.  Getting it right in the arch code is
>> going to be nasty.  The heuristics of what to share are also tough --
>> why would text + data + stack or whatever you're doing be adequate?
>> What if you're in a thread?  What if two tasks have their stacks in
>> the same place?
>
> The different ASes that a task now can have when it uses first class virtual address
> spaces are not realized in the kernel by using only one mm_struct per task that just
> looks differently but by using multiple mm_structs - one for each AS that the task
> can execute in. When a task attaches a first class virtual address space to itself to
> be able to use another AS, the kernel adds a temporary mm_struct to this task that
> contains the mappings of the first class virtual address space and the one shared
> with the task's original AS. If a thread now wants to switch into this attached first
> class virtual address space the kernel only changes the 'mm' and 'active_mm' pointers
> in the task_struct of the thread to the temporary mm_struct and performs the
> corresponding mm_switch operation. The original mm_struct of the thread will not be
> changed.
>
> Accordingly, I do not magically make mm_structs look differently depending on the
> task that uses it, but create temporary mm_structs that only contain mappings to the
> same memory regions.

This sounds complicated and fragile.  What happens if a heuristically
shared region coincides with a region in the "first class address
space" being selected?

I think the right solution is "you're a user program playing virtual
address games -- make sure you do it right".

--Andy
