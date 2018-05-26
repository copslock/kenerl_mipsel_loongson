Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 May 2018 12:24:10 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:51992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993880AbeEZKXuVI3h6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 May 2018 12:23:50 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA3020883;
        Sat, 26 May 2018 10:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527330224;
        bh=f32qq/d0GbEWyi6C57anbNjCyI1veMDZ1+qBXZrEQRY=;
        h=Subject:To:Cc:From:Date:From;
        b=kS9MkQm/NIKCRb5Mg6CpHoHPYlghfEMtyayMUkiObOkgEDsHiUEjKWDWp9imLqN+c
         qXNkwOEp4tIfWHoRJJX5Ool9OWTMBs8VyU9zzEFU3/2Y5SF4fh4Bs/BsLnFvIg/wIf
         mmig0kygBGkh0dYxK0pMBHpWKJV/J1dlKDA2+0v4=
Subject: Patch "MIPS: ptrace: Expose FIR register through FP regset" has been added to the 3.18-stable tree
To:     gregkh@linuxfoundation.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, macro@mips.com, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 May 2018 12:23:13 +0200
Message-ID: <1527330193148211@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=Dqjb=IN=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64043
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

    MIPS: ptrace: Expose FIR register through FP regset

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-ptrace-expose-fir-register-through-fp-regset.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
