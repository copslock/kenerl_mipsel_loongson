Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2011 23:42:48 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41305 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491114Ab1FMVmp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jun 2011 23:42:45 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5DLh5CN030275;
        Mon, 13 Jun 2011 22:43:05 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5DLh465030273;
        Mon, 13 Jun 2011 22:43:04 +0100
Date:   Mon, 13 Jun 2011 22:43:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] MIPS: ar7: use linux/reboot.h instead of asm/reboot.h
Message-ID: <20110613214304.GA29853@linux-mips.org>
References: <1307905041-18391-1-git-send-email-florian@openwrt.org>
 <1307905041-18391-4-git-send-email-florian@openwrt.org>
 <201106122059.57909.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106122059.57909.florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10955

On Sun, Jun 12, 2011 at 08:59:57PM +0200, Florian Fainelli wrote:

> Ralf, please discard this one, it's causing a build failure.

Okay, bitbucketed.

  Ralf
