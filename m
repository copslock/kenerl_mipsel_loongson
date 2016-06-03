Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 09:18:55 +0200 (CEST)
Received: from mail-io0-f195.google.com ([209.85.223.195]:33174 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033863AbcFCHSwp6yr0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 09:18:52 +0200
Received: by mail-io0-f195.google.com with SMTP id p194so9324666iod.0;
        Fri, 03 Jun 2016 00:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jIY200dkr0Im0Nsw6RsCa7Od3Dei8w4fvOA20nIr4O4=;
        b=PYp8TXLrVN4uifinjkSMkte/3Hjzt3AEC8ongcuiSyeBUTwGudO4IMxw1qlPHMV7f7
         fvbxNCw2V131NhXB6cNkPNte+tkh/SV2GNrhL4Fo4mIhGRsG5qC9Ma7QgBMBLxqUURH3
         1ftH9Us/EfFYUQUoEwKsTC44S7rja2/SuTKX10MD7FCvfbxG84aOMUjhGwbqpQG9qQQH
         qF6bHDeA/TpEXoP8IUZyxNGJGZnh92KbgBaTV8t9e+oPE3uwXGf8vqIle3kpHyNcpAQg
         ToffMrusv9xlVo6OqV7Td/xOv7nLwNFg1zAc+UJTwgnc7G7TLuyv9Ra8w7mjN7/UaPah
         6RxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jIY200dkr0Im0Nsw6RsCa7Od3Dei8w4fvOA20nIr4O4=;
        b=ld5oBG3tCKvi81egbXlGJ4lG9Ljq45s6deVWSkdgUb2GCjBU8HuwDfWDjhRezlGKxM
         5LqjovazQaT+YK15+dsbUtDdno6oXgIFoBedGd4HvSXF0m+2ayy07FYrZCX1VaN64Khr
         KoR5uZbGpUmTDUfJdGGiepAvCJKRXuYEqlojWGcVNRCUKBuq1j0kJjeoduBmxHutvXAX
         MyOmLVOJ6tJms7OeNxFi9u1Xh5H7fp17rA9s9rbrjy90mvlpPvSyzBdPM6GyFB56pG79
         3ApGOh3zhF+zJwcuRVwyhnkGRWfrkaaHLN+rw3/qNvPmYmW/puqvwQ2wjEs3TzsQEI+W
         nFjg==
X-Gm-Message-State: ALyK8tKgCqPGFOqleB03v+QckxAqBOomVDy/hG1v3m6ffdmBwMg8cn7g7ViIwAQY9dTcmCHzxnA8YXh6I/whtQ==
X-Received: by 10.107.43.214 with SMTP id r205mr178678ior.81.1464938325613;
 Fri, 03 Jun 2016 00:18:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.33.135 with HTTP; Fri, 3 Jun 2016 00:18:44 -0700 (PDT)
In-Reply-To: <1464881987-13203-30-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com> <1464881987-13203-30-git-send-email-k.kozlowski@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 Jun 2016 09:18:44 +0200
X-Google-Sender-Auth: Vppcn6N8ye2iblggr44rVIFH_p4
Message-ID: <CAMuHMdXpMu6iuSYRJwyqP8mx_A9cAnsgkTh-8nU+JMpD4f2-SA@mail.gmail.com>
Subject: Re: [RFC v3 29/45] m68k: dma-mapping: Use unsigned long for dma_attrs
To:     Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Steven Miao <realmz6@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Geoff Levand <geoff@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Muli Ben-Yehuda <muli@il.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@linux.ie>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        xen-devel@lists.xenproject.org,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>,
        uclinux-h8-devel@lists.sourceforge.jp,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
        nios2-dev@lists.rocketboards.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>, discuss@x86-64.org,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Thu, Jun 2, 2016 at 5:39 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> Split out subsystem specific changes for easier reviews. This will be
> squashed with main commit.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Looks good.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
