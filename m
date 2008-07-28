Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 23:37:29 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:11189
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20027382AbYG1WhY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2008 23:37:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6SMa56W006680;
	Mon, 28 Jul 2008 23:36:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6SMa3VO006678;
	Mon, 28 Jul 2008 23:36:03 +0100
Date:	Mon, 28 Jul 2008 23:36:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	linux-mips@linux-mips.org, dmitri.vorobiev@movial.fi
Subject: Re: [PATCH v2 1/1][MIPS] Initialization of Alchemy boards
Message-ID: <20080728223603.GA1430@linux-mips.org>
References: <1217268566.19887.3.camel@kh-ubuntu.razamicroelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1217268566.19887.3.camel@kh-ubuntu.razamicroelectronics.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 28, 2008 at 01:09:26PM -0500, Kevin Hickey wrote:

>   An earlier update changed some calls from simple_strotl to
> strict_strtol but did not account for the differences in the syntax
> between the calls.simple_strotl returns the integer; strict_strtol
> returns an error code and takes a pointer to the result.  As it was,
> NULL was being passed in place of the result, which led to failures
> during kernel initialization when using YAMON.
> 
> Signed-off-by:  Kevin Hickey <khickey@rmicorp.com>
> 
>  arch/mips/au1000/db1x00/init.c  |    2 +-
>  arch/mips/au1000/mtx-1/init.c   |    2 +-
>  arch/mips/au1000/pb1000/init.c  |    2 +-
>  arch/mips/au1000/pb1100/init.c  |    2 +-
>  arch/mips/au1000/pb1200/init.c  |    2 +-
>  arch/mips/au1000/pb1500/init.c  |    2 +-
>  arch/mips/au1000/pb1550/init.c  |    2 +-
>  arch/mips/au1000/xxs1500/init.c |    2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)

One little nit on the submission format - if you include a diffstat, please
put it after a line consisting only of three - like this:

---
 arch/mips/au1000/db1x00/init.c  |    2 +-
 arch/mips/au1000/mtx-1/init.c   |    2 +-
 arch/mips/au1000/pb1000/init.c  |    2 +-

This keeps git and other tools that try to extract the body of the mail
for the description from considering the diffstat as part of the
description.

Patch applied, thanks!

  Ralf
