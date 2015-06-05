Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 10:11:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49964 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007245AbbFEILCzL0aU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jun 2015 10:11:02 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t558B1eG030216;
        Fri, 5 Jun 2015 10:11:01 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t558B1jS030215;
        Fri, 5 Jun 2015 10:11:01 +0200
Date:   Fri, 5 Jun 2015 10:11:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Adam Jiang <jiang.adam@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix enabling of DEBUG_STACKOVERFLOW
Message-ID: <20150605081100.GS26432@linux-mips.org>
References: <1433420727-19484-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433420727-19484-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47872
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

On Thu, Jun 04, 2015 at 01:25:27PM +0100, James Hogan wrote:

Thanks, applied.  Should hopefully go to Linus tonight.

  Ralf
