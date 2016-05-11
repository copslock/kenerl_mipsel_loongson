Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 14:05:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54454 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028944AbcEKMFs2AKMY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2016 14:05:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4BC5k2G017331;
        Wed, 11 May 2016 14:05:47 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4BC5iEt017330;
        Wed, 11 May 2016 14:05:44 +0200
Date:   Wed, 11 May 2016 14:05:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, fengguang.wu@intel.com,
        "stable # v4 . 4+" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Allow R6 compact branch policy to be left
 unspecified
Message-ID: <20160511120544.GM16402@linux-mips.org>
References: <1461314611-15317-1-git-send-email-paul.burton@imgtec.com>
 <alpine.DEB.2.00.1604221648580.21846@tp.orcam.me.uk>
 <20160422173245.GC2467@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160422173245.GC2467@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53363
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

I was wondering if we should simply probe for the availability of the
GCC option and not use it, if using an older GCC, then change the
help text for the option accordingly.  This approach would allow
make randconfig or similar to work as expected with older compilers.

  Ralf
