Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Sep 2012 21:27:25 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:52733 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903266Ab2IIT1V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Sep 2012 21:27:21 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1TAnCq-0003wj-00
        for linux-mips@linux-mips.org; Sun, 09 Sep 2012 19:30:08 +0000
Date:   Sun, 9 Sep 2012 15:30:08 -0400
To:     linux-mips@linux-mips.org
Subject: Is r25 saved across syscalls?
Message-ID: <20120909193008.GA15157@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   Rich Felker <dalias@aerifal.cx>
X-archive-position: 34446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@aerifal.cx
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
X-Status: A

Hi all,
The kernel syscall entry/exit code seems to always save and restore
r25. Is this stable/documented behavior I can rely on? If there's a
reason it _needs_ to be preserved, knowing that would help convince me
it's safe to assume it will always be done. The intended usage is to
be able to make syscalls (where the syscall # is not a constant that
could be loaded with lwi) without a stack frame, as in "move $2,$25 ;
syscall".

Rich
