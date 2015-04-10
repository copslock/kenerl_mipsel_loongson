Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Apr 2015 16:31:13 +0200 (CEST)
Received: from bes.se.axis.com ([195.60.68.10]:39705 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010902AbbDJObLTGhtv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Apr 2015 16:31:11 +0200
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id C85362E426;
        Fri, 10 Apr 2015 16:31:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id RN+FjTAnwnFW; Fri, 10 Apr 2015 16:31:05 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 8F7482E349;
        Fri, 10 Apr 2015 16:31:05 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 756CE10AE;
        Fri, 10 Apr 2015 16:31:05 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id 659FF10A9;
        Fri, 10 Apr 2015 16:31:05 +0200 (CEST)
Received: from xmail4.se.axis.com (xmail4.se.axis.com [10.0.5.46])
        by thoth.se.axis.com (Postfix) with ESMTP id 63BAB3404A;
        Fri, 10 Apr 2015 16:31:05 +0200 (CEST)
Received: from xmail2.se.axis.com ([10.0.5.74]) by xmail4.se.axis.com
 ([fe80::2dfa:6a3a:302a:d4e8%14]) with mapi; Fri, 10 Apr 2015 16:31:05 +0200
From:   Lars Persson <lars.persson@axis.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Lars Persson <larper@axis.com>,
        "paul.burton@imgtec.com" <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 10 Apr 2015 16:31:06 +0200
Subject: Re: [PATCH] MIPS: Fix HIGHMEM crash in __update_cache().
Thread-Topic: [PATCH] MIPS: Fix HIGHMEM crash in __update_cache().
Thread-Index: AdBzmvm8a+fz1qvEQYCdvuRdV6M/VA==
Message-ID: <675481A1-B1B2-47BF-9AF9-2E7773497FEA@axis.com>
References: <1428672084-20676-1-git-send-email-larper@axis.com>
 <20150410134711.GC21107@linux-mips.org>
In-Reply-To: <20150410134711.GC21107@linux-mips.org>
Accept-Language: en-US, sv-SE
Content-Language: sv-SE
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
X-archive-position: 46852
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

Ralf,

I came to think that also non-executable mappings for highmem pages could reach the flushing code in __update_cache() and trigger an OOPS.

Until the highmem patches are merged we should block highmem pages in __update_cache().  Could you add this to the patch ?

Sent from my iPhone

> 10 apr 2015 kl. 15:47 skrev Ralf Baechle <ralf@linux-mips.org>:
> 
>> On Fri, Apr 10, 2015 at 03:21:24PM +0200, Lars Persson wrote:
>> 
>> Commit 8b5fe5e54b47 ("MIPS: Fix race condition in lazy cache flushing.")
>> triggered NULL pointer dereferences on systems with HIGHMEM.
>> 
>> The problem was caused by not clearing the PG_dcache_dirty flag in
>> flush_icache_page() and thus we enter __update_cache() that lacks
>> support for HIGHMEM.
> 
> Thanks, I've folded this patch into the original 8b5fe5e54b47 commit.
> 
>  Ralf
