Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2015 19:48:19 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34009 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007014AbbBWSsSLg0MM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2015 19:48:18 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id A77E94600E1
        for <linux-mips@linux-mips.org>; Mon, 23 Feb 2015 18:48:12 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aBBzgUe0nATu for <linux-mips@linux-mips.org>;
        Mon, 23 Feb 2015 18:48:10 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 1581C4603FE
        for <linux-mips@linux-mips.org>; Mon, 23 Feb 2015 18:48:10 +0000 (GMT)
Received: from [::1] (helo=paulmartin.codethink.co.uk)
        by pm-laptop.codethink.co.uk with esmtp (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YPy37-0006eK-Kp
        for linux-mips@linux-mips.org; Mon, 23 Feb 2015 18:48:09 +0000
Date:   Mon, 23 Feb 2015 18:48:09 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: Octeon breakage from 77f3ee59ee7cfe19e0ee48d9a990c7967fbfcbed
Message-ID: <20150223184808.GA25302@paulmartin.codethink.co.uk>
Mail-Followup-To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

Commit 77f3ee59ee7cfe19e0ee48d9a990c7967fbfcbed

  MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard for the EHB instruction

causes problems on Octeon when trying to run a 4.0-rc1 kernel:

  Kernel panic - not syncing: No TLB refill handler yet (CPU type: 79)

as arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
contains

  #define cpu_has_mips64r2        1
  #define cpu_has_mips_r2_exec_hazard 0

Reverting the patch allows the kernel to boot normally.

I'm not sure which is wrong: the use of cpu_has_mips_r2_exec_hazard to
detect the EHB instruction, or the Cavium headers.  I suspect the
override in the latter may be wrong.

I'll just note that 3.19 does not make any use of this value.

-- 
Paul Martin                                  http://www.codethink.co.uk/
Senior Software Developer, Codethink Ltd.
