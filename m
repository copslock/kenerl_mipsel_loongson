Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Apr 2017 21:35:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57092 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993930AbdDLTfts3Udg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Apr 2017 21:35:49 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3CJZlJP030913;
        Wed, 12 Apr 2017 21:35:47 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3CJZlri030912;
        Wed, 12 Apr 2017 21:35:47 +0200
Date:   Wed, 12 Apr 2017 21:35:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MIPS: smp-cps: Fix potentially uninitialised value of
 core
Message-ID: <20170412193547.GA30909@linux-mips.org>
References: <1490957468-27255-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490957468-27255-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Thanks, applied.

  Ralf
