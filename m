Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Aug 2018 09:35:52 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47576 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991808AbeHZHfqyBFrn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 Aug 2018 09:35:46 +0200
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4982A80;
        Sun, 26 Aug 2018 07:35:39 +0000 (UTC)
Subject: Patch "Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"" has been added to the 4.9-stable tree
To:     alexander.levin@microsoft.com, chris.packham@alliedtelesis.co.nz,
        gregkh@linuxfoundation.org, hauke@hauke-m.de,
        ikegami@allied-telesis.co.jp, jhogan@kernel.org,
        linux-mips@linux-mips.org, michael@michaelmarley.com,
        paul.burton@mips.com, rafal@milecki.pl, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 26 Aug 2018 09:16:50 +0200
Message-ID: <1535267810214214@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65735
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

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-mips-bcm47xx-enable-74k-core-externalsync-for-pcie-erratum.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
