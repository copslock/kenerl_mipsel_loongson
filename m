Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 00:05:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45122 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994851AbdGRWFOL-P8F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jul 2017 00:05:14 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v6IM5D7N024891;
        Wed, 19 Jul 2017 00:05:13 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v6IM5DCF024890;
        Wed, 19 Jul 2017 00:05:13 +0200
Date:   Wed, 19 Jul 2017 00:05:13 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: ralink: mt7620: Add missing header
Message-ID: <20170718220513.GB22091@linux-mips.org>
References: <1500384346-10527-1-git-send-email-harvey.hunt@imgtec.com>
 <1500384346-10527-2-git-send-email-harvey.hunt@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1500384346-10527-2-git-send-email-harvey.hunt@imgtec.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jul 18, 2017 at 02:25:46PM +0100, Harvey Hunt wrote:

> Fix a build error caused by not including <linux/bug.h>.
> 
> The following compilation errors are caused by the missing header:
> 
> arch/mips/ralink/mt7620.c: In function ‘mt7620_get_cpu_pll_rate’:
> arch/mips/ralink/mt7620.c:431:2: error: implicit declaration of function ‘WARN_ON’ [-Werror=implicit-function-declaration]
>   WARN_ON(div >= ARRAY_SIZE(mt7620_clk_divider));
>   ^
> arch/mips/ralink/mt7620.c: In function ‘mt7620_get_sys_rate’:
> arch/mips/ralink/mt7620.c:500:2: error: implicit declaration of function ‘WARN’ [-Werror=implicit-function-declaration]
>   if (WARN(!div, "invalid divider for OCP ratio %u", ocp_ratio))
>   ^
> arch/mips/ralink/mt7620.c: In function ‘mt7620_dram_init’:
> arch/mips/ralink/mt7620.c:619:3: error: implicit declaration of function ‘BUG’ [-Werror=implicit-function-declaration]
>    BUG();
>    ^
> cc1: some warnings being treated as errors
> scripts/Makefile.build:302: recipe for target 'arch/mips/ralink/mt7620.o' failed
> 
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org

Same comment as for the previous patch - looks sensible, so applied.  But
I'm wondering why I don't see this in test builds.

  Ralf
