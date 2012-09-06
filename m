Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2012 16:08:54 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52325 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903491Ab2IFOIp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2012 16:08:45 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q86E8i8a003430
        for <linux-mips@linux-mips.org>; Thu, 6 Sep 2012 16:08:44 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q86E8hEi003429
        for linux-mips@linux-mips.org; Thu, 6 Sep 2012 16:08:43 +0200
Date:   Thu, 6 Sep 2012 16:08:43 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Warning of gcc bugs affecting kernel builds
Message-ID: <20120906140843.GA17068@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34434
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
Return-Path: <linux-mips-bounce@linux-mips.org>

There are two gcc bugs which are having serious impact on the kernel.

  http://gcc.gnu.org/bugzilla/show_bug.cgi?id=54369
  http://gcc.gnu.org/bugzilla/show_bug.cgi?id=54494

Afaics the first one affects SPARC and MIPS in versions 4.5 ... 4.7.1
while the second one affects all architectures but is specific to
gcc 4.7.0 and 4.7.1.

  Ralf
