Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2018 16:15:53 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:55398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992494AbeH1OPozZoGt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Aug 2018 16:15:44 +0200
Received: from localhost (unknown [104.153.224.167])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 84573D08;
        Tue, 28 Aug 2018 14:15:36 +0000 (UTC)
Subject: Patch "Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"" has been added to the 3.18-stable tree
To:     alexander.levin@microsoft.com, chris.packham@alliedtelesis.co.nz,
        gregkh@linuxfoundation.org, hauke@hauke-m.de,
        ikegami@allied-telesis.co.jp, jhogan@kernel.org,
        linux-mips@linux-mips.org, michael@michaelmarley.com,
        paul.burton@mips.com, rafal@milecki.pl, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 28 Aug 2018 16:10:01 +0200
Message-ID: <1535465401164118@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65759
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

    Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-mips-bcm47xx-enable-74k-core-externalsync-for-pcie-erratum.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
