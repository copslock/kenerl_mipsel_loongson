Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 10:55:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49834 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822451Ab3FSIzSAdfdt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jun 2013 10:55:18 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5J8tCa1008405;
        Wed, 19 Jun 2013 10:55:13 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5J8t9UI008404;
        Wed, 19 Jun 2013 10:55:09 +0200
Date:   Wed, 19 Jun 2013 10:55:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yousong Zhou <yszhou4tech@gmail.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, sibyte-users@bitmover.com,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v2 5/7] drivers: watchdog: sb_wdog: Fix 32bit linking
 problems
Message-ID: <20130619085509.GA11687@linux-mips.org>
References: <1371564006-31805-1-git-send-email-markos.chandras@imgtec.com>
 <20130618141420.GA15141@linux-mips.org>
 <CAECwjAhzJUO4GFmnu3jX8e-UEj2wiVrB8xA3Hu_0iSaf1L1v5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAECwjAhzJUO4GFmnu3jX8e-UEj2wiVrB8xA3Hu_0iSaf1L1v5w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37004
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

On Wed, Jun 19, 2013 at 03:45:07PM +0800, Yousong Zhou wrote:

> I am not quite sure on this. I just digged this[1] out and thought that Linus
>  may not be happy about the operation `tmp_user_dog/1000000`.
> 
> Correct me if I am wrong, please.
> 
> [1] http://lwn.net/Articles/456241/

Well, Linus' posting is about a division by a power of two.  Doing that
by do_div() is not terribly smart.  Now, reading some manuals it turned
out that the register (like most registers on Sibyte SOCs) is 64 bit
but only the lower 23 bits are being used; bits 23..64 always read as
zero.

So the best fix is to truncate the value down to 32 bit then use the plain
old `/' division.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/watchdog/sb_wdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
index 25c7a3f..ea5d84a 100644
--- a/drivers/watchdog/sb_wdog.c
+++ b/drivers/watchdog/sb_wdog.c
@@ -208,7 +208,7 @@ static long sbwdog_ioctl(struct file *file, unsigned int cmd,
 		 * get the remaining count from the ... count register
 		 * which is 1*8 before the config register
 		 */
-		ret = put_user(__raw_readq(user_dog - 8) / 1000000, p);
+		ret = put_user((u32)__raw_readq(user_dog - 8) / 1000000, p);
 		break;
 	}
 	return ret;
