Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2016 11:01:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33666 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992897AbcHBJBWDb7ZO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2016 11:01:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u7291Joe017137;
        Tue, 2 Aug 2016 11:01:19 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u7291FAn017134;
        Tue, 2 Aug 2016 11:01:15 +0200
Date:   Tue, 2 Aug 2016 11:01:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] MIPS: Use CPHYSADDR to implement mips32 __pa
Message-ID: <20160802090115.GD15910@linux-mips.org>
References: <1455644478-23415-1-git-send-email-paul.burton@imgtec.com>
 <eb5c9780-f0ed-8a91-d727-46119e1ee192@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb5c9780-f0ed-8a91-d727-46119e1ee192@imgtec.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54391
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

On Mon, Aug 01, 2016 at 05:51:10PM +0100, Paul Burton wrote:

> Any thoughts on this one? It matters for Boston (where it affects the
> pch_gbe ethernet driver) which I'll be submitting again for the 4.9 cycle.

I'm sorry.  I meant to leave this one for a while for people to comment
but then it fell through the cracks.  Applied.

Thanks!

  Ralf
