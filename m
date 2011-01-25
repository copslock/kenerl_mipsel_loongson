Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 13:41:42 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47304 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491188Ab1AYMlj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 13:41:39 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0PCf9VZ023662;
        Tue, 25 Jan 2011 13:41:09 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0PCf4ZK023660;
        Tue, 25 Jan 2011 13:41:04 +0100
Date:   Tue, 25 Jan 2011 13:41:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sergei Shtylyov <sshtylyov@mvista.com>,
        Yoichi Yuasa <yuasa@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix build error when CONFIG_SWAP is not set
Message-ID: <20110125124104.GA395@linux-mips.org>
References: <20110124210813.ba743fc5.yuasa@linux-mips.org>
 <4D3DD366.8000704@mvista.com>
 <20110124124412.69a7c814.akpm@linux-foundation.org>
 <20110124210752.GA10819@merkur.ravnborg.org>
 <AANLkTimdgYVpwbCAL96=1F+EtXyNxz5Swv32GN616mqP@mail.gmail.com>
 <20110124223347.ad6072f1.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110124223347.ad6072f1.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 24, 2011 at 10:33:47PM -0800, Andrew Morton wrote:

Works for me.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
