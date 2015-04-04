Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 22:05:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60804 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010451AbbDDUE7dBQ87 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Apr 2015 22:04:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t34K50ph010040;
        Sat, 4 Apr 2015 22:05:00 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t34K4xRn010039;
        Sat, 4 Apr 2015 22:04:59 +0200
Date:   Sat, 4 Apr 2015 22:04:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 00/48] FPU and FP emulation clean-ups, fixes and feature
 updates
Message-ID: <20150404200459.GE20157@linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46779
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

On Fri, Apr 03, 2015 at 11:23:29PM +0100, Maciej W. Rozycki wrote:

>  These are fixes to address code structuring and coding style problems 
> and then bug fixes I discovered in the course of implementing an 
> upcoming FPU feature.  There are some minor feature updates too.  They 
> are related to one another to a various extent, sometimes very loosely, 
> but I decided to keep them as a series because there is a lot of 
> syntactical overlap, as changes are made in steps, one issue at a time.  
> Keeping them in order guarantees that they apply on top of one another.
> 
>  Clean-ups come first as they should be completely uncontroversial, 
> followed by restructuring, bug fixes and new features.

It would have been nice if the bug fixes or at least those relevant to
4.0 and older were at the beginning to reduce issue when applying them
to the 4.0-fixes and possibly -stable branches.

I applied your patches on top of my working branch and ran into a number
of conflicts.  Will push the result out as soon as I'm done with the
conflict resolution.

Thanks!

  Ralf
