Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 15:45:42 +0100 (CET)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:32961
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993891AbdAKOpfkoLlP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2017 15:45:35 +0100
Received: by mail-oi0-x241.google.com with SMTP id j15so22162200oih.0;
        Wed, 11 Jan 2017 06:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DOgPxh9QLdZSfeWcdt14hHX8Rhk9e9JOAuvOzLwq9ls=;
        b=DV5H7504ZK5JijH0wxJ/eQmGt7Jnymv5jdwKveiCwaMEl0ZGM6ukZPbzOcFKFwYdVf
         9dZNWxh0ecNvX0mGaXOKmDNlcXlYO1xQ88hKOFYKaD9Ebgwg4h+gilhi6EB35b0790/d
         5qfJVhWJDrSkJk6LMbd5Gd1qoKGUmH4+dl2BaQPNNiFFdROXPnsHSxCov6NxsHDca5On
         B9yQfHk3HxXaBP+Tn8ykSYjY/bbBgcwkvQHWB/QoZwS3MDgbYCWwNVMYfGt3m75tMpA9
         ZwAJ0leCfJqO3THeIqFh2B+WxLGQB8MRJ5HQQgLl3XAcS+blMZ8oSndu85FZJyV38rOL
         X1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DOgPxh9QLdZSfeWcdt14hHX8Rhk9e9JOAuvOzLwq9ls=;
        b=C2EXhzrsFGPETnjHsY4ghCklQ/ipAf2WMxEBlvHl/LTVLV9qdd5uJGpuB6+MpkxUsp
         o9DdQDVHNpxkjh0KMRVryvNOaCJtaShcXwdELhhsEeqUkgK3KlZm4ttlVk6RoAv7mDeR
         +4WjHWro58fXXmXuY110bkoe35Vdb41unm2Cq3QRHWHZy8ZLU/VN+I6DPImD263HaqiT
         rVNTeVEpepKszcLq6HPieodJY1egPJv9jC9pb4bEZlY44I1hEhQ76/Viya7u8cseXKb9
         b8sauD7Y95oibCHMafx8FIiKsCIAUk1H2wSvjB1H1ndQaAi+fVir64wdjn3Q2dRTcbsH
         DHMA==
X-Gm-Message-State: AIkVDXIAhjJAWRNKIwsi2+1atqVUzV183xnwnfecC0GksyYHor/VZZgIGh3XRkJEn0DgIEz76GnPYSI4mV3R7A==
X-Received: by 10.157.47.234 with SMTP id b39mr4798060otd.0.1484145929776;
 Wed, 11 Jan 2017 06:45:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.6.196 with HTTP; Wed, 11 Jan 2017 06:45:29 -0800 (PST)
In-Reply-To: <58761c54.ce941c0a.d3222.1282@mx.google.com>
References: <58761c54.ce941c0a.d3222.1282@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jan 2017 15:45:29 +0100
X-Google-Sender-Auth: 9w7adFmb_UDk4cQLiWhmJAX0UTk
Message-ID: <CAK8P3a2-KdJgQ6fsHairEQKi_v4OCu8LEn8ta2aQyrD-UpUkSQ@mail.gmail.com>
Subject: Re: next build: 207 builds: 21 failed, 186 passed, 8 errors, 11487
 warnings (next-20170111)
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     kernel-build-reports@lists.linaro.org,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Jan 11, 2017 at 12:51 PM, kernelci.org bot <bot@kernelci.org> wrote:
>
> Build Failures Detected:
>
> mips: gcc version 6.3.0 (GCC)
> ar7_defconfig FAIL
> ath79_defconfig FAIL
> ci20_defconfig FAIL
> db1xxx_defconfig FAIL
> fuloong2e_defconfig FAIL
> gpr_defconfig FAIL
> ip27_defconfig FAIL
> ip28_defconfig FAIL
> lemote2f_defconfig FAIL
> loongson1b_defconfig FAIL
> loongson1c_defconfig FAIL
> loongson3_defconfig FAIL
> mtx1_defconfig FAIL
> nlm_xlp_defconfig FAIL
> nlm_xlr_defconfig FAIL
> pistachio_defconfig FAIL
> qi_lb60_defconfig FAIL
> xilfpga_defconfig FAIL
> xway_defconfig FAIL

This is probably caused by commit
576a2f0c5c6d ("MIPS: Export memcpy & memset functions alongside their
definitions")

The reason for this being the combination of modern binutils (post
2.26), CONFIG_MODVERSIONS and the absence of
arch/mips/include/asm/asm-prototypes.h, which should include whichever
files declare the symbols below.

    Arnd

> Warnings summary:
> 53 WARNING: "memset" [crypto/sha256_generic.ko] has no CRC!
> 53 WARNING: "memset" [crypto/echainiv.ko] has no CRC!
> 53 WARNING: "memset" [crypto/drbg.ko] has no CRC!
> 53 WARNING: "memcpy" [crypto/sha256_generic.ko] has no CRC!
> 53 WARNING: "memcpy" [crypto/jitterentropy_rng.ko] has no CRC!
> 53 WARNING: "memcpy" [crypto/echainiv.ko] has no CRC!

> 35 WARNING: "__copy_user" [fs/fat/fat.ko] has no CRC!
> 34 WARNING: "memcpy" [lib/zlib_inflate/zlib_inflate.ko] has no CRC!
> 32 WARNING: EXPORT symbol "memset" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "memmove" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "memcpy" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "copy_page" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "clear_page" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "_save_fp" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "__strnlen_kernel_nocheck_asm" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "__strnlen_kernel_asm" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "__strncpy_from_user_nocheck_asm" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "__strncpy_from_user_asm" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "__strncpy_from_kernel_nocheck_asm" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "__strncpy_from_kernel_asm" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "__strlen_kernel_asm" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "__copy_user_inatomic" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "__copy_user" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: EXPORT symbol "__bzero" [vmlinux] version generation failed, symbol will not be versioned.
> 32 WARNING: "__copy_user" [net/ipv6/ip6_tunnel.ko] has no CRC!
> 31 WARNING: EXPORT symbol "csum_partial_copy_nocheck" [vmlinux] version generation failed, symbol will not be versioned.
> 31 WARNING: EXPORT symbol "csum_partial" [vmlinux] version generation failed, symbol will not be versioned.
> 31 WARNING: EXPORT symbol "__csum_partial_copy_kernel" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "__strlen_kernel_asm" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "__strncpy_from_kernel_asm" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "__csum_partial_copy_from_user" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "memset" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "__csum_partial_copy_to_user" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "__csum_partial_copy_kernel" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "__strncpy_from_kernel_nocheck_asm" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "csum_partial" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: EXPORT symbol "__strncpy_from_user_asm" [vmlinux] version generation failed, symbol will not be versioned.
