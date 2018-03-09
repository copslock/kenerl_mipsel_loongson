Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:47:38 +0100 (CET)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:55140
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994811AbeCIPrboWf0l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:47:31 +0100
Received: by mail-it0-x243.google.com with SMTP id c11so3223838ith.4
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jAAksnYYkMODsnsZbowE4/VFrct/KsJsppH3N6IgE5E=;
        b=UtibAzSDPg3Hg5hBk8M0mhG7Kp0G649HLc8j+63ikcwLMj5EOHI7aNDybftq6HDMym
         gPQudQDqqs41i1jkCgFzTYKkSFoWaA2CBCjEmjYX5r8nrtc4JO/EBXHAFvnecUELL26C
         /pt8P4whDL2PTLjzSinEq6AdlsXD43HpG74a/9/2O6rw3TEQqUH4Xem3NgrBPPBI0Jv7
         cRaaoLmGD1GhQMByIRcJLC4vCoqiByih0Xb9YxSNbn3LHn1Z32Gpr76mDgc2dCk3ARR5
         Jq3vRL2C5VHUX4c2xtptsue0bMshqLG3PSz+IhNCcBE/cjUhM1h3eRyWU3lSPm/YbwOm
         fMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jAAksnYYkMODsnsZbowE4/VFrct/KsJsppH3N6IgE5E=;
        b=ny2FtbDOrfLNiYd7yvp00cXeukNr92ooI1pjsxbcVnm85EosloApQBK1Np0NPi1FeA
         J8hj6f9VXml2UGy0/tBjutP917PyE3pYMOU8mDLwFYU/3/6MlZsMxcCkimqW/wOyvm5R
         TRxYPX9m6saSm3BpdSaGX75FYb41ETDqXBK+JMmlsOaP/R4jUG9Bri8WhJjOgJRotF7y
         aRZf40uDbSMQFlnfNcZQlJYe9MvqjFRnsMVVz0p01Dfe2GMeGU0bU/kqS937AlLwxghu
         BMyP/y/U0MGx4IvrPdrdZS11YVIu6vqbfWIFIagJelwdL+rpmZTmF02v3lg6152iMIkd
         yK1A==
X-Gm-Message-State: AElRT7Hk0yBAKO/x0fwT8VhbLPp+pY2XCuW/F54IFlzW605+MN21Iv3u
        Dm3WtPofwHf+qjYaXMRNv50ks1bbfdS8osnRga5NUQ==
X-Google-Smtp-Source: AG47ELsF7lorhRvuFkmJ5gTFIQ+mijzHzzmqoCjPv2uK8Rd/dB8Y4qjhePOvFPSh69W8VA48c0fknemZtvTJgO2GVa4=
X-Received: by 2002:a24:6c3:: with SMTP id 186-v6mr4327971itv.44.1520610443976;
 Fri, 09 Mar 2018 07:47:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.102.68 with HTTP; Fri, 9 Mar 2018 07:47:23 -0800 (PST)
In-Reply-To: <b320ff92-43ae-a479-35aa-4257b9c5430e@arm.com>
References: <cover.1520600533.git.andreyknvl@google.com> <89b4bb181a0622d2c581699bb3814fc041078d04.1520600533.git.andreyknvl@google.com>
 <b320ff92-43ae-a479-35aa-4257b9c5430e@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 9 Mar 2018 16:47:23 +0100
Message-ID: <CAAeHK+y=_imh4uNSAg_vj3DLAeDLcVP3a4f79dNMW=Ot5oLiZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] arch: add untagged_addr definition for other arches
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andreyknvl@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreyknvl@google.com
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

On Fri, Mar 9, 2018 at 3:16 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 09/03/18 14:02, Andrey Konovalov wrote:
>>
>> To allow arm64 syscalls accept tagged pointers from userspace, we must
>> untag them when they are passed to the kernel. Since untagging is done in
>> generic parts of the kernel (like the mm subsystem), the untagged_addr
>> macro should be defined for all architectures.
>
>
> Would it not suffice to have an "#ifndef untagged_addr..." fallback in
> linux/uaccess.h?
>

Hi Robin!

This approach is much better, I'll try it. This will also solve the
merge issues that Arnd mentioned.

Thanks!
