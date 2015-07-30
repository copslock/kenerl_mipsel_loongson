Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2015 16:32:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45851 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011804AbbG3Oc4U6mhM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Jul 2015 16:32:56 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6UEWrA8014995;
        Thu, 30 Jul 2015 16:32:53 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6UEWqUW014994;
        Thu, 30 Jul 2015 16:32:52 +0200
Date:   Thu, 30 Jul 2015 16:32:52 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 6/6] mips: Add entry for new mlock2 syscall
Message-ID: <20150730143252.GF25552@linux-mips.org>
References: <1438184575-10537-1-git-send-email-emunson@akamai.com>
 <1438184575-10537-7-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438184575-10537-7-git-send-email-emunson@akamai.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48504
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

On Wed, Jul 29, 2015 at 11:42:55AM -0400, Eric B Munson wrote:

> A previous commit introduced the new mlock2 syscall, add entries for the
> MIPS architecture.

Looking good, so

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Recently somebody else was floating around a patch that was adding
three syscalls.  Not sure if in the end the adding the syscall part to
non-x86 was dropped.  Just mentioning in case there are any conflicts;
in particulary nobody should rely on syscall numbers unless they're
for something in Linus' tree!

  Ralf
