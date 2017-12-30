Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 17:09:46 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:47077 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990424AbdL3QJhhi-Bh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Dec 2017 17:09:37 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E9CFADE8A2; Sat, 30 Dec 2017 17:09:28 +0100 (CET)
Date:   Sat, 30 Dec 2017 17:09:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Daney <ddaney@cavium.com>, Huacai Chen <chenhc@lemote.com>
Cc:     Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: mb() calls in octeon / loongson swiotlb dma_map_ops
Message-ID: <20171230160928.GB3883@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

Hi David and others,

I've recently been refactoring the dma direct mapping and swiotlb
code, and one odd thing I noticed is that the octeon and loongson
swiotlb ops have mb() calls after basically all swiotlb calls.

None of that is explained in either the earlier octeon dma map
commits, nor the commit that added the octeon swiotlb support
(b93b2abce497873be97d765b848e0a955d29f200), and neither in the
loonsoon commit that apparently copy and pasted it
(1299b0e05e106f621fff1504df5251f2a678097e).

Can someone explain what these memory barrier are supposed to do?
