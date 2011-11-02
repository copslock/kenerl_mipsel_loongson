Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2011 12:37:11 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54050 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903946Ab1KBLhE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Nov 2011 12:37:04 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA2Bb25U015275;
        Wed, 2 Nov 2011 11:37:02 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA2Bb2qJ015273;
        Wed, 2 Nov 2011 11:37:02 GMT
Date:   Wed, 2 Nov 2011 11:37:02 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/18] MIPS: Alchemy: remove PB1000 support
Message-ID: <20111102113702.GF22462@linux-mips.org>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
 <1320174224-27305-2-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320174224-27305-2-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1180

On Tue, Nov 01, 2011 at 08:03:27PM +0100, Manuel Lauss wrote:

>  arch/mips/alchemy/Kconfig                        |    9 -
>  arch/mips/alchemy/Platform                       |    7 -
>  arch/mips/alchemy/common/irq.c                   |   11 -
>  arch/mips/alchemy/devboards/Makefile             |    1 -
>  arch/mips/alchemy/devboards/pb1000/Makefile      |    8 -
>  arch/mips/alchemy/devboards/pb1000/board_setup.c |  209 ---------
>  arch/mips/alchemy/devboards/prom.c               |    2 +-
>  arch/mips/include/asm/mach-pb1x00/pb1000.h       |   87 ----
>  drivers/net/irda/au1k_ir.c                       |    5 +-
>  drivers/pcmcia/Kconfig                           |    4 -
>  drivers/pcmcia/Makefile                          |    4 -
>  drivers/pcmcia/au1000_generic.c                  |  545 ----------------------
>  drivers/pcmcia/au1000_generic.h                  |  135 ------
>  drivers/pcmcia/au1000_pb1x00.c                   |  294 ------------

Please repost cc'ing the net / irda and pcmcia lists and maintainers.  Even
if code is only getting removed there still is a potencial for conflicts
with other patches and generally maintainers' ego prefers a full mailbox :)

Thanks,

  Ralf
