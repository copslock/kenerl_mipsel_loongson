Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Oct 2014 14:29:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33518 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010782AbaJYM3zRvjQG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 25 Oct 2014 14:29:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9PCTsUT016681;
        Sat, 25 Oct 2014 14:29:54 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9PCTslp016680;
        Sat, 25 Oct 2014 14:29:54 +0200
Date:   Sat, 25 Oct 2014 14:29:54 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mips@linux-mips.org
Subject: Re: [RFC PATCH 00/11] next: mips: Fix default configurations
Message-ID: <20141025122953.GA16645@linux-mips.org>
References: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43563
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

I'm dropping this series from patchwork because d1630f9e (mips: Set
CONFIG_NET=y in defconfigs) and af4de1b5 (mips: Update some more
defconfigs which were missing CONFIG_NET.) have already added
CONFIG_NET=y to the same 11 defconfig files.

Thanks anyway!

  Ralf
