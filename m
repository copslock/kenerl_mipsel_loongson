Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2011 23:43:19 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41310 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491114Ab1FMVnJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jun 2011 23:43:09 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5DLhTNj030315;
        Mon, 13 Jun 2011 22:43:29 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5DLhTLH030314;
        Mon, 13 Jun 2011 22:43:29 +0100
Date:   Mon, 13 Jun 2011 22:43:29 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] MIPS: ar7: use linux/time.h instead of asm/time.h
Message-ID: <20110613214329.GB29853@linux-mips.org>
References: <1307905041-18391-1-git-send-email-florian@openwrt.org>
 <1307905041-18391-5-git-send-email-florian@openwrt.org>
 <201106122100.29385.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106122100.29385.florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10956

On Sun, Jun 12, 2011 at 09:00:29PM +0200, Florian Fainelli wrote:

> >  arch/mips/ar7/time.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> And this one too is causing a build failure, sorry about that.

Shredded as well.

  Ralf
