Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:25:54 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:35252 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992368AbeAESZWfZXis (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 19:25:22 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v6 00/15] JZ4770 SoC support
Date:   Fri,  5 Jan 2018 19:24:58 +0100
Message-Id: <20180105182513.16248-1-paul@crapouillou.net>
In-Reply-To: <20180102150848.11314-1-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1515176720; bh=Drj/JLLEmyRJnWl/SIFKxKNXyBGrDlmHk9TuGWKpI7s=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=C95Jxxmhx5pmx9KJqUItHuuR3/7ZAKHqgLfisyuwIdF9UtrvJz7HiP7nnbTEJU31I6yndFZdDyMdtQ2FtKM7eajxp5/21F43LRa9qcGuVCqwf8KIP9+54gu7Mf64Tq5PtEjuBatq/6Rh/ypLbsJgE6wGAfwthRngS5clP/XGb0U=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61922
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

This is the V6 (and hopefully last) version of my JZ4770 patchset.

- In patches 07-08/15 I simply updated Paul Burton's email address
  from @imgtec.com to @mips.com.
- Patch 10/15 changed, now I only init mips_machtype from devicetree
  instead of using MIPS_MACHINE in platform code, as suggested by
  Prasanna Kumar.
- Patch 15/15 has a minor addition, I added a "model" property in the
  devicetree.

The rest (patches 01->06, 09, 11->14) are untouched.

Greetings,
Paul
