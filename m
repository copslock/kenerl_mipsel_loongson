Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2016 21:01:36 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:60488 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27030343AbcE2TBezOAtR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 May 2016 21:01:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 07222B91694;
        Sun, 29 May 2016 21:01:30 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.0.2] (dslb-088-073-007-040.088.073.pools.vodafone-ip.de [88.73.7.40])
        by arrakis.dune.hu (Postfix) with ESMTPSA id C95A7B9163A;
        Sun, 29 May 2016 21:01:19 +0200 (CEST)
Subject: Re: [PATCH v2] Re: Adding support for device tree and command line
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
 <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
 <c481d3b1-bee1-89c9-bbb8-ef17d91570bf@openwrt.org>
 <1464547128.5020.32.camel@chimera>
Cc:     linux-mips@linux-mips.org, hauke@hauke-m.de, openwrt@kresin.me,
        antonynpavlov@gmail.com
From:   Jonas Gorski <jogo@openwrt.org>
Message-ID: <16b32a30-b0b4-d69e-b53d-827b9640c0cb@openwrt.org>
Date:   Sun, 29 May 2016 21:01:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1464547128.5020.32.camel@chimera>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On 29.05.2016 20:38, Daniel Gimpelevich wrote:
> On Sun, 2016-05-29 at 12:53 +0200, Jonas Gorski wrote:
>> This will break/won't compile for ZBOOT_APPENDED_DTB as __appended_dtb
>> is
>> part of the wrapping decompressor, and the kernel has no knowledge of
>> this
>> this symbol.
> 
> If this were true, it wouldn't compile with the code you added to
> compressed/head.S, either. You're referencing it as an external symbol,
> which is exactly the same thing I'm doing here.

There are two different __appended_dtb definitions: the one for the
(uncompressed) kernel appended one that is visible to the kernel (in
kernel/vmlinux.lds.S), and one in boot/compressed/ld.script that is
visible only to the wrapping decompressor.

Since the wrapping decompressor is built *after* the kernel was compiled
and compressed, there is no way to tell the kernel where __appended_dtb is
relative to the decompressor, so for ZBOOT_APPENDED_DTB you cannot
reference __appended_dtb from kernel code.

 Your proposed
> alternatives are functionally almost equivalent to your earlier rejected
> patches:

These weren't rejected, just deemed insufficient (mostly by me myself).

And only to this one is similar:
> https://patchwork.linux-mips.org/patch/7274/

But in contrast to this one, it doesn't populate initial_boot_params auto-
matically, but instead still requires the mach to do that (by calling
__dt_setup_arch()). I dropped that because IIRC at that time I read that
initial_boot_params isn't supposed to be directly accessed.
Also not populating initial_boot_params is IMHO better as just because
a0 says -2 it doesn't mean a1 references a dtb - that should still be up
to the mach to say that it expects a dtb to be passed.


> https://patchwork.linux-mips.org/patch/7313/

This one was only missing alignment for the !SMP case but is otherwise
equivalent to what is in the kernel now.


Jonas
