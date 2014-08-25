Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 13:27:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51568 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006709AbaHYL1zfGNPS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 13:27:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PBRtkX027628;
        Mon, 25 Aug 2014 13:27:55 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PBRsGs027627;
        Mon, 25 Aug 2014 13:27:54 +0200
Date:   Mon, 25 Aug 2014 13:27:54 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     joe@perches.com, kernel-janitors@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] MIPS: BCM63xx: delete double assignment
Message-ID: <20140825112754.GE27724@linux-mips.org>
References: <1408818808-18850-1-git-send-email-Julia.Lawall@lip6.fr>
 <1408818808-18850-5-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408818808-18850-5-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42216
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

On Sat, Aug 23, 2014 at 08:33:25PM +0200, Julia Lawall wrote:

> Delete successive assignments to the same location.  In each case, the
> duplicated assignment is modified to be in line with other nearby code.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)

Looking good, applied.

Thanks,

  Ralf
