Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Jun 2016 20:41:53 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:49954 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042264AbcFDSlckUzwq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Jun 2016 20:41:32 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF23D94C;
        Sat,  4 Jun 2016 18:41:24 +0000 (UTC)
Subject: Patch "MIPS: lib: Mark intrinsics notrace" has been added to the 4.6-stable tree
To:     harvey.hunt@imgtec.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 04 Jun 2016 11:41:23 -0700
Message-ID: <146506568321020@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53810
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

    MIPS: lib: Mark intrinsics notrace

to the 4.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-lib-mark-intrinsics-notrace.patch
and it can be found in the queue-4.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
