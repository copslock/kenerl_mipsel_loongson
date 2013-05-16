Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 May 2013 22:28:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41219 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825883Ab3EPU2zrMBdY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 May 2013 22:28:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4GKSpgR002651;
        Thu, 16 May 2013 22:28:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4GKSkN3002650;
        Thu, 16 May 2013 22:28:46 +0200
Date:   Thu, 16 May 2013 22:28:46 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] Revert "MIPS: Allow ASID size to be determined at
 boot time."
Message-ID: <20130516202846.GA24568@linux-mips.org>
References: <1368478604-14732-1-git-send-email-ddaney.cavm@gmail.com>
 <1368478604-14732-2-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368478604-14732-2-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36427
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

On Mon, May 13, 2013 at 01:56:44PM -0700, David Daney wrote:

I've applied both your patches.  This should buy Steven some time to come
up with a fix.

  Ralf
