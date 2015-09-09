Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2015 18:46:03 +0200 (CEST)
Received: from ec2-54-201-57-178.us-west-2.compute.amazonaws.com ([54.201.57.178]:50310
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008032AbbIIQqBOvx4p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Sep 2015 18:46:01 +0200
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 92DA141048; Wed,  9 Sep 2015 16:43:09 +0000 (UTC)
Date:   Wed, 9 Sep 2015 09:43:09 -0700
From:   dwalker@fifo99.com
To:     alex.smith@imgtec.com
Cc:     linux-mips@linux-mips.org
Subject: mips VDSO
Message-ID: <20150909164309.GB27534@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49152
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

I was wondering if you've made any progress on this? I was also interested in implementing a faster gettimeofday()
for mips.

Daniel
