Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 09:15:06 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:42466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992936AbeE1HOq60ewh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 09:14:46 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51915208B2;
        Mon, 28 May 2018 07:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527491680;
        bh=1aEQTr4XSY0epyHVoP4XtIQwR+8oyTx58eRZTZDDZac=;
        h=Subject:To:Cc:From:Date:From;
        b=PBKvdVNwNJhoM+yA+K6jzjHdTlUh1cFNAuTOD7QhPPG82gUNVWPQrpXnFjPtO5HcZ
         GERFLRlkIOrohLRBJ1EcBz18LYFWsc1Zmi5s1ZBGlSaMgndXu/xg7HsaO4ChHp3vxB
         rIy756XNTx7XbgpJoag5mbezjnpQ3uZePwIpGX50=
Subject: Patch "MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS" has been added to the 3.18-stable tree
To:     alexander.levin@microsoft.com, gregkh@linuxfoundation.org,
        jhogan@kernel.org, linux-mips@linux-mips.org,
        matt.redfearn@mips.com, ralf@linux-mips.org
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 28 May 2018 09:09:45 +0200
Message-ID: <15274913855968@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64082
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

    MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-txx9-use-is_builtin-for-config_leds_class.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
