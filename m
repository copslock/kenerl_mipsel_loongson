Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2018 12:44:03 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993981AbeIQKnvj28J- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Sep 2018 12:43:51 +0200
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3BC9140C;
        Mon, 17 Sep 2018 10:43:45 +0000 (UTC)
Subject: Patch "MIPS: mscc: ocelot: fix length of memory address space for MIIM" has been added to the 4.18-stable tree
To:     alexander.levin@microsoft.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, mark.rutland@arm.com,
        paul.burton@mips.com, quentin.schulz@bootlin.com,
        ralf@linux-mips.org, robh+dt@kernel.org,
        thomas.petazzoni@bootlin.com
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 17 Sep 2018 12:39:49 +0200
Message-ID: <153718078920666@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66364
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

    MIPS: mscc: ocelot: fix length of memory address space for MIIM

to the 4.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-mscc-ocelot-fix-length-of-memory-address-space-for-miim.patch
and it can be found in the queue-4.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
