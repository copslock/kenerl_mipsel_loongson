Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 13:10:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37331 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007010AbaH0LKNEVmOa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Aug 2014 13:10:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7RBACTY013968
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 13:10:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7RBACAi013967
        for linux-mips@linux-mips.org; Wed, 27 Aug 2014 13:10:12 +0200
Date:   Wed, 27 Aug 2014 13:10:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: [ADMIN] Patchwork works
Message-ID: <20140827111012.GA12403@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42275
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

Turns out the patchwork database's content has taken some damage in the
last week on the old machine.  Restoring a backup isn't really an option
so I'll have to painfully fix this the hard way.  While I'm doing this
patchwork might missbehave, new patches posted might be ignored or
services that using lmo's SQL server might temporarily be unavailable.  I
estimate this to be finished by about 1500Z, hopefully earlier.

  Ralf
