Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Feb 2013 21:42:22 +0100 (CET)
Received: from vms173007pub.verizon.net ([206.46.173.7]:63569 "EHLO
        vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827608Ab3BLUmTxlVgh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Feb 2013 21:42:19 +0100
Received: from wf-rch.minyard.home ([unknown] [173.74.121.95])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI400A4TK5RXCJ1@vms173007.mailsrvcs.net> for
 linux-mips@linux-mips.org; Tue, 12 Feb 2013 14:41:56 -0600 (CST)
Received: from i.minyard.home (i2.minyard.home [192.168.27.116])
        by wf-rch.minyard.home (Postfix) with ESMTP id 020DC1F93D       for
 <linux-mips@linux-mips.org>; Tue, 12 Feb 2013 14:41:50 -0600 (CST)
Received: by i.minyard.home (Postfix, from userid 1000) id 40EBD80EE3; Tue,
 12 Feb 2013 14:41:51 -0600 (CST)
From:   minyard@acm.org
To:     linux-mips@linux-mips.org
Subject: [PATCH 0/2] mips: Add some kdump fail-safes for kernel memory
Date:   Tue, 12 Feb 2013 14:41:46 -0600
Message-id: <1360701708-21371-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 1.7.4.1
X-archive-position: 35736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

I was having some trouble with kdump on Octeon, and due to the way
memory is handled there the MIPS kernel's assumptions about memory
were not correct.

The first patch adds a fail-safes to make sure kernel memory is in
the memory map.  That way it appears in /proc/iomem.

The second patch reserve the elfcorehdr from kdump if it appears
in the kernel's managed memory.  That way it won't get clobbered
by the kernel if that happens.
