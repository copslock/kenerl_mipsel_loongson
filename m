Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2014 19:22:29 +0200 (CEST)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:42822 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854780AbaFDRWZsNwnU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jun 2014 19:22:25 +0200
Received: by mail-ie0-f173.google.com with SMTP id lx4so7605606iec.18
        for <multiple recipients>; Wed, 04 Jun 2014 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gwIy/zP3LhbH+XHkPBggKDnb03hCsLlAPZ1gR+Xmqgk=;
        b=GwDog7aLmGxCvMHgPuivnxFAhqWFhTpdmiXZYh+tm/BKorgnGnQgke1spVbvkUKbM4
         VfBqWrXULByaHpOJBg6oJTip3nCoX3aLTCDzvfcag6rA3WoHNV42GxmzmPQJ6DXyfRnW
         Ngwp8kP5Q6XesqLTeIIfMp7C8bcqGWFzPwVWwBGyIi8GdW+Qz2tHf0uR/ZkKMjxnVA3G
         SLf9tYxvIBVkEMolwaHv1T8Sf2JWnu3CQ+N9CWOr9rOgNfSg+VbTgi50J3AQG6AIo+aJ
         XCSYjez/+kJaIEj5N1K1WYs6LSIQopjw/hOHzx24kIxZES+QpUuQQ+GygWVo1JCI3csb
         DCGQ==
X-Received: by 10.50.28.51 with SMTP id y19mr9371385igg.5.1401902539479;
        Wed, 04 Jun 2014 10:22:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ql7sm46395963igc.19.2014.06.04.10.22.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 10:22:18 -0700 (PDT)
Message-ID: <538F55C9.7090905@gmail.com>
Date:   Wed, 04 Jun 2014 10:22:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Huacai Chen <chenhc@lemote.com>, John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 4/8] MIPS: Add NUMA support for Loongson-3
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com> <1397348662-22502-5-git-send-email-chenhc@lemote.com> <20140603224739.GU17197@linux-mips.org> <538E5EA8.8010907@gmail.com> <20140604064601.GU5157@linux-mips.org>
In-Reply-To: <20140604064601.GU5157@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/03/2014 11:46 PM, Ralf Baechle wrote:
>
> A more important value which I haven't noticed the Looongson patches to
> modify is SECTION_SIZE_BITS in <asm/sparsemem.h>:
>
> #if defined(CONFIG_MIPS_HUGE_TLB_SUPPORT) && defined(CONFIG_PAGE_SIZE_64KB)
> # define SECTION_SIZE_BITS      29
> #else
> # define SECTION_SIZE_BITS      28
> #endif
>
> Don't ask me why its definition depends on MIPS_HUGE_TLB_SUPPORT and
> PAGE_SIZE_64KB - the value describes the larges chunk of contiguous
> memory (that is for example memory per node) and that doesn't depend
> on these CONFIG_* symbols.
>

I think I can answer that.  We do the same thing for OCTEON I think.

IIRC, with SPARSEMEM, you cannot allocate high order pages that span 
multiple sections.  Therefore you have to have the sections be at least 
as large as a huge page.  in the case of CONFIG_PAGE_SIZE_64KB, the huge 
pages are 512MB which doesn't fit in 28 bits.

David.


>    Ralf
>
>
