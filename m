Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2018 11:39:47 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993514AbeEQJjhYBm-k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 May 2018 11:39:37 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E562084F;
        Thu, 17 May 2018 09:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526549968;
        bh=hXIVIctcRXLkSkUrfoJsfJgE5awzStgJaqs/uCPaL68=;
        h=Subject:To:Cc:From:Date:From;
        b=CdWi2HxcaryCbD3W0rcMXS3v5sgLawqOVTZQ7/YoJldEocXkDZRvgHLFm7SDuiSJd
         /sRRd+En7rZ9+ThppcpMdm6U/NO5iy2bTAHmUkv02qXfgXVxYuXQIvdtqzgi6R1E0n
         HzD0A5/sWJYNqL4mwqdVpMNbJcGCMv7hN5yJnOyY=
Subject: Patch "futex: Remove duplicated code and fix undefined behaviour" has been added to the 4.4-stable tree
To:     20170824073105.3901-1-jslaby@suse.cz, arnd@arndb.de,
        ben.hutchings@codethink.co.uk, benh@kernel.crashing.org,
        catalin.marinas@arm.com, chris@zankel.net, cmetcalf@mellanox.com,
        dalias@libc.org, davem@davemloft.net, deller@gmx.de,
        dvhart@infradead.org, fenghua.yu@intel.com,
        gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com,
        ink@jurassic.park.msu.ru, jcmvbkbc@gmail.com,
        jejb@parisc-linux.org, jonas@southpole.se, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, mattst88@gmail.com,
        monstr@monstr.eu, mpe@ellerman.id.au,
        openrisc@lists.librecores.org, paulus@samba.org,
        peterz@infradead.org, ralf@linux-mips.org, rkuo@codeaurora.org,
        rmk+kernel@armlinux.org.uk, rth@twiddle.net,
        schwidefsky@de.ibm.com, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        tony.luck@intel.com, vgupta@synopsys.com, will.deacon@arm.com,
        ysato@users.sourceforge.jp
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 17 May 2018 11:38:53 +0200
Message-ID: <15265499332582@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=CLTL=IE=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63981
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

    futex: Remove duplicated code and fix undefined behaviour

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     futex-remove-duplicated-code-and-fix-undefined-behaviour.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
