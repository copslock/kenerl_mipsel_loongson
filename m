Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2018 02:22:03 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993097AbeKNBVzHQvtZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Nov 2018 02:21:55 +0100
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F68C22555;
        Wed, 14 Nov 2018 01:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542158514;
        bh=zfPuZ1Kknqx3c6S3aVTPcCOZ+KlqZPGq/xczTxB/4rk=;
        h=Subject:To:Cc:From:Date:From;
        b=iXrGG8zALw8IxGWnCG9bIY8Qtke4HLpv0xixyjEb7sCR9bfO3b9b1do92k44EPfxg
         RWGdQCXiVJvaRxKpgZ5FKm1yndfhDJk4o1+aQBFPGkPDHkiRSGNnl6E5E35ONDA7SS
         v8k+tUrKLx12l+yff0SvV9ypoAqWBwv+CQ/WNRoU=
Subject: Patch "MIPS: kexec: Mark CPU offline before disabling local IRQ" has been added to the 4.9-stable tree
To:     dzhu@wavecomp.com, gregkh@linuxfoundation.org,
        linux-mips@linux-mips.org, paul.burton@mips.com,
        pburton@wavecomp.com, rachel.mozes@intel.com, ralf@linux-mips.org,
        sashal@kernel.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 13 Nov 2018 17:21:51 -0800
Message-ID: <15421585118382@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=PMNE=NZ=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67282
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

    MIPS: kexec: Mark CPU offline before disabling local IRQ

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-kexec-mark-cpu-offline-before-disabling-local-irq.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
