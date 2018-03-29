Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 03:12:34 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:41439
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994614AbeC2BM2DvLNn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 03:12:28 +0200
Received: by mail-pf0-x243.google.com with SMTP id a11so2067434pff.8;
        Wed, 28 Mar 2018 18:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GAsEAuA/4wkkmLXuWBTfZ4TahUKEhDVaSCN3DyLMjvE=;
        b=LHfXHTp7MzKRPDSPZV2kYbx9kEXh85Q7liv+TLSGpWcJRHzbAGkOQ1rGp6+aAJw0Rp
         IG/zdWQhG1oyyXQG7Pc1+oKUW4kakhfDbLxX9jzzrLDE783il+ILPeB7tr9dJjjZeM4D
         3kj27mWYweHChqDNKerEu27J5Gle6OdWMpEeOvU8+WXE7BzXwiurBn5CxcTwV83iHhTT
         oFp03ZQo+rdCpl5sRgN5wAEZN2a6e3K9YNiBc5kTu+/iFs0lj+WXLH4qlDG8KE949mcI
         Ih8lSjGSe2OEh3HjNmJePj0MxtgdTExA9ydLDH1VduifGwEuACk1aGIgMSVquaa3iN1o
         yTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAsEAuA/4wkkmLXuWBTfZ4TahUKEhDVaSCN3DyLMjvE=;
        b=WrW5lVJk/oxIPwCWeedNxjoTE0DVr6rhd2IGygiB35IYp5gP9W2IntX3BekA3jh3F9
         519sVdXZYkQgPCQh3/pLf4aYZL82tVNB67M3HgFQ9wj19M2l6cXDIxmV4axHwaYRu/PR
         aRHYLW2zcuXzE26ZMDYo0npigLi+VjBGBHSsWZEEZwvf87rzfr55QTj3x7LKz0xX5K9H
         lzgCIJNDP36gjom6M8Vryhe1FvwpYnxFq9SIi4zj/GJorBVVNFr9YReGV74v1yAgvQXi
         DOjoqSMWJ+I9h03TS4dJJGiMCvn2LtzlRAkLpQdgdrUS9kmjaNWrdGlDX5HO6A3pzA9H
         x1cg==
X-Gm-Message-State: AElRT7EQrM/SbkmDal3PwMzILEQgx/ZYyOP20SnoWPzO5LmM2bJsvMFD
        eRamvThfkdX4TptRDMd2/3E=
X-Google-Smtp-Source: AIpwx48kiM9+mVxnOH2o0IX/MD4L9mQM3AoMsbZywd49Q/fHuYkETWQP9/yuofvEraKatP6oLMPEPw==
X-Received: by 10.99.160.67 with SMTP id u3mr3948473pgn.389.1522285941447;
        Wed, 28 Mar 2018 18:12:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k70sm8579678pga.72.2018.03.28.18.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 18:12:20 -0700 (PDT)
Date:   Thu, 29 Mar 2018 09:12:10 +0800
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
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
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Balbir Singh <bsingharora@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Landley <rob@landley.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Message-ID: <20180329011210.GA4275@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <richard.weiyang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard.weiyang@gmail.com
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

On Wed, Mar 28, 2018 at 09:55:07AM -0700, Kees Cook wrote:
>On Wed, Mar 28, 2018 at 8:26 AM, Shea Levy <shea@shealevy.com> wrote:
>> Now only those architectures that have custom initrd free requirements
>> need to define free_initrd_mem.
>>
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>
>Yay consolidation! :)
>
>> --- a/usr/Kconfig
>> +++ b/usr/Kconfig
>> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>>         default ".lzma" if RD_LZMA
>>         default ".bz2"  if RD_BZIP2
>>         default ""
>> +
>> +config HAVE_ARCH_FREE_INITRD_MEM
>> +       bool
>> +       default n
>
>If you keep the Kconfig, you can leave off "default n", and I'd
>suggest adding a help section just to describe what the per-arch
>responsibilities are when select-ing the config. (See
>HAVE_ARCH_SECCOMP_FILTER for an example.)
>

One question about this change.

The original code would "select" HAVE_ARCH_FREE_INITRD_MEM on those arch.
After this change, we need to manually "select" this?

>-Kees
>
>-- 
>Kees Cook
>Pixel Security

-- 
Wei Yang
Help you, Help me
