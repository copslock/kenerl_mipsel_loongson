Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2017 16:49:31 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992881AbdD0OtW6YNX2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Apr 2017 16:49:22 +0200
Received: from localhost (unknown [166.177.184.243])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 277CBB8E;
        Thu, 27 Apr 2017 14:49:11 +0000 (UTC)
Subject: Patch "MIPS: MSP71xx: remove odd locking in PCI config space access code" has been added to the 3.18-stable tree
To:     ryazanov.s.a@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 27 Apr 2017 16:29:00 +0200
Message-ID: <1493303340209136@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57799
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

    MIPS: MSP71xx: remove odd locking in PCI config space access code

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-msp71xx-remove-odd-locking-in-pci-config-space-access-code.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
