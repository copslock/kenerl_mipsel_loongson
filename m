Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jun 2018 10:50:52 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:51666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992634AbeFCIuphcC6a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jun 2018 10:50:45 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6052089C;
        Sun,  3 Jun 2018 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528015838;
        bh=kcgukbXon5smrAt46/TasKPJJFd+B94T38ew3LccbNg=;
        h=Subject:To:Cc:From:Date:From;
        b=0erHYLhn2fCNxWDa/Zm7fnc8I646sLm82oMW/gGjGz2rN3hwzkBeTaItx0GVivRM5
         UqhymtzyBbhbWTfROO9y+RboqpNY1khiaXhLX4znzCuDvoC8N1jr/+i1qddr4SSiX6
         P1nr+P9cuDUJP3GVFJ5ddAmfcC3R0TuDU2s/QDio=
Subject: Patch "MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests" has been added to the 4.4-stable tree
To:     gregkh@linuxfoundation.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, macro@mips.com, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 03 Jun 2018 10:50:03 +0200
Message-ID: <152801580314038@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=GHQf=IV=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64155
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

    MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-prctl-disallow-fre-without-fr-with-pr_set_fp_mode-requests.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
