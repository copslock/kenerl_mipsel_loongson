Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 May 2018 12:26:45 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:52718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993973AbeEZKY6fMNwe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 May 2018 12:24:58 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F8C20883;
        Sat, 26 May 2018 10:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527330292;
        bh=y83nPj+vqWlOO73fHLvjK5HbOS013Fgara5NwvwbmD0=;
        h=Subject:To:Cc:From:Date:From;
        b=fPuSeGOBOdMipnfM/6FjoIrW71yOzjlhGpeJ5RFoq31pdyrhu2nyYAJBXYhcFRw3g
         5eYdD2sYyhhX7MxpNPZl1yb/h0ofCNprmuC3g3Ci/EJuV+xZmIJrnYIz4gLWqUVUdZ
         7IQ3FRLohSwvaGSXCMDXpKMhI1fMBcfRga6KST2Y=
Subject: Patch "MIPS: xilfpga: Actually include FDT in fitImage" has been added to the 4.16-stable tree
To:     alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
        jhogan@kernel.org, linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 May 2018 12:23:51 +0200
Message-ID: <1527330231176225@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=Dqjb=IN=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64053
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

    MIPS: xilfpga: Actually include FDT in fitImage

to the 4.16-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-xilfpga-actually-include-fdt-in-fitimage.patch
and it can be found in the queue-4.16 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
