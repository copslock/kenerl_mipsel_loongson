Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2018 13:33:30 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:57388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993961AbeFQLczi3KQV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Jun 2018 13:32:55 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3672A208D5;
        Sun, 17 Jun 2018 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529235169;
        bh=2rDxLE8XBnWM0Sw39L21o+HWr/C1Z1bT9n9aIXX4QCY=;
        h=Subject:To:Cc:From:Date:From;
        b=tj01Y6H329RR35vRTSRi9JI29yIaogRvEhhu13ytE+KNpZr5FSYT4MtsHhMTzOqcN
         ydi/VcRcsVVCyy9XT/ebTWJzK4vm+gvstWDZSs3qPpqI48+kG13QjfNO8xDgbSc3MI
         ZV54wR2xTpPMjG0Qf5wJFVuXlu8gygkv4M93gAas=
Subject: Patch "MIPS: io: Prevent compiler reordering writeX()" has been added to the 4.14-stable tree
To:     alexander.levin@microsoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, okaya@codeaurora.org,
        paul.burton@mips.com, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 17 Jun 2018 13:23:25 +0200
Message-ID: <152923460525046@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=nXdS=JD=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64333
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

    MIPS: io: Prevent compiler reordering writeX()

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-io-prevent-compiler-reordering-writex.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
