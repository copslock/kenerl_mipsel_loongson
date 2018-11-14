Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2018 02:21:45 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993070AbeKNBVkGIVGZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Nov 2018 02:21:40 +0100
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0A7223DD;
        Wed, 14 Nov 2018 01:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542158499;
        bh=J4IC87D8IvS97obdAXNQ8Z7mauVi8MMqj+RSpG8Lb/Q=;
        h=Subject:To:Cc:From:Date:From;
        b=GeYJBs08fapJnN9DXm6RianVmw4OmDIu7jrlTemCEsR4jsMaztu/nh6zdrS4uYV0e
         gePCklWbz7HvSnMLrMtiiP1J2aQ/NsZxkavXHCLZbxClftSeiXN/fWVBpDS0Tc2OgK
         sXIg9KvL1nIH0OEAIJb/sLEFgCprqGZKju+hpgr4=
Subject: Patch "MIPS/PCI: Call pcie_bus_configure_settings() to set MPS/MRRS" has been added to the 4.18-stable tree
To:     chenhc@lemote.com, chenhuacai@gmail.com,
        gregkh@linuxfoundation.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, paul.burton@mips.com,
        ralf@linux-mips.org, sashal@kernel.org, wuzhangjin@gmail.com,
        zhangfx@lemote.com
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 13 Nov 2018 17:21:32 -0800
Message-ID: <154215849222735@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=PMNE=NZ=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67280
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

    MIPS/PCI: Call pcie_bus_configure_settings() to set MPS/MRRS

to the 4.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-pci-call-pcie_bus_configure_settings-to-set-mps-mrrs.patch
and it can be found in the queue-4.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
