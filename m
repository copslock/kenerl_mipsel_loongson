Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 20:01:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39792 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6837144Ab3IESBk2f0Dw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Sep 2013 20:01:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r85I1clp013284;
        Thu, 5 Sep 2013 20:01:38 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r85I1aaM013281;
        Thu, 5 Sep 2013 20:01:36 +0200
Date:   Thu, 5 Sep 2013 20:01:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Export copy_from_user_page() (needed by lustre)
Message-ID: <20130905180136.GA11592@linux-mips.org>
References: <1378372965-27213-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1378372965-27213-1-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37761
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

On Thu, Sep 05, 2013 at 11:22:45AM +0200, Geert Uytterhoeven wrote:

> ERROR: "copy_from_user_page" [drivers/staging/lustre/lustre/libcfs/libcfs.ko] undefined!

Thanks, applied!

But I'm sort surprised to see somebody testing Lustre on MIPS :-)

  Ralf
