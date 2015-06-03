Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 09:57:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36800 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007176AbbFCH5hRL4Zx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jun 2015 09:57:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t537vaX1012227;
        Wed, 3 Jun 2015 09:57:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t537va7v012226;
        Wed, 3 Jun 2015 09:57:36 +0200
Date:   Wed, 3 Jun 2015 09:57:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: c-r4k: Fix typo in probe_scache()
Message-ID: <20150603075736.GO26432@linux-mips.org>
References: <556E183A.70707@gentoo.org>
 <20150602211156.GQ29986@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150602211156.GQ29986@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47825
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

On Tue, Jun 02, 2015 at 11:11:56PM +0200, Ralf Baechle wrote:

> On Tue, Jun 02, 2015 at 04:55:22PM -0400, Joshua Kinard wrote:
> 
> > From: Joshua Kinard <kumba@gentoo.org>
> > 
> > Fixes a typo in arch/mips/mm/c-r4k.c's probe_scache().
> 
> Wow, this one must be very, very antique.

And now also applied.

  Ralf
