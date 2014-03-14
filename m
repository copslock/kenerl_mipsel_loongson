Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2014 14:44:05 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46019 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823120AbaCNNoEDshHX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Mar 2014 14:44:04 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2EDKM4H015247;
        Fri, 14 Mar 2014 14:20:22 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2EDKLK0015246;
        Fri, 14 Mar 2014 14:20:21 +0100
Date:   Fri, 14 Mar 2014 14:20:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Qais Yousef <Qais.Yousef@imgtec.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] mips/include/asm/mipsregs.h: include linux/types.h
Message-ID: <20140314132021.GA8218@linux-mips.org>
References: <1386582585-20867-1-git-send-email-qais.yousef@imgtec.com>
 <392C4BDEFF12D14FA57A3F30B283D7D14152C8@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <392C4BDEFF12D14FA57A3F30B283D7D14152C8@LEMAIL01.le.imgtec.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39473
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

On Fri, Mar 14, 2014 at 12:08:13PM +0000, Qais Yousef wrote:

> Can we include this patch in the next 3.10 and forward stable releases please?
> 
> It's already in Linus' tree under commit id: 87c99203fea897fbdd84b681ad9fced2517dcf98

Sure.  I've done so for the lmo -stable branches.

  Ralf
