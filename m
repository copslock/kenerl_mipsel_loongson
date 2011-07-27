Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2011 10:35:22 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55120 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491080Ab1G0IfS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jul 2011 10:35:18 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p6R8Z9Wm024378;
        Wed, 27 Jul 2011 09:35:09 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p6R8Z87V024374;
        Wed, 27 Jul 2011 09:35:08 +0100
Date:   Wed, 27 Jul 2011 09:35:08 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wanlong Gao <wanlong.gao@gmail.com>
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] mips:lantiq:remove the dup include file
Message-ID: <20110727083508.GB23769@linux-mips.org>
References: <1311479980-6756-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1311479980-6756-1-git-send-email-gaowanlong@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19489

On Sun, Jul 24, 2011 at 11:59:40AM +0800, Wanlong Gao wrote:

> linux/leds.h
> linux/reboot.h
> had been included twice in devices.c
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

This was already fixed a week ago by e44ba033c5654dbfda53461c9b1f7dd9bd1d198f
[treewide: remove duplicate includes].

  Ralf
