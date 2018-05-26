Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 May 2018 12:24:25 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:52018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993881AbeEZKXxyhVw9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 May 2018 12:23:53 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFC620890;
        Sat, 26 May 2018 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527330226;
        bh=HKMUW/IWTLIp6brnP64hPKN0wzPRZrwS/eEUk9OgdfQ=;
        h=Subject:To:Cc:From:Date:From;
        b=0vrM9hB4xdEw0O6z/JnUw4lDeiS62OdzQ4cukLbQT1aqlzpp0kZOuX30Nfbrz+HR9
         ji+RK9QUUGAiNTPs6SRW9B1KZgFiFInHHGDqZh6A/OPV/IuBuxPJdOIXlyYvkd4zQd
         J53nSDdtLDOrww38HwIr/D/WYDQ7rsv5duNMUMrg=
Subject: Patch "KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"" has been added to the 3.18-stable tree
To:     colin.king@canonical.com, gregkh@linuxfoundation.org,
        jhogan@kernel.org, linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 May 2018 12:23:13 +0200
Message-ID: <15273301931803@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=Dqjb=IN=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64044
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

    KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     kvm-fix-spelling-mistake-cop_unsuable-cop_unusable.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
