Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 13:04:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52144 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824104Ab3F0LEzZu90G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 13:04:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5RB4pD0005396;
        Thu, 27 Jun 2013 13:04:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5RB4nrK005393;
        Thu, 27 Jun 2013 13:04:49 +0200
Date:   Thu, 27 Jun 2013 13:04:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org, ddaney.cavm@gmail.com,
        macro@codesourcery.com
Subject: Re: [PATCH] MIPS: micromips: Add 16-bit instruction floating point
 breakpoints.
Message-ID: <20130627110449.GS7171@linux-mips.org>
References: <1370370146-19716-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370370146-19716-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37167
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

On Tue, Jun 04, 2013 at 01:22:26PM -0500, Steven J. Hill wrote:

> This patch adds explicit support for 16-bit instruction breakpoints
> for floating point exceptions.

This patch has gone stale with a conflict in traps.c.  Can you resubmit
an updated patch?  Thanks!

  Ralf
