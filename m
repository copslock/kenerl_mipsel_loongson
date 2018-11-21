Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 16:48:15 +0100 (CET)
Received: from mail-pl1-x643.google.com ([IPv6:2607:f8b0:4864:20::643]:40751
        "EHLO mail-pl1-x643.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeKUPrJv0no3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 16:47:09 +0100
Received: by mail-pl1-x643.google.com with SMTP id b22-v6so6067463pls.7
        for <linux-mips@linux-mips.org>; Wed, 21 Nov 2018 07:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=U/lY5CfdHLl3xwIXaQIRba/GPl3Jxhihr4NwbiVFjPo=;
        b=OwVpQ43CSWic4u6uy8EiX4jKWC+6GbIh1hQ2uLHBOxn55J2QmK/J9y7M7VBuV57UnY
         K/Y6wWyqTxEs/+0mJvSl8oBTR6DdKAncImadulVokxekAe/3eCZLhsPDMsVBkEGmRTim
         VhMmMIQ9LawdPvEMc+/jfP0vfTT5sGMvpwgW7YjNSR91NsdRxsY5l6VfXtoiH6n1bQhs
         4YWv+W4y84c8A81ySRAZ1JpUgGb+HJc+cxmhCe3H5swS7n4mRu0Do2Lv9ndTy+WsWV05
         aZWRazf5kGQCMZ2XjKUVV87al9jhGC6U6i14pP/eWICsOqELVHsriFVZmXp6TenE+Gp4
         c6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=U/lY5CfdHLl3xwIXaQIRba/GPl3Jxhihr4NwbiVFjPo=;
        b=LyPbx0s0hPeMxlMMWm7XXvqC5DYdvPIq3VRMnZFARGXdBLlwD/j5u5EF9/MjyKJoFk
         oeoQwLgiPYqpSBhF4pw3aHl2/rvTjx84SYIa67Adk8fxQXojc0gwE2CmVCw12hb67T2J
         z1AoTSeDjv72gkXUVWqX1XphntuJRSWLo0387td/L/wlpWBYXnnOGiKbM2DMq4SNaaU7
         iEQqlFTrtAa6+fQVnpBW/eDB/b84ZFNk9B+zgOFBFU9iUTevBoVA3enajqSM9VYBAFU/
         wI/Z1kzOxV7761BiqJZLxMb9vXqXG3xjuzV2J/ezEMOCMaWtofymfS5oPfztaVNUExGN
         tJVw==
X-Gm-Message-State: AA+aEWYXrZFHp0NUdLQkSb5bfxcgKEl/4X+Oaj7wYtRFhaSt7gkuSWn9
        qloGB1VZXCtu0r7/wb9HP4LoaA==
X-Google-Smtp-Source: AFSGD/UAi/NJ3PgiFeWjX4A041/WQ8nt8aNRCdGUah1xwxILNe5t4KPPa+Rg/oymu/oVkz81KUiVUQ==
X-Received: by 2002:a63:7f4f:: with SMTP id p15mr6498437pgn.296.1542815228599;
        Wed, 21 Nov 2018 07:47:08 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r6sm65610040pgk.91.2018.11.21.07.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 07:47:07 -0800 (PST)
Date:   Wed, 21 Nov 2018 07:47:07 -0800 (PST)
X-Google-Original-Date: Wed, 21 Nov 2018 07:44:37 PST (-0800)
Subject:     Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *" argument
In-Reply-To: <20181121004422.GA29053@altlinux.org>
CC:     luto@kernel.org, eparis@redhat.com, paul@paul-moore.com,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, x86@kernel.org, esyr@redhat.com,
        lineprinter@altlinux.org, linux-snps-arc@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        oleg@redhat.com, linux-audit@redhat.com,
        linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        linuxppc-dev@lists.ozlabs.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     ldv@altlinux.org
Message-ID: <mhng-c75e14b8-b36c-46c2-8ffc-914312ed0cef@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@sifive.com
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

On Tue, 20 Nov 2018 16:44:22 PST (-0800), ldv@altlinux.org wrote:
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
>
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-audit@redhat.com
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: openrisc@lists.librecores.org
> Cc: sparclinux@vger.kernel.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: x86@kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
