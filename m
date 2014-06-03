Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 12:29:34 +0200 (CEST)
Received: from bes.se.axis.com ([195.60.68.10]:51241 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6843087AbaFCK3bzXZpH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jun 2014 12:29:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 82FA92E2F1;
        Tue,  3 Jun 2014 12:29:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id rxPG0stvDKTS; Tue,  3 Jun 2014 12:29:19 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 3CD5F2E2FC;
        Tue,  3 Jun 2014 12:29:19 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 26753ECE;
        Tue,  3 Jun 2014 12:29:19 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id 1B2728F4;
        Tue,  3 Jun 2014 12:29:19 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by thoth.se.axis.com (Postfix) with ESMTP id 18D6D34005;
        Tue,  3 Jun 2014 12:29:19 +0200 (CEST)
Received: from xmail2.se.axis.com ([10.0.5.74]) by xmail2.se.axis.com
 ([10.0.5.74]) with mapi; Tue, 3 Jun 2014 12:29:19 +0200
From:   Lars Persson <lars.persson@axis.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Tue, 3 Jun 2014 12:29:17 +0200
Subject: RE: [PATCH] MIPS: Remove race window in page fault handling
Thread-Topic: [PATCH] MIPS: Remove race window in page fault handling
Thread-Index: Ac9+gmBVyNagLwEeTBiqVNnz+WY8MwAk8DAA
Message-ID: <771471B8871B5044A6CA7CCD9C26EEE10117E31EC89D@xmail2.se.axis.com>
References: <1401532566-22929-1-git-send-email-larper@axis.com>
 <538CAAA6.90509@gmail.com>
In-Reply-To: <538CAAA6.90509@gmail.com>
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
X-archive-position: 40414
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

Good point. Would adding !cpu_has_ic_fills_f_dc as an extra condition in set_pte_at be sufficient to address your concern ?

BR,
 Lars

> -----Original Message-----
> From: David Daney [mailto:ddaney.cavm@gmail.com]
> Sent: den 2 juni 2014 18:48
> To: Lars Persson
> Cc: linux-mips@linux-mips.org; Lars Persson
> Subject: Re: [PATCH] MIPS: Remove race window in page fault handling
> 
> On 05/31/2014 03:36 AM, Lars Persson wrote:
> > Multicore MIPSes without I/D hardware coherency suffered from a race
> > condition in the page fault handler. The page table entry was
> > published before any pending lazy D-cache flush was committed, hence
> > it allowed execution of stale page cache data by other VPEs in the
> system.
> >
> 
> Shouldn't this only be done on machines that suffer from the problem?
> 
> There are many SMP MIPS machines that don't need this, so they
> shouldn't have to pay the price for doing this.
> 
> David Daney
> 
> 
