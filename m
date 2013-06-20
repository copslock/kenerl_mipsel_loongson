Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 15:55:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55780 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823058Ab3FTNzpfP8Zl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jun 2013 15:55:45 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5KDtht1028492;
        Thu, 20 Jun 2013 15:55:43 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5KDtgYS028491;
        Thu, 20 Jun 2013 15:55:42 +0200
Date:   Thu, 20 Jun 2013 15:55:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] mips: delete __cpuinit/__CPUINIT usage from MIPS code
Message-ID: <20130620135542.GB28221@linux-mips.org>
References: <1371566339-18336-1-git-send-email-paul.gortmaker@windriver.com>
 <51C22E75.3020001@gmail.com>
 <20130620002806.GA15693@windriver.com>
 <20130620021550.GA17009@linux-mips.org>
 <51C305E4.4080705@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51C305E4.4080705@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37057
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

On Thu, Jun 20, 2013 at 09:38:44AM -0400, Paul Gortmaker wrote:

> Thanks!  I realized I'd not cleaned up modpost last night while writing
> up the linux-arch mail (not yet sent) and added it to the patch queue:
> 
> http://git.kernel.org/cgit/linux/kernel/git/paulg/cpuinit-delete.git/log/
> 
> I had the dummied out init in the patch queue, but I didn't have linker
> script change yet -- I'll add that in today.

Testing this for MIPS I found that it fixes ALL the section conflicts
which I was observing (but haven't yet found the time to investigate)
until recently.  So from my point of view making __cpu{init,exec}* a no-op
is a bug fix.

  Ralf
