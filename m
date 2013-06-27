Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 13:59:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52282 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824780Ab3F0L7iasnY4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 13:59:38 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5RBxakb008109;
        Thu, 27 Jun 2013 13:59:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5RBxY0I008108;
        Thu, 27 Jun 2013 13:59:34 +0200
Date:   Thu, 27 Jun 2013 13:59:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Cc:     linux-mips@linux-mips.org, kevink@paralogos.com,
        macro@linux-mips.org, john@phrozen.org, Steven.Hill@imgtec.com
Subject: Re: [PATCH v4 3/5] MIPS: APRP (APSP): remove kspd.h
Message-ID: <20130627115934.GV7171@linux-mips.org>
References: <1365439982-4117-1-git-send-email-dengcheng.zhu@imgtec.com>
 <1365439982-4117-4-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1365439982-4117-4-git-send-email-dengcheng.zhu@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37171
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

On Mon, Apr 08, 2013 at 09:53:00AM -0700, Deng-Cheng Zhu wrote:

> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> 
> Now that KSPD is gone, kspd.h has no reason to be there.

Applied.  Thanks!

  Ralf
