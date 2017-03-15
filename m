Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 16:29:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39200 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992028AbdCOP1yiDCqV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 16:27:54 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2FDFij3007073;
        Wed, 15 Mar 2017 14:15:45 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2FDFiwu007072;
        Wed, 15 Mar 2017 14:15:44 +0100
Date:   Wed, 15 Mar 2017 14:15:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>
Subject: Re: [PATCH] MIPS: cavium-octeon: Remove vestiges of
 CONFIG_CAVIUM_OCTEON_2ND_KERNEL
Message-ID: <20170315131544.GC5512@linux-mips.org>
References: <20170217194555.11407-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217194555.11407-1-david.daney@cavium.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57295
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

On Fri, Feb 17, 2017 at 11:45:55AM -0800, David Daney wrote:

> This config option never really worked, and has bit-rotted to the
> point of being completely useless.  Remove it completely.

Thanks, queued for 4.12.

  Ralf
