Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jun 2018 10:55:01 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992634AbeFCIyxyApza (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jun 2018 10:54:53 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 014FF2089E;
        Sun,  3 Jun 2018 08:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528016087;
        bh=4uLV/P+o3+xLuHd151fZdJm0H+zAYiIrdnxNb9I+hPM=;
        h=Subject:To:Cc:From:Date:From;
        b=YIDjQDn0rKBaj7EAT24tHbjFDeNreeqZgYTMidNnQwqt2ZM2C0D1m55cIe2V4Q8L9
         Ca1HQ3zdlT+O6LVRHqfnkZcXGSTeS2mh2b8amr4cQQqzu6oyjUuYXd5AvdSu1+TQ5H
         rO5Ar4qWA0/V/0UVrEJcL87m4ggDU346UyUw6Zg0=
Subject: Patch "MIPS: lantiq: gphy: Drop reboot/remove reset asserts" has been added to the 4.14-stable tree
To:     dev@kresin.me, gregkh@linuxfoundation.org, hauke@hauke-m.de,
        jhogan@kernel.org, john@phrozen.org, linux-mips@linux-mips.org,
        martin.blumenstingl@googlemail.com
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 03 Jun 2018 10:53:56 +0200
Message-ID: <152801603657103@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <SRS0=GHQf=IV=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64159
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

    MIPS: lantiq: gphy: Drop reboot/remove reset asserts

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-lantiq-gphy-drop-reboot-remove-reset-asserts.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
