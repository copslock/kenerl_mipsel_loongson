Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2011 12:35:32 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42219 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903656Ab1LGLf2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Dec 2011 12:35:28 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pB7BZSQ2007776
        for <linux-mips@linux-mips.org>; Wed, 7 Dec 2011 11:35:28 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pB7BZRuD007774
        for linux-mips@linux-mips.org; Wed, 7 Dec 2011 11:35:27 GMT
Date:   Wed, 7 Dec 2011 11:35:27 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Patchwork
Message-ID: <20111207113527.GA7389@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5566

Account creation in patchwork was broken a long time ago and some unrelated
bug had caused a ugly junk in the listings of patches that contain
non-ASCII characters.  I've fixed both along with upgrading patchwork to
the latest and greatest version.

What this mean:

 - the junk names displayed in the listings is gone
 - you can create new patchwork accounts and use those accounts for example
   to administrate your own patches, for example when submitting a new
   version or when you discover a bug and want to withdraw a patch.

The upgrade went more than rough and involved lots of manual database
patching.  If something doesn't work right, please let me know.

Happy patchworking!

  Ralf
