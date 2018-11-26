Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 08:54:09 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:58220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991923AbeKZHwXwmC4l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Nov 2018 08:52:23 +0100
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A3E20672;
        Mon, 26 Nov 2018 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543218742;
        bh=1hUT5eeQLEeE74jG2W+AI5QXmgItj6xMNPcb2OTgj9s=;
        h=Subject:To:Cc:From:Date:From;
        b=wle6efKiQnE3CS1J0cTUMd8LV5nO9vAmHrEckGkt18xNRyDCCl8E07MQ+MVqXOFrV
         3Xs1MdQRt4ph1aBowXLmu9Z0RMmblts4OFN9wDS7S9cp9zjVZ8ZQtGDNB/oFiN/ujl
         ChaH5/tIK7Mxf+UNleYdfqvpImdPBxmdqZrQYDTI=
Subject: Patch "MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver" has been added to the 4.19-stable tree
To:     aaro.koskinen@iki.fi, gregkh@linuxfoundation.org,
        jhogan@kernel.org, linux-mips@linux-mips.org, paul.burton@mips.com,
        ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 26 Nov 2018 08:50:58 +0100
Message-ID: <1543218658136254@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=UhMK=OF=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67484
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

    MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-octeon-cavium_octeon_defconfig-re-enable-octeon-usb-driver.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
