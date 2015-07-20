Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jul 2015 08:25:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45934 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010604AbbGTGZWGVVtH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Jul 2015 08:25:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6K6PIWS016691;
        Mon, 20 Jul 2015 08:25:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6K6PBrr016690;
        Mon, 20 Jul 2015 08:25:11 +0200
Date:   Mon, 20 Jul 2015 08:25:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] Documentation/sysrq.txt: Mention MIPS TLB dump (x)
Message-ID: <20150720062511.GA16627@linux-mips.org>
References: <1436973467-3877-1-git-send-email-james.hogan@imgtec.com>
 <1436973467-3877-2-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436973467-3877-2-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48351
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

Jonathan,

On Wed, Jul 15, 2015 at 04:17:42PM +0100, James Hogan wrote:

> Commit d1e9a4f54735 ("MIPS: Add SysRq operation to dump TLBs on all
> CPUs") added the 'x' sysrq key for dumping MIPS TLB entries, but didn't
> document it in Documentation/sysrq.txt.
> 
> Add mention of the MIPS use of the 'x' SysRq key.
> 
> Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Maciej W. Rozycki <macro@linux-mips.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-mips@linux-mips.org
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/sysrq.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/sysrq.txt b/Documentation/sysrq.txt
> index 0e307c94809a..267f39386f99 100644
> --- a/Documentation/sysrq.txt
> +++ b/Documentation/sysrq.txt
> @@ -119,6 +119,7 @@ On all -  write a character to /proc/sysrq-trigger.  e.g.:
>  
>  'x'	- Used by xmon interface on ppc/powerpc platforms.
>            Show global PMU Registers on sparc64.
> +          Dump all TLB entries on MIPS.
>  
>  'y'	- Show global CPU Registers [SPARC-64 specific]

ok to funnel this through the MIPS tree?

  Ralf
