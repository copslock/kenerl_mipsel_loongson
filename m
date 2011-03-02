Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2011 16:00:30 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42565 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491174Ab1CBPA1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2011 16:00:27 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p22ETb39019651;
        Wed, 2 Mar 2011 15:29:37 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p22ETXlH019645;
        Wed, 2 Mar 2011 15:29:33 +0100
Date:   Wed, 2 Mar 2011 15:29:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
Message-ID: <20110302142933.GA18221@linux-mips.org>
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org>
 <1298996006-15960-6-git-send-email-blogic@openwrt.org>
 <4D6E286D.9050100@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D6E286D.9050100@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 02, 2011 at 02:22:21PM +0300, Sergei Shtylyov wrote:

> >+	switch (cmd) {
> >+	case WDIOC_GETSUPPORT:
> >+		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
> >+				sizeof(ident)) ? -EFAULT : 0;
> 
>    Doesn't copy_to_user() return 0 or -EFAULT?

No and that's a common cause of bugs.  copy_{from,to}_user returns the
number of characters that could be be copied so the conversion to an
error code is needed here.

The function takes a void argument and there is no benefit from casting
to the full struct watchdog_info __user * pointer type other than maybe
clarity to the human reader.

While nitpicking - there should be one space between include and < in
#include <blah.h>.

  Ralf
