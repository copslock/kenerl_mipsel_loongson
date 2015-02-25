Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 15:42:31 +0100 (CET)
Received: from ec2-54-201-57-178.us-west-2.compute.amazonaws.com ([54.201.57.178]:51357
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007100AbbBYOmalVR2P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 15:42:30 +0100
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 43EAC4B7BF; Wed, 25 Feb 2015 14:41:28 +0000 (UTC)
Date:   Wed, 25 Feb 2015 14:41:28 +0000
From:   dwalker@fifo99.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: octeon disable SWIOTLB
Message-ID: <20150225144128.GB27513@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45958
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

Back in 2010 you made CONFIG_SWIOTLB mandatory (commit b93b2a). This prevents the Continuous
memory allocation from being enabled. Would you be willing to accept a patch which allows 
this option to be disabled if CONFIG_EXPERT is set? I suspect some users of Octeon can
review their hardware to be sure it's save to do.

Daniel
