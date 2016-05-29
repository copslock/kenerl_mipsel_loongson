Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2016 23:19:47 +0200 (CEST)
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33292 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27039245AbcE2VToyuEyS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 May 2016 23:19:44 +0200
Received: by mail-pf0-f179.google.com with SMTP id b124so57923297pfb.0
        for <linux-mips@linux-mips.org>; Sun, 29 May 2016 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDa2hKHMpTBitKI27cTnaYQwH8jxuQnL9Y32mLas6yc=;
        b=oGcot5eWlFkvJ5U+Apgag117a8lbQ69TFE/FvrCDMxmEI+nJ5nAaSxaNGuxUeM/W0x
         +KDNp6iUj2wocqHb+dA/D6h+NXtZWO7LhPnynkY+7y65NwNICQ5m8c4E5YvC1cMJgwQu
         h+0SnVOiYnNJQBNFOTIYZmWVPjcKD/AnN3fRcZlBiY/SdoNhcNRPLwQBiNYUG8E8yyX+
         TaNj+4SKWcaAs5p5n/sjPsWC4IUu8qt9v02FkmZ3yj5K+Spfck6src/MlZd3nPva2aL/
         K5G8BevrxRV0yeSTkxjsrV2zJVOxKkvN33MO06c+bTUgY8hNuca+NmuSn5EsZ1W/Xoj2
         oUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDa2hKHMpTBitKI27cTnaYQwH8jxuQnL9Y32mLas6yc=;
        b=WCApW1WkTjOfL82m6auZuX0JlyiddSal+aSz+5Q4sC3q5ltHUM6wJHm1mzQqDRiWP2
         /TiyHI7sbNbLF3AlYIdLpBIRljpTBkeN9XrN7KlF+MHtIblqpSD6s/sJvnKgvep+ZnU2
         cWE900UzPcis+J4PBJXoJaluXe8J3VGnIaG8xMN0Pntr3Z6T7uQrljReNOy94SYDIoI6
         Q47odrvscMn4qVjdQGVDsZfYzdFklJml5JcKmH3zWKjvMw2JCYv0qdqz0pO+MNptATZT
         ILmc9OwnsKPCpEGNsUVqNh8Wd9NNE/bK+e7NdKyMU5qtITqNNne/oWELPoMAI8BiOOoU
         Wn7g==
X-Gm-Message-State: ALyK8tL3TA8Tccc/yaMd5rFMDeBPrhq6osqAYYjQQ+gYPiebgnzfheX8Kd7ODhxKSjMG1g==
X-Received: by 10.98.28.148 with SMTP id c142mr41256750pfc.102.1464556778726;
        Sun, 29 May 2016 14:19:38 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:b546:9ef3:e6a7:b5eb? ([2601:645:c200:33:b546:9ef3:e6a7:b5eb])
        by smtp.gmail.com with ESMTPSA id b73sm24632889pfd.61.2016.05.29.14.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 May 2016 14:19:38 -0700 (PDT)
Message-ID: <1464556766.5020.42.camel@chimera>
Subject: Re: [PATCH v2] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, hauke@hauke-m.de, openwrt@kresin.me,
        antonynpavlov@gmail.com
Date:   Sun, 29 May 2016 14:19:26 -0700
In-Reply-To: <c481d3b1-bee1-89c9-bbb8-ef17d91570bf@openwrt.org>
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
         <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
         <c481d3b1-bee1-89c9-bbb8-ef17d91570bf@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Sun, 2016-05-29 at 12:53 +0200, Jonas Gorski wrote:
> Maybe a better solution here would be to create a new symbol
> fw_passed_dtb and let the code store a1 in there if a0 is -2, or
> __appended_dtb in case it is valid? Then we wouldn't need to special
> case APPENDED_DTB for any mach wanting to use it, and they can just
> check fw_passed_dtb.
> 
> something like:
> 
> arch/mips/kernel/head.S:
> ...
> 
> #ifdef CONFIG_USE_OF
>         li              t1, -2
>         beq             a0, t1, dtb_found
>         move            t0, a0
> 
> #ifdef CONFIG_MIPS_RAW_APPENDED_DTB
>         PTR_LA          t0, __appended_dtb
> 
> #ifdef CONFIG_CPU_BIG_ENDIAN
>         li              t1, 0xd00dfeed
> #else
>         li              t1, 0xedfe0dd0
> #endif
>         lw              t2, (t0)
>         bne             t1, t2, no_dtb_found
>          nop
> 
> #endif
> no_dtb_found:
>         li              t0, 0
> dtb_found:
>         LONG_S          t0, fw_passed_dtb
> #endif

That prefers the wrong DTB in case both are present. I propose this
instead:

#ifdef CONFIG_USE_OF
#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
        PTR_LA          t0, __appended_dtb

#ifdef CONFIG_CPU_BIG_ENDIAN
        li              t1, 0xd00dfeed
#else
        li              t1, 0xedfe0dd0
#endif
        lw              t2, (t0)
        beq             t1, t2, dtb_found
         nop

#endif
        li              t1, -2
        beq             a0, t1, dtb_found
        move            t0, a1

no_dtb_found:
        li              t0, 0
dtb_found:
        LONG_S          t0, fw_passed_dtb
#endif
