Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 15:10:12 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992735AbeJPNJtrVLc7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Oct 2018 15:09:49 +0200
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E74732098A;
        Tue, 16 Oct 2018 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539695383;
        bh=HRGec8Mmr4w8aPVV5M+V1svGwuxvlyDeuc136c86zlc=;
        h=Subject:To:Cc:From:Date:From;
        b=2uEt46TFYYl8nILDRc6rhs54PQZfb097OpBaGk79v0UU4DC+0HDTE9osmZj0B/Emi
         Nd08SsAxLqkWLCBVM+7f60vE/gKaS6mV6mjZYx22ftE9VP3rErdCtJd8t3LxjnpzNn
         SJbHf9iArvbxNo2aHGhRYHFYNv+/8SLcoZMuKULY=
Subject: Patch "MIPS: VDSO: Always map near top of user memory" has been added to the 4.18-stable tree
To:     chenhc@lemote.com, gregkh@linuxfoundation.org,
        linux-mips@linux-mips.org, paul.burton@mips.com
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 16 Oct 2018 15:08:57 +0200
Message-ID: <153969533721854@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=yPgj=M4=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66870
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

    MIPS: VDSO: Always map near top of user memory

to the 4.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-vdso-always-map-near-top-of-user-memory.patch
and it can be found in the queue-4.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
