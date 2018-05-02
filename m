Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2018 21:06:37 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992966AbeEBTGKS0yxo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 May 2018 21:06:10 +0200
Received: from localhost (unknown [104.132.1.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 125D9238FA;
        Wed,  2 May 2018 19:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525287964;
        bh=NWvIb+29R/B/1reQ7OV4lJ4m0M4QW0jRZx8HKId5/b8=;
        h=Subject:To:Cc:From:Date:From;
        b=JME5BabD/qyfs3iu+voDFwl6/9EQoQaZI8OYv/aSLpDOAhSX3wguQUbfY1Pq9ua+C
         o1ZonRl3ILYsh0hiPE3YHb8ClgQqA9Ib2bUsoSEwjEeEX1zifg7W3CodFTTqB3OOVn
         21bp8vyT47avQMh/W/cfFUjOfcxM2F5yk2vkSDuY=
Subject: Patch "MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset" has been added to the 4.4-stable tree
To:     alexander.levin@microsoft.com, dev@kresin.me,
        gregkh@linuxfoundation.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 02 May 2018 12:04:08 -0700
Message-ID: <1525287848168136@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=nwvz=HV=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63845
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

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-ath79-fix-ar724x_pll_reg_pcie_config-offset.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
