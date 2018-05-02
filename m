Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2018 20:26:06 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:46400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992828AbeEBSZoqscXo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 May 2018 20:25:44 +0200
Received: from localhost (unknown [104.132.1.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A91F23967;
        Wed,  2 May 2018 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525285537;
        bh=xX5VqguuZl3oUgn8p69GQEID/b32g86gdAMu+VijnwY=;
        h=Subject:To:Cc:From:Date:From;
        b=YFyAWZtdKxYWkLCyTPqsr0qgPTBndld7RSCV5sjfETu6ecWfASnfVOGzB/zgqdYod
         2ogXgjfiDM+ii4nnEWC2DVgDkSx6JIBDFihFIs5I1FKeIVFoT7CmTm5wSBT2ZYeHyG
         6gTstMMd1CwDXJEZwIwnAA2E3zJXufWYRFq175hI=
Subject: Patch "MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset" has been added to the 4.9-stable tree
To:     alexander.levin@microsoft.com, dev@kresin.me,
        gregkh@linuxfoundation.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 02 May 2018 11:16:41 -0700
Message-ID: <152528500118115@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=nwvz=HV=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63840
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

    MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-ath79-fix-ar724x_pll_reg_pcie_config-offset.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
