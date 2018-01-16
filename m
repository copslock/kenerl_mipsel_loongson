Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 16:49:12 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:40360 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994651AbeAPPsOi2lLE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 16:48:14 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v7 00/14] JZ4770 and GCW0 patchset
Date:   Tue, 16 Jan 2018 16:47:50 +0100
Message-Id: <20180116154804.21150-1-paul@crapouillou.net>
In-Reply-To: <20180105182513.16248-2-paul@crapouillou.net>
References: <20180105182513.16248-2-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1516117692; bh=HPHOGtnPq2rnWlOmj5B9YT4KP2giQQSPt+rFg4MoubQ=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sjKh8ReqAT162kkg6BydDjULaJY3mWACYvspJzMeBdoRs31689fC+k5smA3ghR6RIfwjxFr6chMLyLqLcJ7IhSHENaJZPe6v5AWuGKVS6JwRe43yF/qkH2zflkShaD6Lhq10hPFU8j867S3S5FMvxkuUiFqgr9dPdinYLRD+aF8=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi Ralf,

Here is the V7 of my JZ4770 and GCW0 patch series.

What changed from V6:
- In patch 10/14 I reverted a change that prevented the system
  name/model from being correctly initialized
- The patch dealing with the MMC DMA hardware issue has been dropped,
  since we couldn't reproduce the corruption issue. I can always send a
  separate patch if we find a way to reliably trigger the bug.
- All the rest is untouched.

Greetings,
-Paul
