Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2018 01:20:14 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993052AbeKNAT0nMg7G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Nov 2018 01:19:26 +0100
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76A0F2250E;
        Wed, 14 Nov 2018 00:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542154765;
        bh=unDw5+AJlmZJ5kPgZBsf/NL3Jive1s89maPuLAy4YNI=;
        h=Subject:To:Cc:From:Date:From;
        b=bDqnPlOLfSAL0fCI6HwYgFpM/RQx/0MfxWkfZyXHWTXmUtgYXxUsQUWUd2aAIWk0h
         JY3tu7jwAQlcYFliWXgXZwnTMb5Y3pVBaIOC8cYTiF95tjLC1H2PQxBx4VURYAWi1i
         noSJ31RvAmQl7UdR46XfFCjyno9BWT2avWdL+Hvw=
Subject: Patch "MIPS: kexec: Mark CPU offline before disabling local IRQ" has been added to the 4.4-stable tree
To:     dzhu@wavecomp.com, gregkh@linuxfoundation.org,
        linux-mips@linux-mips.org, paul.burton@mips.com,
        pburton@wavecomp.com, rachel.mozes@intel.com, ralf@linux-mips.org,
        sashal@kernel.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 13 Nov 2018 16:19:16 -0800
Message-ID: <15421547564792@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=PMNE=NZ=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67279
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

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-kexec-mark-cpu-offline-before-disabling-local-irq.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
