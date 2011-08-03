Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2011 14:44:43 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56680 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491079Ab1HCMoj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Aug 2011 14:44:39 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p73CiafA004650;
        Wed, 3 Aug 2011 13:44:36 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p73CiaJS004648;
        Wed, 3 Aug 2011 13:44:36 +0100
Date:   Wed, 3 Aug 2011 13:44:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 07/15] MIPS: Alchemy: always build power code
Message-ID: <20110803124436.GA3978@linux-mips.org>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
 <1312307470-6841-8-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1312307470-6841-8-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2293

On Tue, Aug 02, 2011 at 07:51:02PM +0200, Manuel Lauss wrote:
> Date:   Tue,  2 Aug 2011 19:51:02 +0200
> From: Manuel Lauss <manuel.lauss@googlemail.com>
> To: Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle
>  <ralf@linux-mips.org>
> Cc: Manuel Lauss <manuel.lauss@googlemail.com>
> Subject: [PATCH 07/15] MIPS: Alchemy: always build power code
> 
> No reason NOT to build it

Freely after Monthy Python ...

  Every byte is sacred.
  Every byte is great.
  If a byte is wasted,
  God gets quite irate.

But I really wonder why compilation of this file wasn't controlled by
something like

obj-$(CONFIG_PM) += power.o

Anyway, applied.

  Ralf
