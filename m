Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 21:07:24 +0100 (CET)
Received: from mail-vk0-x22e.google.com ([IPv6:2607:f8b0:400c:c05::22e]:33509
        "EHLO mail-vk0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992126AbdCOUHR2kH1L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 21:07:17 +0100
Received: by mail-vk0-x22e.google.com with SMTP id d188so13785644vka.0
        for <linux-mips@linux-mips.org>; Wed, 15 Mar 2017 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=2UKWA2rmQhfxiMzJexCcGtvi4d4H5S7FeZG3+uRdr2k=;
        b=vHBkY5GHXbRMmLwNXFh+pL35zIydrB3gGS39Fy5VoB1tqKw4TVnHGatcquD0h69/nE
         CkxTNpFZdDOM95skCnxVqy7HJ4yzqQsv0C8BlLBeZ3Z3WvOs7gf0jm7TT+JnrfC6DKF5
         U0JZd/9zRfFodbxg3hzApV8e00jePs5+Su/Njc1FsJpp1YY/AO73KmTAgLHSQ1kqR+Tk
         l2Xd5OcEq6GAIKlnIqWSI1Uj3UdWg2kMrjMa27N8UR1NF/G/p3OOvWqa0eJ6sL8DTRg/
         DLIeZ/FSKck6aq8KjZJoXzKXkRCjEuQvGozehV5JdJYh4DkjrhDaFhSc0XZmoXY/u0A7
         MMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=2UKWA2rmQhfxiMzJexCcGtvi4d4H5S7FeZG3+uRdr2k=;
        b=U36vEM2QOmaNmqYmEJ3Z0yag/uhu2LfKhh3cGkRIXWvFGhkVr/HoVtbmz7bHJSNl/s
         vLSNfhUph98qk13Wo6ef6NHWQLBzD39lZwUWd0UkcApKV8A7jraFtyoRaDsZH/pmaK0T
         imdg2nKCWGwVaU0H49QsTfmT6Igitbzy2GpYlid9aWw2QqTwJg4uv1/sFbq446RZDrXT
         UAgQ9VHFFwKEJ5tALysLQLyNRI0dISiSRnYH0N2I4CsHs+m9o0nTJsNrFtfa3xblu29C
         W610WSUOWORan4iF0ifaCvonnJj6rq/2Xl/H9XRylq/4I/SDFAcZtuROTRh9zPVwdr2C
         4a0A==
X-Gm-Message-State: AFeK/H3G9t8QD+rPxKzugNFIKPDN0YNJpDIexCWSyPIe9oXLUUDu63yYnodd12l4OvTSczK0oTCYq4iXffCTK/mX
X-Received: by 10.31.76.129 with SMTP id z123mr2078935vka.117.1489608431332;
 Wed, 15 Mar 2017 13:07:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.88.135 with HTTP; Wed, 15 Mar 2017 13:06:50 -0700 (PDT)
In-Reply-To: <20170315194447.scsf3fiwvf7z5gzc@arch-dev>
References: <CALCETrX5gv+zdhOYro4-u3wGWjVCab28DFHPSm5=BVG_hKxy3A@mail.gmail.com>
 <20170315194447.scsf3fiwvf7z5gzc@arch-dev>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 15 Mar 2017 13:06:50 -0700
Message-ID: <CALCETrXfGgxaLivhci0VL=wUaWAnBiUXC47P7TUaEuOYV_-X_g@mail.gmail.com>
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
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57307
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

On Wed, Mar 15, 2017 at 12:44 PM, Till Smejkal
<till.smejkal@googlemail.com> wrote:
> On Wed, 15 Mar 2017, Andy Lutomirski wrote:
>> > One advantage of VAS segments is that they can be globally queried by user programs
>> > which means that VAS segments can be shared by applications that not necessarily have
>> > to be related. If I am not mistaken, MAP_SHARED of pure in memory data will only work
>> > if the tasks that share the memory region are related (aka. have a common parent that
>> > initialized the shared mapping). Otherwise, the shared mapping have to be backed by a
>> > file.
>>
>> What's wrong with memfd_create()?
>>
>> > VAS segments on the other side allow sharing of pure in memory data by
>> > arbitrary related tasks without the need of a file. This becomes especially
>> > interesting if one combines VAS segments with non-volatile memory since one can keep
>> > data structures in the NVM and still be able to share them between multiple tasks.
>>
>> What's wrong with regular mmap?
>
> I never wanted to say that there is something wrong with regular mmap. We just
> figured that with VAS segments you could remove the need to mmap your shared data but
> instead can keep everything purely in memory.

memfd does that.

>
> Unfortunately, I am not at full speed with memfds. Is my understanding correct that
> if the last user of such a file descriptor closes it, the corresponding memory is
> freed? Accordingly, memfd cannot be used to keep data in memory while no program is
> currently using it, can it?

No, stop right here.  If you want to have a bunch of memory that
outlives the program that allocates it, use a filesystem (tmpfs,
hugetlbfs, ext4, whatever).  Don't create new persistent kernel
things.

> VAS segments on the other side would provide a functionality to
> achieve the same without the need of any mounted filesystem. However, I agree, that
> this is just a small advantage compared to what can already be achieved with the
> existing functionality provided by the Linux kernel.

I see this "small advantage" as "resource leak and security problem".

>> This sounds complicated and fragile.  What happens if a heuristically
>> shared region coincides with a region in the "first class address
>> space" being selected?
>
> If such a conflict happens, the task cannot use the first class address space and the
> corresponding system call will return an error. However, with the current available
> virtual address space size that programs can use, such conflicts are probably rare.

A bug that hits 1% of the time is often worse than one that hits 100%
of the time because debugging it is miserable.

--Andy
