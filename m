Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 21:14:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38183 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026711AbbEOTOoag70L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 May 2015 21:14:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4FJEiRJ008141;
        Fri, 15 May 2015 21:14:44 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4FJEi9H008140;
        Fri, 15 May 2015 21:14:44 +0200
Date:   Fri, 15 May 2015 21:14:43 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH 1/2] MIPS: cpu: Alter MIPS_CPU_* definitions to fill gap
Message-ID: <20150515191443.GF2322@linux-mips.org>
References: <1431530234-32460-1-git-send-email-james.hogan@imgtec.com>
 <1431530234-32460-2-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431530234-32460-2-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47415
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

On Wed, May 13, 2015 at 04:17:13PM +0100, James Hogan wrote:

> The MIPS_CPU_* definitions accidentally missed bits 27..30 when
> MIPS_CPU_EVA was added, and further definitions have continued from
> there.
> 
> Shift all the definitions since MIPS_CPU_EVA right by 4 so there are no
> gaps.

I like the patches but I think there is a bit more cleanup to be done
here.  For one, we're using long longs to store the CPU feature flags
and while recent versions of GCC appear to be smarter, older versions
used to load both 32 bit words of a long long into a register for any
kind of arithmetic or test on the value.  So I'd be happy if we could
go back to sorting bits in an array of longs.  And then maybe use
test_bit() for testing the bits.  And use an enum to number the bits.

After solving the include ordering issue, that is ...

  Ralf
