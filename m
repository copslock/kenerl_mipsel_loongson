Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2017 15:08:59 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:57141 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993865AbdDENIw7hGYK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Apr 2017 15:08:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 3B386181A5;
        Wed,  5 Apr 2017 15:08:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id X-Sd0E9Nyivp; Wed,  5 Apr 2017 15:08:45 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 7DA6D180E5;
        Wed,  5 Apr 2017 15:08:45 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64DC81A064;
        Wed,  5 Apr 2017 15:08:45 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59A301A084;
        Wed,  5 Apr 2017 15:08:45 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Wed,  5 Apr 2017 15:08:45 +0200 (CEST)
Received: from lnxrabinv.se.axis.com (lnxrabinv.se.axis.com [10.88.144.1])
        by thoth.se.axis.com (Postfix) with ESMTP id 4DDA22973;
        Wed,  5 Apr 2017 15:08:45 +0200 (CEST)
Received: by lnxrabinv.se.axis.com (Postfix, from userid 10564)
        id 465CB20353; Wed,  5 Apr 2017 15:08:45 +0200 (CEST)
Date:   Wed, 5 Apr 2017 15:08:45 +0200
From:   Rabin Vincent <rabin.vincent@axis.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: cevt-r4k: fix array out-of-bounds access
Message-ID: <20170405130845.GA16092@axis.com>
References: <1491291731-5797-1-git-send-email-rabin.vincent@axis.com>
 <20170404203219.GK31606@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170404203219.GK31606@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
Return-Path: <rabin.vincent@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin.vincent@axis.com
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

On Tue, Apr 04, 2017 at 09:32:19PM +0100, James Hogan wrote:
> I think the correct fix is to prevent the read rather than change the
> size of the array. buf2[] is intentionally 3 so that out of 5 sorted
> samples the last element is the median, whereas buf1 is 4 elements so as
> to work out the 75th percentile.
> 
> When inserting the 5th sample into buf1 (i.e. j = 4), there are already
> 4 entries, so the highest element it needs to compare against is the 4th
> one (buf1[k=3]), so thats fine.
> 
> For buf2 however its still trying to insert 5 elements, so by the 5th
> one (i.e. i = 4) it may try to compare against the 4th element to know
> whether to insert before it, at which point we simply don't care about
> the ordering as its past the median.
> 
> So I think something like this would be more correct. Does that fix your
> problem?

Yes, this fixes it too.  Please feel free to submit it yourself with
your explanation.  You can add my Tested-by if you like.

Thanks.
