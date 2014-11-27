Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2014 10:05:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49184 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007164AbaK0JFY5c-2v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Nov 2014 10:05:24 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAR95OKE016602
        for <linux-mips@linux-mips.org>; Thu, 27 Nov 2014 10:05:24 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAR95OUM016601
        for linux-mips@linux-mips.org; Thu, 27 Nov 2014 10:05:24 +0100
Date:   Thu, 27 Nov 2014 10:05:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: [ADMIN] Gitweb to cgit migration at linux-mips.org
Message-ID: <20141127090523.GG23961@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44483
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

Last night I've switched git.linux-mips.org from gitweb to cgit.  For
those who don't know cgit yet - it essentially does the same thing than
gitweb but has a slightly more modern look and more importantly is much
faster than gitweb.

There is a redirection to ensure old gitweb URLs from emails, web pages etc
will continue to function.

Please report any problems to me.

  Ralf
