Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2016 21:23:08 +0100 (CET)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34962 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010740AbcCFUXGZrgHe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Mar 2016 21:23:06 +0100
Received: by mail-lb0-f174.google.com with SMTP id bc4so110110208lbc.2
        for <linux-mips@linux-mips.org>; Sun, 06 Mar 2016 12:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=scf9qbQJPM774IfClJRV1nPtC9bLjqzTqnmz99Duq6s=;
        b=ucnBMBa403Vzv7s9GICcm2lAS4GRRrSjCwZer9rQtgLhddBPN8t0ViPhPfImk7XCzJ
         r0Y5dFIyHizGPPhacMRWCMqIk9anU2yXMilMryibre5I496u+i+D5Hk3l35HW2hOYFNj
         OMiVN0lfnKXWi70GFxDWcgyIOoPB4KcCH8re6BEybFP2T4inqNxWcNUgPI0J85f8ObMs
         ojJ98aLrmReTaqGpOO84PDG0Xnsqz2NuUdu9Nk5B3j5sJfAIHNMOmpTrJaAItB8qSY1Y
         iciKM7ZukYdL7R36UCrgePV5Ah41NFyEyxem1V6gN8o4q+GRh0yJhxsuR9Fkq/H7spOp
         pZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=scf9qbQJPM774IfClJRV1nPtC9bLjqzTqnmz99Duq6s=;
        b=BvjK8a32U7Cd1vcQ+kGZIvYkvXd3pylkl5lE0dtzCjIhHVB+hlqr4vYn1S9NSH5pXp
         nMHFF9j4kpxvWHbuscOv/jr6m15jV89ITHU6F04mbgORtoAlBjaKdCiFltEs+oc9h1tq
         us1Lqxu8bTu0FsELdS3A6e69h1d4N7Ag0l6Dwbc5TjW0FoAip+ePhKPPuVhk1ezG2B82
         gjJ1IfZAUpicFb57c5Bm+36jxrM7mthmB3B6lnmyii+cr0QSKT3DjpoeLVrsiwljt0D8
         r9ci9TZXq0Q7zez+pNJ8tBZj/+13Yq5NkNg+/6HBE7tHy7gwcW1tb10meUuEZ20Rn/SH
         6rHQ==
X-Gm-Message-State: AD7BkJKXyl9WL1QZU9kq5AA1mp/m/T4kgKYQ9eMH4DO54sbpbeHUUoDHPu+4Kd4J1UALSg==
X-Received: by 10.112.124.137 with SMTP id mi9mr3763602lbb.112.1457295780949;
        Sun, 06 Mar 2016 12:23:00 -0800 (PST)
Received: from wasted.cogentembedded.com ([83.149.8.2])
        by smtp.gmail.com with ESMTPSA id y184sm2324433lfd.16.2016.03.06.12.22.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2016 12:22:59 -0800 (PST)
Subject: Re: [PATCH] MIPS: fix build error when SMP is used without GIC
To:     Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
References: <1457273756-4182-1-git-send-email-hauke@hauke-m.de>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "# v3 . 15+" <stable@vger.kernel.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <56DC91A1.5070404@cogentembedded.com>
Date:   Sun, 6 Mar 2016 23:22:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1457273756-4182-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 03/06/2016 05:15 PM, Hauke Mehrtens wrote:

> The MIPS_GIC_IPI should only be selected when MIPS_GIC is also
> selected, otherwise it results in a compile error. smp-gic.c uses some
> functions form include/linux/irqchip/mips-gic.h like

   s/form/from/.

> plat_ipi_call_int_xlate() which are only added to the header file when
> MIPS_GIC is set. The Lantiq SoC does not use the GIC, but supports SMP.
> The calls top the functions from smp-gic.c are laready protected by

    s/laready/already/.

> some #ifdefs
>
> The first part of this was introduced in commit 72e20142b "MIPS: Move
> GIC IPI functions out of smp-cmp.c"

    scripts/checkpatch.pl now enforces certain commit citing style, yours 
doesn't quite match it...

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: <stable@vger.kernel.org> # v3.15+

[...]

MBR, Sergei
