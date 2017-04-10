Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 13:31:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60166 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993911AbdDJLbwApON0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Apr 2017 13:31:52 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3ABVoM4027690;
        Mon, 10 Apr 2017 13:31:50 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3ABVoWv027689;
        Mon, 10 Apr 2017 13:31:50 +0200
Date:   Mon, 10 Apr 2017 13:31:50 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Rabin Vincent <rabinv@axis.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: cevt-r4k: Fix out-of-bounds array access
Message-ID: <20170410113150.GC13627@linux-mips.org>
References: <dda2852408884df379eb1fc8ae40aceaf094be61.1491406275.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda2852408884df379eb1fc8ae40aceaf094be61.1491406275.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57631
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

On Wed, Apr 05, 2017 at 04:32:45PM +0100, James Hogan wrote:

Thanks, applied.

  Ralf
