Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 18:21:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45216 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835104Ab3FJQVDmTGRX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 18:21:03 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5AGL1c6012926;
        Mon, 10 Jun 2013 18:21:02 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5AGL1K3012925;
        Mon, 10 Jun 2013 18:21:01 +0200
Date:   Mon, 10 Jun 2013 18:21:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: Re: [PATCH] MIPS: ftrace: Add missing CONFIG_DYNAMIC_FTRACE
Message-ID: <20130610162101.GE5303@linux-mips.org>
References: <1370864126-24931-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370864126-24931-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36808
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

On Mon, Jun 10, 2013 at 12:35:26PM +0100, Markos Chandras wrote:

> arch_ftrace_update_code and ftrace_modify_all_code are only
> available if CONFIG_DYNAMIC_FTRACE is selected.
> 
> Fixes the following build problem on MIPS randconfig:
> 
> arch/mips/kernel/ftrace.c: In function 'arch_ftrace_update_code':
> arch/mips/kernel/ftrace.c:31:2: error: implicit declaration of function
> 'ftrace_modify_all_code' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>

Patch is looking ok but I'm wonder abou thte SoB headers.  Since you
appear to be the patch author and are sending your own patch, one would
only expect your own SoB.  So I assume Steve's SoB was really meant to be
an Acked-by:?  Sam ealso for the other patch I accepted moments ago.

  Ralf
