Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 17:10:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48906 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012316AbaJ3QKeTx0Mw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Oct 2014 17:10:34 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9UGAWsj016682;
        Thu, 30 Oct 2014 17:10:32 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9UGASS1016681;
        Thu, 30 Oct 2014 17:10:28 +0100
Date:   Thu, 30 Oct 2014 17:10:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Isamu Mogi <isamu@leafytree.jp>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] MIPS: R3000: Fix debug output for Virtual page
 number
Message-ID: <20141030161028.GE20282@linux-mips.org>
References: <1410278429-8541-1-git-send-email-isamu@leafytree.jp>
 <1414674458-7583-1-git-send-email-isamu@leafytree.jp>
 <1414674458-7583-2-git-send-email-isamu@leafytree.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414674458-7583-2-git-send-email-isamu@leafytree.jp>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43787
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

On Thu, Oct 30, 2014 at 10:07:36PM +0900, Isamu Mogi wrote:

> Virtual page number of R3000 in entryhi is 20 bit from MSB. But in
> dump_tlb(), the bit mask to read it from entryhi is 19 bit (0xffffe000).
> The patch fixes that to 0xfffff000.

Looks like a cut and paste issue from the R4000 code.

Will apply,

  Ralf
