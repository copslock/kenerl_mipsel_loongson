Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 11:48:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57255 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010788AbbIGJsH2N24z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Sep 2015 11:48:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t879m67E015666;
        Mon, 7 Sep 2015 11:48:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t879m5sO015665;
        Mon, 7 Sep 2015 11:48:05 +0200
Date:   Mon, 7 Sep 2015 11:48:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH 1/2 for-4.3] MIPS: BPF: Avoid unreachable code on little
 endian
Message-ID: <20150907094805.GE3507@linux-mips.org>
References: <1441471618-5613-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441471618-5613-1-git-send-email-aurelien@aurel32.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49122
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

Thanks, both applied.

  Ralf
