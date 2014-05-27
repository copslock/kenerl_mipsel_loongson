Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2014 13:11:36 +0200 (CEST)
Received: from bes.se.axis.com ([195.60.68.10]:41593 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822166AbaE0LLeflDa6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 May 2014 13:11:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 5D8842E35F
        for <linux-mips@linux-mips.org>; Tue, 27 May 2014 13:11:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id y4kqdLQTUlJS for <linux-mips@linux-mips.org>;
        Tue, 27 May 2014 13:11:22 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 18A142E2DF
        for <linux-mips@linux-mips.org>; Tue, 27 May 2014 13:11:22 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id ECED2EC3
        for <linux-mips@linux-mips.org>; Tue, 27 May 2014 13:11:21 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id E14A04BA
        for <linux-mips@linux-mips.org>; Tue, 27 May 2014 13:11:21 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by thoth.se.axis.com (Postfix) with ESMTP id DED3034005
        for <linux-mips@linux-mips.org>; Tue, 27 May 2014 13:11:21 +0200 (CEST)
Received: from xmail2.se.axis.com ([10.0.5.74]) by xmail2.se.axis.com
 ([10.0.5.74]) with mapi; Tue, 27 May 2014 13:11:21 +0200
From:   Lars Persson <lars.persson@axis.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Martin Santesson <martinsn@axis.com>,
        Mikael Starvik <starvik@axis.com>
Date:   Tue, 27 May 2014 13:11:20 +0200
Subject: RE: 1004K MT paging issue
Thread-Topic: 1004K MT paging issue
Thread-Index: Ac95JQomL4oMCFQ8Rku9uVPj/xftKAAdJvkQ
Message-ID: <771471B8871B5044A6CA7CCD9C26EEE10117E311D65E@xmail2.se.axis.com>
References: <498838AF-48B0-4244-95C0-F590040E5E08@axis.com>
In-Reply-To: <498838AF-48B0-4244-95C0-F590040E5E08@axis.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

Hi

I have found a MIPS-specific race window in __do_fault() between these two calls:
set_pte_at(mm, address, page_table, entry);

/* no need to invalidate: a not-present page won't be cached */
update_mmu_cache(vma, address, page_table);
 
When the block device uses PIO-mode to populate the page in the page-cache, then the main memory still contains stale data when set_pte_at() makes the mapping live. Another VPE hitting the same page will execute garbage code.

Please see the ARM port for hints how to fix this by flushing the data cache already in set_pte_at.

BR,
 Lars


> -----Original Message-----
> From: Mikael Starvik
> Sent: den 26 maj 2014 22:57
> To: linux-mips@linux-mips.org
> Cc: Lars Persson; Martin Santesson
> Subject: 1004K MT paging issue
> 
> Hi!
> 
> We have a 1004K core with two VPEs with two TCs per VPE. We have a
> problem that is hard to debug and would like to know if anyone has seen
> or solved such an issue.
> 
> A multithreaded application is running.
> Twoapplication threads are running in one TC each on the same VPE.
> A piece of code has been paged out.
> Application thread 1 tries to execute the code and thus gets a page
> fault.
> While the page fault is being handled the second application thread
> enters the same code.
> For some reason it looks like application thread 2 is allowed to
> execute even if the page fault handling has not been finished yet.
> Thread 2 executes the wrong code and typically gets a reserved
> instruction exception.
> 
> Any thougts?
> 
> BR
> /Mikael
