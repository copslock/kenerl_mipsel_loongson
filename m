Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2018 04:28:18 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:44072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992953AbeKKD2FhK9NQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Nov 2018 04:28:05 +0100
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70642147A;
        Sun, 11 Nov 2018 03:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541906884;
        bh=tSiukV+boO2jG+/52THcZn1PIj9MADHhOnhwnfwBe0Q=;
        h=Subject:To:Cc:From:Date:From;
        b=tAWKHOCTuS1B4IehY9hI1P9yGdlZaqAyVMDgrz+0NBbPSPukIoCJV36w6/SOFFelu
         P3z35actVQZQjgAYoFQxuL1y5idIOeIHQS+8LoC0XRpnwasT/iux9p0wWvueYiQqbb
         vJQ54ZQhs+Dgo1XfeBq5IVWi89zQpZJHbPBn2ZuI=
Subject: Patch "MIPS: OCTEON: fix out of bounds array access on CN68XX" has been added to the 4.4-stable tree
To:     aaro.koskinen@iki.fi, gregkh@linuxfoundation.org,
        linux-mips@linux-mips.org, paul.burton@mips.com,
        ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 10 Nov 2018 18:08:31 -0800
Message-ID: <1541902111156239@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=XqPF=NW=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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


This is a note to let you know that I've just added the patch titled

    MIPS: OCTEON: fix out of bounds array access on CN68XX

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-octeon-fix-out-of-bounds-array-access-on-cn68xx.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
