Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 20:42:03 +0100 (CET)
Received: from smtp.duncanthrax.net ([89.31.1.170]:41704 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991894AbcKGTlaiz658 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 20:41:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=Message-Id:Date:Subject:Cc:To:From;
        bh=D6qXamjHJgo5VVZR+Nu21DGM/ygXkHWj5y0Zdkdcqkc=; b=k638YXmtNWAhZrb29ew7N/jHb5
        CIJhxmL+Sh+oQVljBgkQ0a9hlsawyg+fop7ukL8eHMGSwL/begv7dEG69QbYZnqvT/3rrkY0vm6Cv
        vi763h6hDVR5LuQb+2shglSUBSBLu0z+OSg151Q5TtIL5613ia5Yt0yQql/bWnOsrEIM=;
Received: from hsi-kbw-109-193-239-081.hsi7.kabel-badenwuerttemberg.de ([109.193.239.81] helo=macbook.stackframe.org)
        by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <svens@stackframe.org>)
        id 1c3pnO-0003rp-2T; Mon, 07 Nov 2016 20:41:30 +0100
From:   Sven Schnelle <svens@stackframe.org>
To:     linux-mips@linux-mips.org
Cc:     svens@stackframe.org
Subject: MIPS74K dma coherence issue
Date:   Mon,  7 Nov 2016 20:41:27 +0100
Message-Id: <20161107194128.25086-1-svens@stackframe.org>
X-Mailer: git-send-email 2.10.2
Return-Path: <svens@stackframe.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svens@stackframe.org
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

Hi List,

i was debugging a nasty problem where DMA data was incorrect
after dma_unmap_single(). Reason was that cache wasn't flushed
after DMA. Attached patch fixes this.

Regards
Sven
