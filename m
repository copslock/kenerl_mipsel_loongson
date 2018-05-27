Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 May 2018 16:38:55 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:50572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990490AbeE0OisiYwPZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 May 2018 16:38:48 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2672089B;
        Sun, 27 May 2018 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527431921;
        bh=vx3I+pHliPeI0n2EFjE5WAhpyeCIAZ7rfLRpgMe+HP4=;
        h=Subject:To:Cc:From:Date:From;
        b=YNFCLPNfqCzm9aHTj+gYM3aIzHbYFDkcrfRjJqSWK6TeDRb9+nbrYQbxlP5mrjP2Q
         6gqxBNvgwP7X+2dUh152DE+T0Y/G9dbP0SSVUDDwNksAOgsmRY6sRH9U61h8XedVIA
         Kt7y6KqUbtmgptSFnyJgXG4lVAmD3C+OeRuFVCvI=
Subject: Patch "MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset" has been added to the 4.16-stable tree
To:     alexander.levin@microsoft.com, dev@kresin.me,
        gregkh@linuxfoundation.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 27 May 2018 16:32:54 +0200
Message-ID: <152743157499181@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=rI55=IO=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64065
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

to the 4.16-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-ath79-fix-ar724x_pll_reg_pcie_config-offset.patch
and it can be found in the queue-4.16 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
