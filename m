Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 14:57:36 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57285 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822305Ab3KGN5eZLZDI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 14:57:34 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id rA7DvWWv009820;
        Thu, 7 Nov 2013 14:57:32 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id rA7DvWUe009819;
        Thu, 7 Nov 2013 14:57:32 +0100
Date:   Thu, 7 Nov 2013 14:57:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/6] FP improvements
Message-ID: <20131107135732.GA13331@linux-mips.org>
References: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38477
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

On Thu, Nov 07, 2013 at 12:48:27PM +0000, Paul Burton wrote:

> This series includes a few improvements to floating point support. The
> first 2 patches add support for missing instructions to the FPU
> emulator. The 3rd is a small cleanup. The 4th introduces support for
> O32 binaries using 64-bit floating point. The 5th modifies the FPU
> emulator to stop executing code from the user stack. The 6th & final
> patch is not strictly FP-related but is a consequence of the 5th patch,
> and allows us to mark the stack & allocated heap memory as
> non-executable by default.

Very interesting, in particular #5.  More once I've me and others had a
chance to review the series.

  Ralf
