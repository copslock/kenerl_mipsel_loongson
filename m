Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 13:16:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37544 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007012AbaH0LQR6r2Pb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Aug 2014 13:16:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7RBGHLw014080;
        Wed, 27 Aug 2014 13:16:17 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7RBGG9o014079;
        Wed, 27 Aug 2014 13:16:16 +0200
Date:   Wed, 27 Aug 2014 13:16:16 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/4] Add pgprot_writecombine function for MIPS
Message-ID: <20140827111616.GA14026@linux-mips.org>
References: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42277
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

On Fri, Jul 18, 2014 at 10:51:29AM +0100, Markos Chandras wrote:

> This patchset implements the pgprot_writecombine function for MIPS
> 
> Markos Chandras (4):
>   MIPS: pgtable-bits: Move the CCA bits out of the core's ifdef blocks
>   MIPS: pgtable-bits: Define the CCA bit for WC writes on Ingenic cores
>   MIPS: cpu-probe: Set the write-combine CCA value on per core basis
>   MIPS: pgtable.h: Implement the pgprot_writecombine function for MIPS

A good thing - but I'd really like to see the entire long-winded #ifdefed
list of cache modes in <asm/pgtable-bits.h> to be removed but I guess
that's left for a future patch.

  Ralf
