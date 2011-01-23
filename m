Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 15:13:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46900 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491085Ab1AXONv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 15:13:51 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0OEDM15031955
        for <linux-mips@linux-mips.org>; Mon, 24 Jan 2011 15:13:22 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0OEDMg5031954
        for linux-mips@linux-mips.org; Mon, 24 Jan 2011 15:13:22 +0100
Resent-From: Ralf Baechle <ralf@linux-mips.org>
Resent-Date: Mon, 24 Jan 2011 15:13:22 +0100
Resent-Message-ID: <20110124141322.GC31933@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Date:   Sun, 23 Jan 2011 19:11:13 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Cc:     COLin <colin@realtek.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: 24k data cache, PIPT or VIPT?
Message-ID: <20110123181113.GA12232@linux-mips.org>
References: <AB43F607AA1BE0439402E9061AC9519D011EF513EB8D@rtitmbs7.realtek.com.tw>
 <20110123043439.GA20840@laped.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110123043439.GA20840@laped.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 23, 2011 at 05:34:39AM +0100, Edgar E. Iglesias wrote:

> This line is confusing:
> "This bit is only set if the data cache config and MMU type would normally cause aliasing"
> 
> because I don't know what they mean by "normally".

Normally means the behaviour expected from a text book implementation of a
VIPT cache.

  Ralf
