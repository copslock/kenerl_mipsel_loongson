Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 13:02:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50320 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825697Ab3IRLCg2OASW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Sep 2013 13:02:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8IB2X8a026114;
        Wed, 18 Sep 2013 13:02:33 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8IB2WOE026113;
        Wed, 18 Sep 2013 13:02:32 +0200
Date:   Wed, 18 Sep 2013 13:02:32 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Jayachandran C." <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: mm: Use scratch for PGD when
 !CONFIG_MIPS_PGD_C0_CONTEXT
Message-ID: <20130918110232.GJ22468@linux-mips.org>
References: <1376221217-9335-1-git-send-email-jchandra@broadcom.com>
 <1376221217-9335-3-git-send-email-jchandra@broadcom.com>
 <20130917212113.GI22468@linux-mips.org>
 <20130918075940.GA10328@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130918075940.GA10328@jayachandranc.netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37841
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

On Wed, Sep 18, 2013 at 01:29:41PM +0530, Jayachandran C. wrote:

> The commit 774b6175 "MIPS: tlbex: Guard tlbmiss_handler_setup_pgd" that
> went into 3.12-rc1 takes out tlbmiss_handler_setup_pgd definition when
> CONFIG_MIPS_PGD_C0_CONTEXT is not defined. That clashes with this change
> and caused the failure.
> 
> You can revert 774b6175 before applying this and things should work, I
> had tested it with qemu on malta as well as on XLP.

Done.  Thanks!

  Ralf
