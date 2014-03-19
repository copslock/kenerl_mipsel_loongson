Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2014 00:50:46 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39832 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6820484AbaCSXukb6ix3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Mar 2014 00:50:40 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2JNocra015766;
        Thu, 20 Mar 2014 00:50:38 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2JNocrq015731;
        Thu, 20 Mar 2014 00:50:38 +0100
Date:   Thu, 20 Mar 2014 00:50:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: remove SYS_SUPPORTS_APM_EMULATION
Message-ID: <20140319235038.GJ17197@linux-mips.org>
References: <1393173460-840-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393173460-840-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39519
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

On Sun, Feb 23, 2014 at 05:37:40PM +0100, Manuel Lauss wrote:

> Subject: [PATCH] MIPS: remove SYS_SUPPORTS_APM_EMULATION
> 
> nothing in the MIPS tree needs it, so get rid of it.

See https://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060605154310.GF27426%40enneenne.com

I think the reasons for thi code is still standing - suspend through
apm(8) though that's an antiquated interface.

  Ralf
