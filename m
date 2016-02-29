Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Feb 2016 15:48:02 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60618 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007106AbcB2OsAMDdTO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Feb 2016 15:48:00 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1TElvHM000509;
        Mon, 29 Feb 2016 15:47:57 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1TEluG0000507;
        Mon, 29 Feb 2016 15:47:56 +0100
Date:   Mon, 29 Feb 2016 15:47:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Govindraj Raja <Govindraj.Raja@imgtec.com>
Cc:     stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3] mips: scache: fix scache init with invalid line size.
Message-ID: <20160229144756.GA23538@linux-mips.org>
References: <1456746080-29232-1-git-send-email-Govindraj.Raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456746080-29232-1-git-send-email-Govindraj.Raja@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52361
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

On Mon, Feb 29, 2016 at 11:41:20AM +0000, Govindraj Raja wrote:

> Cc: <stable@vger.kernel.org> # v4.2+

You meant 4.3+; 4.2 doesn't have a mips_sc_probe_cm3 function.  Other
than that, ok & applied.

  Ralf
