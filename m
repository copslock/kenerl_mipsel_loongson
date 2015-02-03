Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 16:32:24 +0100 (CET)
Received: from ec2-54-201-57-178.us-west-2.compute.amazonaws.com ([54.201.57.178]:33502
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014742AbbBCPcWlDYry (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Feb 2015 16:32:22 +0100
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 03BDB48128; Tue,  3 Feb 2015 15:31:00 +0000 (UTC)
Date:   Tue, 3 Feb 2015 15:31:00 +0000
From:   dwalker@fifo99.com
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: MIPS: OCTEON: Populate kernel memory from cvmx_bootmem named
 blocks.
Message-ID: <20150203153100.GB4169@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalker@fifo99.com
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


Hi,


Are you planning to upstream this mem=blocks: change?

Also this change poses a problem for machines where the bootloader can't be easily updated.
Would you be willing to accept a change to this which accepts physical address instead of
named blocks, for example "mem=phys:<size>@<address>,<size>@<address>,..." ? If not do you
have some other idea to do this without named blocks?

Thanks,

Daniel
