Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 14:07:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47190 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6833465Ab3AXNHIFafq- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jan 2013 14:07:08 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0OD75Ie028494;
        Thu, 24 Jan 2013 14:07:05 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0OD74Rd028493;
        Thu, 24 Jan 2013 14:07:04 +0100
Date:   Thu, 24 Jan 2013 14:07:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 15/18] MIPS: Pull in MIPS fix: fix endless loop when
 processing signals for kernel tasks.
Message-ID: <20130124130704.GA28065@linux-mips.org>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
 <1353551656-23579-16-git-send-email-sanjayl@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353551656-23579-16-git-send-email-sanjayl@kymasys.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35537
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

On Wed, Nov 21, 2012 at 06:34:13PM -0800, Sanjay Lal wrote:

> This bug is discussed in: http://lkml.indiana.edu/hypermail/linux/kernel/1205.2/00719.html

Dropped, see c90e6fbb220d44988cb65af3707367c57cdb65a8 [MIPS: Fix endless
loop when processing signals for kernel tasks].

  Ralf
