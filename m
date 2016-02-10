Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 15:08:01 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44134 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010267AbcBJOH75xWDf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Feb 2016 15:07:59 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1AE7tK9015794;
        Wed, 10 Feb 2016 15:07:55 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1AE7sgp015793;
        Wed, 10 Feb 2016 15:07:54 +0100
Date:   Wed, 10 Feb 2016 15:07:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     david.daney@cavium.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, matt.redfearn@imgtec.com
Subject: Re: [PATCH] MIPS: OCTEON: Update OCTEON_FEATURE_PCIE for Octeon III
Message-ID: <20160210140754.GC11091@linux-mips.org>
References: <1455112585-44058-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455112585-44058-1-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51972
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

On Wed, Feb 10, 2016 at 01:56:25PM +0000, Zubair Lutfullah Kakakhel wrote:

> Currently the driver tries to probe the pci driver and oops.
> 
> Add CN7XXX to case so that driver probes the pcie driver.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> Based on v4.5-rc3
> 
> Boot tested only on CN7130 based utm8.
> 
> It does not oops and proceeds with the rest of the kernel boot.

Looks sensible.  Applied to 4.0-stable+.

Thanks,

  Ralf
