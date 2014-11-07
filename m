Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 19:30:37 +0100 (CET)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:43551 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012811AbaKGSagC8rA- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 19:30:36 +0100
Received: by mail-ie0-f172.google.com with SMTP id at20so5786998iec.3
        for <multiple recipients>; Fri, 07 Nov 2014 10:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NUjx/dSeCuO5c6UXSF87wAjK8WmP6B4WK8s78rpc0zA=;
        b=S0dd/Z3egwTUZ0LLzEJ4VdP+WRiS0D3JjTV49yq2C140rdcyWN2Mqr8/QQ8JcX9Jxu
         nKtLqz2qgJCgqxqYndIi5Xvhu8Iosk2Hp6uvZVK2exVLSoG1XFhFe8hLDM/rzQlahWwa
         DfrstKiBst9zT1udipgyTMj+dazZtb+mBUp8jjihWp3vq5iqGaZxTPrYX4gIxfLwnJyA
         FzOGRsNkZlbTHGx9ovCeO/3/LVAUn7VBMtSnGbCqTv/gRoTBPeIeHeje4fy/sj8GXhas
         muG+DC+5wD5Soo6Guq4Ak1PzUJJbWeRJOp8VZ4WnZVh6v11dT5IyQMsQ8HAxoojw89WE
         eKLg==
X-Received: by 10.50.43.130 with SMTP id w2mr5914777igl.21.1415385029940;
        Fri, 07 Nov 2014 10:30:29 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id qo8sm993830igb.7.2014.11.07.10.30.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Nov 2014 10:30:29 -0800 (PST)
Message-ID: <545D0FC4.7020205@gmail.com>
Date:   Fri, 07 Nov 2014 10:30:28 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54560D3B.8060602@gentoo.org> <5457CF0A.7020303@gmail.com> <5458272A.7050309@gentoo.org> <54582A91.8040401@gmail.com> <20141105160945.GB13785@linux-mips.org> <545C9D4D.4090501@gentoo.org>
In-Reply-To: <545C9D4D.4090501@gentoo.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43922
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

On 11/07/2014 02:22 AM, Joshua Kinard wrote:
[...]
>
> So my guess is unless hugepages can happen in powers of 4,

Huge  pages are currently only supported on MIPS64 for this reason.

huge_page_mask_size = (normal_page_size/8 * normal_page_size) / 2;

If you take log2 of everything you get

huge_page_mask_bits = normal_page_bits - 3 + normal_page_bits - 1
   = 2 * normal_page_bits - 4 (always even)

So all page sizes result in huge pages that meet the power of 4 criterion.

> they're not
> compatible w/ the R10K-series (and likely not the R5K/RM7K, either, since they
> all have the same 24:13 bits in the PageMask register).  It seems the logical
> choice would be to remove 'select CPU_SUPPORTS_HUGEPAGES' from CPU_R5000,
> CPU_NEVADA, CPU_R10000, and CPU_RM7000 in arch/mips/Kconfig.
>
