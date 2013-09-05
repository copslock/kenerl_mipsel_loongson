Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 20:08:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39818 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6837142Ab3IESI0H0BcN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Sep 2013 20:08:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r85I8PC1013871;
        Thu, 5 Sep 2013 20:08:25 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r85I8PSM013870;
        Thu, 5 Sep 2013 20:08:25 +0200
Date:   Thu, 5 Sep 2013 20:08:25 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: DECstation HRT calibration bug fixes
Message-ID: <20130905180825.GB11592@linux-mips.org>
References: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37762
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

On Wed, Sep 04, 2013 at 11:47:45PM +0100, Maciej W. Rozycki wrote:

> This change corrects DECstation HRT calibration, by removing the following 
> bugs:

Hmm...  Seems this needs to be applied to virtually every older kernel
as well almost back to the dawn?

Great to see you backon the DECstations!

  Ralf
