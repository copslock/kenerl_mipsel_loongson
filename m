Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2011 09:35:37 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53665 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491047Ab1HKHfa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Aug 2011 09:35:30 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7B7ZUp4030391
        for <linux-mips@linux-mips.org>; Thu, 11 Aug 2011 08:35:30 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7B7ZTn0030389
        for linux-mips@linux-mips.org; Thu, 11 Aug 2011 08:35:29 +0100
Date:   Thu, 11 Aug 2011 08:35:29 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Kernel tarballs
Message-ID: <20110811073529.GA29032@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8160

the change to the new version 3.x versioning scheme made the script that
generates the kernel tarballs for linux-3.1-rc1 and later.  I just fixed
that and linux-3.1-rc1.tar.gz is now online.

Not sure who is still downloading kernel tarballs these days but anyway,
what are thoughts about moving from gzip to xz for compression and skip
over bzip2?

  Ralf
