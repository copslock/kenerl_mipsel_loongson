Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 08:23:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35537 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006911AbbFCGXJQG3LN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jun 2015 08:23:09 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t536N827010198
        for <linux-mips@linux-mips.org>; Wed, 3 Jun 2015 08:23:08 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t536N8iv010197
        for linux-mips@linux-mips.org; Wed, 3 Jun 2015 08:23:08 +0200
Date:   Wed, 3 Jun 2015 08:23:08 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: ADMIN: Patchwork outage
Message-ID: <20150603062308.GL26432@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47819
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

Hi,

patchwork became one of the victims of the lmo upgrade on the weekend.
Right now the web user interface of patchwork is functional but it
doesn't accept new emails from the web.  That shouldn't be too much
of an issue because you all submitted your patches in time so they
made it into patchwork before the deadline ;-)  Anything submitted
later sits safely in the list archives which will be fed to patchwork
once the issue is sorted.

  Ralf
