Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Mar 2016 18:50:11 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34890 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007346AbcCJRuJucpob (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Mar 2016 18:50:09 +0100
Received: by mail-pa0-f50.google.com with SMTP id td3so45625842pab.2;
        Thu, 10 Mar 2016 09:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=0urQo8YYg7iRcFFJA+e5+1aQhgHoKIcSlNebL1ktODY=;
        b=oTYEHFQfxam+SIZ8Xis0KS1au/h21mvbcj7W1a5b9lQNpqAcBoYXH/2hk9BVdQlpRo
         1Js3uYyh4ZYv8Sz60YXmwiiH672UgcbyN2lg8SxNc4+NxuUJN40cQK1rTB9bqScAQf9G
         Uk6SQbcJWDp9r2xAphEmBa29jhPDDTTlcKrUuy+zRnIo/TDhxE94pR+ULzc3sIj1sdbF
         wANn/bYoL38iTrHQaKs+ZJdZ1ysA8xWVOV7Ilp6vvCn8VrPgVD7DO/Lzkyc6bYv4EEoY
         /Eh2yZwRTw1N/cx+dhxrSxpzBzXkDtI2RZT7zErthzzVD1EnVieJ46mzqo0UAUhR/LwE
         RD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=0urQo8YYg7iRcFFJA+e5+1aQhgHoKIcSlNebL1ktODY=;
        b=b6Wmx1rq+YV3hzg+2I07+R8TFTzl5sSMfJ5RrkuixJRkDKNv7EVycpzHf6vK+LhZP3
         kQq0Zztz28O4UwaYwFMRAdwviFTfbiXv85NNYYpPv5jH5I8mqUz7rYQuHJzpowTMB3je
         DAfAsmUZl1ViS5mPh/HiJ+Lx7toCevoNZ3ltCsTwZg7gYIQ10ctCxhoH6r/EG7xbabM5
         65mYkOkrO5zxRaSU/uHgPOA/fK0Wnj0YeHlpPFuPnkYss84wwhd6IO0gHnWQK+2pqbf+
         MJ1aQVnxzhgDMkfChtimI/fqvXBT3Vh0uSK/8V/y1Cdic4YzeOIle8lsJLUS92kcYBRi
         CRpQ==
X-Gm-Message-State: AD7BkJIEHhAd/cFtLkREb3kUrXRICEioyVN68kVxm06C4UMlzk/gRVxxXSLkRqLbsND+hw==
X-Received: by 10.66.176.10 with SMTP id ce10mr6333700pac.68.1457632203791;
        Thu, 10 Mar 2016 09:50:03 -0800 (PST)
Received: from [192.168.1.103] ([103.24.124.195])
        by smtp.gmail.com with ESMTPSA id u81sm7042683pfi.15.2016.03.10.09.50.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2016 09:50:03 -0800 (PST)
Message-ID: <56E1B3C5.7040204@gmail.com>
Date:   Thu, 10 Mar 2016 23:19:57 +0530
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michal Marek <mmarek@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>, linux-mips@linux-mips.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ld-version: Fix awk regex compile failure
References: <1457455673-12219-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1457455673-12219-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

On Tuesday 08 March 2016 10:17 PM, James Hogan wrote:
> The ld-version.sh script fails on some versions of awk with the
> following error, resulting in build failures for MIPS:
>
> awk: scripts/ld-version.sh: line 4: regular expression compile failed (missing '(')
>
> This is due to the regular expression ".*)", meant to strip off the
> beginning of the ld version string up to the close bracket, however
> brackets have a meaning in regular expressions, so lets escape it so
> that awk doesn't expect a corresponding open bracket.
>
> Fixes: ccbef1674a15 ("Kbuild, lto: add ld-version and ld-ifversion ...")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

This error was only coming in my gitlab builds but was not showing in 
the build of travis-ci. Maybe it depends on the version of awk also.
Build log at: https://gitlab.com/sudipm/linux-next/builds/839573

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

regards
sudip
