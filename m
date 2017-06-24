Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 17:09:01 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:35838
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993901AbdFXPIxFcV7W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 17:08:53 +0200
Received: by mail-pf0-x243.google.com with SMTP id s66so11673020pfs.2;
        Sat, 24 Jun 2017 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=16E7wkPxU7ZP5kdFTxJFcC88q0K4sDxq6OIOk+zXe6w=;
        b=EHtY9aBXF7Z0sLX6FYXbOw0aEl2lSx+g7SpgaurTuAM+I0UmwTyI/CwB/YovI30sox
         6JCO0lpkLCaX+M/BKgL8kD0z4An7cBFZrAW3O/D1nX/FiGZ1WTUC6TjXzIM1CeZ1/WPj
         CxfMmX41qNGDv/XnZ5VavHxiG9KOx4p1BQWnfPN1lepaqrgHnFE4OaNxImYy4yjJ2faM
         yIR9cAweSnEzA6muYfZ+pIveBVIuo5Lx81WE49Qmp7173cNLMZxBOEO2pIQQSoUbN9yn
         1Bw8QMxWdso92f7HqiDlWOOUaNyVdhYn6EE25lQWBkI05fWTp+io/vn7EkygsT6Yr9Dg
         iYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=16E7wkPxU7ZP5kdFTxJFcC88q0K4sDxq6OIOk+zXe6w=;
        b=gLzRLUnTRToHk4GJokFzvUYQut1kPYrA9ep4/FrQgbM52SSeMIcSk9qbmEUy67J53t
         wzA+4DUGDnTHvXfmA0pemNuGNJgDukpztZzy4MRDeQbx87Tx+uOZ+Of6BM/tMYvy3SKC
         Fs6iMUJCvAfhLYh1COoYrhcx6PluBqcuv32z+UFS5sPn/80T2pDuRzL3ArOZY57yfhGf
         tTkCn78L7UJ2y6RsLVjuHyuzO1hygJYZkm0NhcSuAKwpd9V7LDbwnXMSiSzYLteORIbr
         V5UoJ3YcaYNPUs1jZpUcAXk7X8D7gOWAxHPslncHOOPPlDoA+jg8WDjI2DBDqliPE+ya
         B0Bg==
X-Gm-Message-State: AKS2vOx4AY4UkBtTieajAiFQ1W9Z6EOHRdT5qRMKkmtqxGbUxtonMUo8
        1LDrhEn+ry02Yg==
X-Received: by 10.99.97.146 with SMTP id v140mr13586994pgb.62.1498316926968;
        Sat, 24 Jun 2017 08:08:46 -0700 (PDT)
Received: from bigtime.twiddle.net (97-113-165-157.tukw.qwest.net. [97.113.165.157])
        by smtp.googlemail.com with ESMTPSA id w190sm20998096pgb.30.2017.06.24.08.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jun 2017 08:08:45 -0700 (PDT)
Subject: Re: [PATCH] pci: Add and use PCI_GENERIC_SETUP Kconfig entry
To:     Palmer Dabbelt <palmer@dabbelt.com>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, geert@linux-m68k.org,
        ralf@linux-mips.org, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, cmetcalf@mellanox.com, gxt@mprc.pku.edu.cn,
        bhelgaas@google.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-m68k@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        hch@infradead.org
References: <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
 <20170623220857.28774-1-palmer@dabbelt.com>
 <20170623220857.28774-2-palmer@dabbelt.com>
From:   Richard Henderson <rth@twiddle.net>
Message-ID: <60bd9a54-0220-5d52-8843-ea3a654020a6@twiddle.net>
Date:   Sat, 24 Jun 2017 08:08:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170623220857.28774-2-palmer@dabbelt.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rth7680@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@twiddle.net
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

On 06/23/2017 03:08 PM, Palmer Dabbelt wrote:
> We wanted to add RISC-V to the list of architectures that used the
> generic PCI setup-irq.o inside the Makefile and it was suggested that
> instead we define a Kconfig entry and use that.
> 
> I've done very minimal testing on this: I just checked to see that
> an aarch64 defconfig still build setup-irq.o with the patch applied.
> The intention is that this patch doesn't change the behavior of any
> build.
> 
> Signed-off-by: Palmer Dabbelt<palmer@dabbelt.com>
> Reviewed-by: James Hogan<james.hogan@imgtec.com>
> ---
>   arch/alpha/Kconfig     |  1 +

Acked-by: Richard Henderson <rth@twiddle.net>


r~
