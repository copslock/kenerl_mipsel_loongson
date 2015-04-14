Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Apr 2015 09:30:37 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:51982 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006153AbbDNHafX4o6J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Apr 2015 09:30:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id D9A8D180D8;
        Tue, 14 Apr 2015 09:30:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id lKdrl6KYn9xt; Tue, 14 Apr 2015 09:30:30 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id 17459180C9;
        Tue, 14 Apr 2015 09:30:30 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id EC6BD1327;
        Tue, 14 Apr 2015 09:30:29 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id E0CB4BA7;
        Tue, 14 Apr 2015 09:30:29 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by thoth.se.axis.com (Postfix) with ESMTP id DE88C34005;
        Tue, 14 Apr 2015 09:30:29 +0200 (CEST)
Received: from [10.88.41.1] (10.88.41.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Tue, 14 Apr 2015 09:30:29
 +0200
Message-ID: <1428996622.9324.4.camel@lnxlarper.se.axis.com>
Subject: Re: [PATCH] MIPS: Fix HIGHMEM crash in __update_cache().
From:   Lars Persson <lars.persson@axis.com>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Tue, 14 Apr 2015 09:30:22 +0200
In-Reply-To: <552BF7F8.5020008@imgtec.com>
References: <1428672084-20676-1-git-send-email-larper@axis.com>
         <20150410134711.GC21107@linux-mips.org>
         <675481A1-B1B2-47BF-9AF9-2E7773497FEA@axis.com>
         <552BF7F8.5020008@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46864
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

On Mon, 2015-04-13 at 19:08 +0200, Steven J. Hill wrote:
> On 04/10/2015 09:31 AM, Lars Persson wrote:
> > Ralf,
> > 
> > I came to think that also non-executable mappings for highmem pages
> > could reach the flushing code in __update_cache() and trigger an
> > OOPS.
> > 
> > Until the highmem patches are merged we should block highmem pages in
> > __update_cache().  Could you add this to the patch ?
> > 
> > Sent from my iPhone
> > 
> Did you look at the patches:
> 
>    http://patchwork.linux-mips.org/patch/9284/
>    http://patchwork.linux-mips.org/patch/9285/
> 
> Your patch seems rather similar to what is found in these. I have been
> trying to get these accepted, but so far no luck.
> 
> Steve


Yes I would like to see these patches merged, they are the ones I
referred to above as "the highmem patches". I think you solve all the
highmem problems that I have observed, except for the icache coherency
race condition that is the main focus of my patch.

If you rebase your patches on top of mine I would be happy to assist
with test and reviewing. 

- Lars
