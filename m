Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 May 2018 12:26:30 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:52682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994541AbeEZKY4Cijut (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 May 2018 12:24:56 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C0C2087C;
        Sat, 26 May 2018 10:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527330290;
        bh=gCMjnWLhh1wsx2uUg3IRpjk+fUYMVB6ZIo3FSd3TmSM=;
        h=Subject:To:Cc:From:Date:From;
        b=iRM/APAsHPoVbDEslVAMVnSpH0qPuvNUAdb8spN+JHLt9TwV2QtUMhqvYzWmYp9Ca
         jilOa95zwAGdscYrltmZw/vdhjyYLNDyG7KNlDLQsJy/Qi7h8ERew43HmC9Qv9WK19
         2Mf2byixYhxb5TgnBysPhOp0Kqr1lv59tW0OUfrk=
Subject: Patch "KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"" has been added to the 4.16-stable tree
To:     colin.king@canonical.com, gregkh@linuxfoundation.org,
        jhogan@kernel.org, linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 May 2018 12:23:50 +0200
Message-ID: <1527330230191216@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=Dqjb=IN=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64052
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

    KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"

to the 4.16-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     kvm-fix-spelling-mistake-cop_unsuable-cop_unusable.patch
and it can be found in the queue-4.16 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
