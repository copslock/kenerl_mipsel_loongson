Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 01:57:57 +0200 (CEST)
Received: from mail-vk0-x242.google.com ([IPv6:2607:f8b0:400c:c05::242]:39800
        "EHLO mail-vk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994614AbeC0X5u6Xr22 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 01:57:50 +0200
Received: by mail-vk0-x242.google.com with SMTP id n124so387948vkd.6
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2018 16:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wFkkDx3cFYbP1YPKsvhztLJJm/CeWnrd+qNyVU5tAaM=;
        b=Z5w1zQwsp01KcK76BPtVMHxheh6LuINhiptq5OpBfUbmp51oPZpRbTdRklVC/Uh6Ne
         UUbVno7EzT9YVqZ81qBF+F4hffOkBEAZ0PC9XON2p8oF6SpAzoRXxJ/x5ChNH50ZSQAX
         CmraJy6Z7Nd7H//DnI+qsGMRYZ7+z3iiztRVN/pdPJQcMPZk8CLvaIZyrUq/m2AnZaS4
         3NZsRYPYtnk189UA3He5tnzuraLwuizSRJmuYoVbgkzW0H6rhjVNGub798XqNcCr0aoF
         CIQ6fPaS/D04FrTFTlgf94QvsZACFaIf886nAtycYyFdyyOfLOGqmdFV8YAINcrPwqc0
         +6oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wFkkDx3cFYbP1YPKsvhztLJJm/CeWnrd+qNyVU5tAaM=;
        b=ZBjYivxTF5d42jWlIatjnoNDDmbRXk4nLnPk86/aR2jvafpcW2LDc35bxEJRRSvN0Y
         a/MqLSLtOGfBW+dm2XaQRIcEsjpmz4T5V6MqNd91OkdN6gfV2scSP8jb5v2x753qHelO
         fpNN2GG7L00doQKJYRkU35hAqTJplNl+sDmBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wFkkDx3cFYbP1YPKsvhztLJJm/CeWnrd+qNyVU5tAaM=;
        b=axzcpziO99TlCtgSWL0WNi1ujdLkiND9wnYPKb4JOPe2JC4o+ofUFZ2aOfDDk2vtJZ
         8GmvKw075dSzaG9UE90WEgRn04rGzla3UiQa0mec+ZotNGRlIGFwDubdBhsQL6Qc7PgP
         wKQsr6ebhJgkxx66BgyJ+9WvMY2PPL5WFhh0udNFJWI4ojarPRH0usMsBwOP1lzwbWjF
         +bMdV+BlEWUw7EGHO4C7Il44NIIM9oGLCiqsIe3xwHHX6leUzUOxjWRKaJw+TMEhVo0/
         NUXXbMvQMerXFLgcbT872+is/NbinAtLoIiFdINlgkopDbayC601kOYuo+WAlhp0j+Z0
         2zzg==
X-Gm-Message-State: AElRT7EuveJxsO9s+XsfJawaSvvypaVwr3BZUAQ9WWg1o9SbEhWYZsYY
        fXtPbsHpJAX9F5A/jMmwaoJ3N+tiAJgUCL8N66i28Q==
X-Google-Smtp-Source: AIpwx4/Kz2w+gTM7wgMR3ChYa+r1AFRmm/lgqI+CJRssMZZMJAeyJtwBiHsKSoBIvuofeLnJlKJZ4hmRGc/ZytVfisU=
X-Received: by 10.31.47.147 with SMTP id v141mr959582vkv.121.1522195064223;
 Tue, 27 Mar 2018 16:57:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.129.9 with HTTP; Tue, 27 Mar 2018 16:57:43 -0700 (PDT)
In-Reply-To: <20180327234904.GA27734@bombadil.infradead.org>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org> <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz> <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz> <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com> <20180327234904.GA27734@bombadil.infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Mar 2018 16:57:43 -0700
X-Google-Sender-Auth: Zq1XJoS4_RCwnw_1jWSUriwcN-I
Message-ID: <CAGXu5jLMssDHQORP_BWjmWa+VZ_eqkF_rZc1J6mHYCNbT9cG5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ilya Smith <blackzert@gmail.com>, Michal Hocko <mhocko@kernel.org>,
        Richard Henderson <rth@twiddle.net>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        nyc@holomorphy.com, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <steve.capper@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Rik van Riel <riel@redhat.com>, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Tue, Mar 27, 2018 at 4:49 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Mar 27, 2018 at 03:53:53PM -0700, Kees Cook wrote:
>> I agree: pushing this off to libc leaves a lot of things unprotected.
>> I think this should live in the kernel. The question I have is about
>> making it maintainable/readable/etc.
>>
>> The state-of-the-art for ASLR is moving to finer granularity (over
>> just base-address offset), so I'd really like to see this supported in
>> the kernel. We'll be getting there for other things in the future, and
>> I'd like to have a working production example for researchers to
>> study, etc.
>
> One thing we need is to limit the fragmentation of this approach.
> Even on 64-bit systems, we can easily get into a situation where there isn't
> space to map a contiguous terabyte.

FWIW, I wouldn't expect normal systems to use this. I am curious about
fragmentation vs entropy though. Are workloads with a mis of lots of
tiny allocations and TB-allocations? AIUI, glibc uses larger mmap()
regions for handling tiny mallocs().

-Kees

-- 
Kees Cook
Pixel Security
