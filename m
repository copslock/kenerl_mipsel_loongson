Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2018 21:06:10 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992828AbeEBTGD6cAEo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 May 2018 21:06:03 +0200
Received: from localhost (unknown [104.132.1.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9952F21894;
        Wed,  2 May 2018 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525287957;
        bh=67+FKt7Fymj2hAL39KTiM82b06GIpFj81CXvJT/T/vY=;
        h=Subject:To:Cc:From:Date:From;
        b=c3z67CupPiOnXZRBr0xfoUB4/ADWELrI9AUe2WDeiS77sHVf/A75n+tyh/1TQjHkq
         CelEyz3thtOMagrFa4fqFFVs1GBeewNWTrZdD4DG1IqCbtMlBI363Y/8DVH/UB5wky
         TJXZpbih893cxD2I4CswtVfOSe0qh3MbXGnlou10=
Subject: Patch "MIPS: Octeon: Fix logging messages with spurious periods after newlines" has been added to the 4.4-stable tree
To:     alexander.levin@microsoft.com, gregkh@linuxfoundation.org,
        jhogan@kernel.org, joe@perches.com, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 02 May 2018 12:04:08 -0700
Message-ID: <152528784865169@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=nwvz=HV=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63843
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

    MIPS: Octeon: Fix logging messages with spurious periods after newlines

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-octeon-fix-logging-messages-with-spurious-periods-after-newlines.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
