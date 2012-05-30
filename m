Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2012 01:47:31 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:57374 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903594Ab2E3Xr1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 May 2012 01:47:27 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4UNlQT1011659;
        Thu, 31 May 2012 00:47:26 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4UNlPRb011658;
        Thu, 31 May 2012 00:47:25 +0100
Date:   Thu, 31 May 2012 00:47:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/5] Add explicit support YAMON firmware.
Message-ID: <20120530234725.GI30086@linux-mips.org>
References: <1338415855-11401-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1338415855-11401-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33498
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, May 30, 2012 at 05:10:50PM -0500, Steven J. Hill wrote:

>  25 files changed, 174 insertions(+), 425 deletions(-)

I like the diffstat.  251 lines less can't be that wrong :)

I'll leave that patch pending for a few days so the owners of that
other board support code have a chance to comment.

  Ralf
