Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 09:14:51 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:42432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992916AbeE1HOoe50Ah (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 09:14:44 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3EF8208A1;
        Mon, 28 May 2018 07:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527491678;
        bh=N8qa7N9YkZwiZU4a61z01B41WezMxC/pRVoNyymc9Zo=;
        h=Subject:To:Cc:From:Date:From;
        b=RT4migXR6WisvUGYnJexcf9YH2+njsWqLC00iEp5kT9VHuyMgRhpP9EQy/bnvwnH2
         re54Un0LA0LTbHpuZ6bh/+q1m9qBCscuQvADX545mlmq4M92gwkVcRK6TcLONANrAN
         H6W7pVG4Vt7Mnn+pBavsAXPygokIYPhqNAV7z4TU=
Subject: Patch "MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset" has been added to the 3.18-stable tree
To:     alexander.levin@microsoft.com, dev@kresin.me,
        gregkh@linuxfoundation.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 28 May 2018 09:09:45 +0200
Message-ID: <152749138520532@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64081
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

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-ath79-fix-ar724x_pll_reg_pcie_config-offset.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
