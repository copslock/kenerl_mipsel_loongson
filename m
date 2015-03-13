Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 15:50:38 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46146 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013674AbbCMOugY1e0Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Mar 2015 15:50:36 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2DEiihQ014751;
        Fri, 13 Mar 2015 15:47:24 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2DEihig014750;
        Fri, 13 Mar 2015 15:44:43 +0100
Date:   Fri, 13 Mar 2015 15:44:43 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: mm: tlbex: Replace cpu_has_mips_r2_exec_hazard
 with cpu_has_mips_r2_r6
Message-ID: <20150313144443.GA12977@linux-mips.org>
References: <1424731974-27926-1-git-send-email-ddaney.cavm@gmail.com>
 <1426238288-15560-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426238288-15560-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46363
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

On Fri, Mar 13, 2015 at 09:18:08AM +0000, Markos Chandras wrote:

> Commit 77f3ee59ee7cf ("MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard
> for the EHB instruction") replaced cpu_has_mips_r2 with
> cpu_has_mips_r2_exec_hazard to indicate whether the ISA has the EHB
> instruction. However, the meaning of the cpu_has_mips_r2_exec_hazard
> is different. It was meant to be used as an indication on whether the
> running processor needs to run the EHB instruction instead of checking
> whether the EHB is available on the ISA. This broke processors that do
> not define cpu_has_mips_r2_exec_hazard. We fix this by replacing the
> said macro with cpu_has_mips_r2_r6 which covers R2 and R6 processors.
> 
> Fixes: 77f3ee59ee7cf ("MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard for the EHB instruction")
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

Either of this David's revert or this patch applied will leave
cpu_has_mips_r2_exec_hazard unused which at a glance doesn't seem to
be right and defeats David's old patches 9e290a19 / 41f0e4d0 from working.

cpu_has_mips_r2_exec_hazard was made unused by 625c0a21 which I think
should be reverted and cpu_has_mips_r2_exec_hazard be defined to be something
like

#define cpu_has_mips_r2_exec_hazard					\
({									\
	int __res;							\
									\
	switch (current_cpu_type()) {					\
	case CPU_M14KC:							\
	case CPU74K:							\
	case CPU_CAVIUM_OCTEON:						\
	case CPU_CAVIUM_OCTEON_PLUS:					\
        case CPU_CAVIUM_OCTEON2:					\
	case CPU_CAVIUM_OCTEON3:					\
		__res = 0;						\
		break;							\
									\
	default:							\
		__res = 1;						\
	}								\
									\
	__res;								\
})

?

  Ralf
