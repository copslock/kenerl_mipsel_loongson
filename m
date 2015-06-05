Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 12:28:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51668 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007438AbbFEK2tbwd0c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jun 2015 12:28:49 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t55ASmno000398;
        Fri, 5 Jun 2015 12:28:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t55ASmw4000397;
        Fri, 5 Jun 2015 12:28:48 +0200
Date:   Fri, 5 Jun 2015 12:28:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: optimise non-EVA kernel user memory accesses
Message-ID: <20150605102847.GB26432@linux-mips.org>
References: <1432481504-24698-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432481504-24698-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47882
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

On Sun, May 24, 2015 at 04:31:44PM +0100, Paul Burton wrote:
> Date:   Sun, 24 May 2015 16:31:44 +0100
> From: Paul Burton <paul.burton@imgtec.com>
> To: linux-mips@linux-mips.org
> CC: Paul Burton <paul.burton@imgtec.com>, Markos Chandras
>  <markos.chandras@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>,
>  linux-kernel@vger.kernel.org

Thanks, applied.

Btw, I don't think such deeply MIPS-specific patches need to be cc'ed to
lkml.  That list's volume is already high enough as it is.

  Ralf
