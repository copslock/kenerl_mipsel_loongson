Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 17:20:53 +0200 (CEST)
Received: from mail-bk0-f47.google.com ([209.85.214.47]:49113 "EHLO
        mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868729Ab3JGPUvr77EQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Oct 2013 17:20:51 +0200
Received: by mail-bk0-f47.google.com with SMTP id mx12so2652427bkb.20
        for <multiple recipients>; Mon, 07 Oct 2013 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NNug867eNAmNoGvhscwX5VBNuYtcJCILM5xYt3HQhIQ=;
        b=RU/z3xGtuquYqxRSO+4dYfC9u5ZpZ9qZ5b/u+baYfPqs7/LNJS1BJbK3TR50xVK6/9
         WmoNst7NjauwoY8XKMmCQ3JWLt1phIjCig+Kcdkm3xW+lKqAiN6P/K6XxmH2uPFkT3eM
         e8jkYE2XPYXk2CgWg+uAGo7mzME/TLx9RegWF49gPeA3aPSqI0+lGEwKq/mms99Q7E6y
         8ay/bBhaf3t6GY3bj7YGcOrMD9vNQBM79u+vJSc9wvSRoV7bjZT6TuSZlQIo9/5wD2kY
         0vMAcdINOD9tYuZj69ZPUT4mrBB7FPhukYmPwPr5vcYtm031gHSuszyFnqamenL90O/E
         uooA==
X-Received: by 10.204.228.198 with SMTP id jf6mr2416631bkb.41.1381159246432;
        Mon, 07 Oct 2013 08:20:46 -0700 (PDT)
Received: from localhost (port-46445.pppoe.wtnet.de. [46.59.230.36])
        by mx.google.com with ESMTPSA id qe6sm17521041bkb.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Oct 2013 08:20:45 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Ungerer <gerg@snapgear.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ashok Kumar <ashoks@broadcom.com>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: linux-next: build failure after merge of the mips tree
Date:   Mon,  7 Oct 2013 17:18:44 +0200
Message-Id: <1381159127-11067-2-git-send-email-treding@nvidia.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1381159127-11067-1-git-send-email-treding@nvidia.com>
References: <1381159127-11067-1-git-send-email-treding@nvidia.com>
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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

Today's linux-next merge fails to build on various default configuration
builds. This seems to be caused by the following commit:

	5395d97 MIPS: Fix start of free memory when using initrd

Looking at the patchwork URLs in that commit message, Greg's original
patch seems to have been fine, but Ashok's patch uses the initrd_end
symbol outside of the section protected by an CONFIG_BLK_DEV_INITRD
#ifdef and therefore causes to fail during linking.

I've reverted the patch in today's linux-next tree.

Thierry
