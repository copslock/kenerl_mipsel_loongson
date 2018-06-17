Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2018 13:44:05 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:40730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993941AbeFQLn6zr1CV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Jun 2018 13:43:58 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE685208E1;
        Sun, 17 Jun 2018 11:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529235832;
        bh=3N0UocDuUbDZApHj24g8O63ty65RfF/aHSszsssm/AA=;
        h=Subject:To:Cc:From:Date:From;
        b=TPUz9JGbOiS/crwUrcJYBYm2NZ7P6zw91CAqyUOO36FiULYunnEqxJ/FI5s4kwGc9
         9ZWv0CitSQEWajenk6pQprBADF7GWndRz2aK+4j4jxBFBJLCOrt2RyvYIy9uw+psF4
         Bs85DHlEnY8+GOYhOj49sYizH6wZVoJ5zyy4zooA=
Subject: Patch "MIPS: io: Add barrier after register read in readX()" has been added to the 4.16-stable tree
To:     alexander.levin@microsoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, okaya@codeaurora.org,
        paul.burton@mips.com, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 17 Jun 2018 13:23:44 +0200
Message-ID: <15292346241360@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=nXdS=JD=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64334
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

    MIPS: io: Add barrier after register read in readX()

to the 4.16-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-io-add-barrier-after-register-read-in-readx.patch
and it can be found in the queue-4.16 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
