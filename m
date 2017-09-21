Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2017 16:51:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53268 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994625AbdIUOvU0E5s8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Sep 2017 16:51:20 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v8LEpIHA032751;
        Thu, 21 Sep 2017 16:51:18 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v8LEpCm0032740;
        Thu, 21 Sep 2017 16:51:12 +0200
Date:   Thu, 21 Sep 2017 16:51:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Remove unused variable 'lastpfn'
Message-ID: <20170921145112.GA32013@linux-mips.org>
References: <1505494975-22887-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505494975-22887-1-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60100
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

On Fri, Sep 15, 2017 at 12:02:55PM -0500, Steven J. Hill wrote:

> From: "Steven J. Hill" <Steven.Hill@cavium.com>
> 
> 'lastpfn' is never used for anything. Remove it.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>

This cleanup patch is an excellent demonstration why I hate __maybe_unused.

Thanks, applied.

  Ralf
