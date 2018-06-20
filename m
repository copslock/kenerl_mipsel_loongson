Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 02:22:48 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:42041 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994641AbeFTAWj28jwG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2018 02:22:39 +0200
Received: from mipsdag03.mipstec.com (mail3.mips.com [12.201.5.33]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 20 Jun 2018 00:22:29 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag03.mipstec.com
 (10.20.40.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 17:22:28 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Tue, 19 Jun
 2018 17:22:28 -0700
Date:   Tue, 19 Jun 2018 17:22:29 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] MIPS: boot: correct prerequisite image of
 vmlinux.*.its
Message-ID: <20180620002229.xsh4bupxa72nhjoh@pburton-laptop>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
 <1523890067-13641-5-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1523890067-13641-5-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529454149-321457-29061-17275-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.33
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194209
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: yamada.masahiro@socionext.com,ralf@linux-mips.org,jhogan@kernel.org,linux-mips@linux-mips.org,keescook@chromium.org,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Masahiro,

Thanks for these - I've applied patches 1-3, 5 & 6 to mips-next for
4.19.

On Mon, Apr 16, 2018 at 07:47:44AM -0700, Masahiro Yamada wrote:
> vmlinux.*.its does not directly depend on $(VMLINUX) but
> vmlinux.bin.*

This isn't really true - to generate the .its we actually do depend on
the ELF, which we read the entry address from (entry-y in
arch/mips/Makefile, provided to arch/mips/boot/Makefile as
VMLINUX_ENTRY_ADDRESS). In practice $(VMLINUX) is built before this
makefile is ever invoked anyway, but the dependency is there.

We don't need the vmlinux.bin.* file until we generate the .itb, so it
should be fine for the .its & .bin steps to be executed in parallel
which this patch would prevent.

Thanks,
    Paul
