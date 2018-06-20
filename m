Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 02:27:03 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:51534 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994641AbeFTA0zvH1UU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2018 02:26:55 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1414.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 20 Jun 2018 00:26:47 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 17:26:46 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Tue, 19 Jun
 2018 17:26:46 -0700
Date:   Tue, 19 Jun 2018 17:26:47 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] MIPS: boot: rebuild ITB when contained DTB is updated
Message-ID: <20180620002647.u2d7t3vzc2yinkft@pburton-laptop>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
 <1523890067-13641-8-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1523890067-13641-8-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529454407-531716-21947-19827-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
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
X-archive-position: 64390
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

On Mon, Apr 16, 2018 at 07:47:47AM -0700, Masahiro Yamada wrote:
> Since now, the unnecessary rebuild of ITB has been fixed.  Another
> problem to be taken care of is, missed rebuild of ITB.
> 
> For example, board-boston.its.S includes boston.dtb by the /incbin/
> directive.  If boston.dtb is updated, vmlinux.*.dtb must be rebuilt.
> Currently, the dependency between ITB and contained DTB files is not
> described anywhere.  Previously, this problem was hidden since
> vmlinux.*.itb was always rebuilt even if nothing is updated.  By
> fixing the spurious rebuild, this is a real problem now.
> 
> Use the same strategy for automatic generation of the header file
> dependency.  DTC works as a backend of mkimage, and DTC supports -d
> option.  It outputs the dependencies, including binary files pulled
> by the /incbin/ directive.
> 
> The implementation is simpler than cmd_dtc in scripts/Makefile.lib
> since we do not need CPP here.  Just pass -d $(depfile) to DTC, and
> let the resulted $(depfile) processed by fixdep.
> 
> It might be unclear why "$(obj)/dts/%.dtb: ;" is needed.  With this
> commit, *.cmd files will contain dependency on DTB files.  In the
> next invocation of build, the *.cmd files will be included, then
> Make will try to find a rule to update *.dtb files.  Unfortunately,
> it is found in scripts/Makefile.lib.  The build rule of $(obj)/%.dtb
> is invoked by if_changed_dep, so it needs to include *.cmd files
> of DTB, but they are not included because we are in arch/mips/boot,
> but those *.cmd files reside in arch/mips/boot/dts/*/.  Cancel the
> pattern rule in scripts/Makefile.lib to suppress unneeded rebuilding
> of DTB.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/mips/boot/Makefile | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Thanks - this looks good to me except that it starts outputting a "Don't
know how to preprocess itb-image" message after building the .itb.

I presume we just need an extra case adding to ksym_dep_filter. Do you
want to add that in & resubmit this one?

Thanks,
    Paul
