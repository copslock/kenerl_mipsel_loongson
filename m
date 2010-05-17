Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2010 17:04:42 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34714 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492042Ab0EQPEj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 May 2010 17:04:39 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4HF3uVJ008381;
        Mon, 17 May 2010 16:03:57 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4HF3ss6008378;
        Mon, 17 May 2010 16:03:54 +0100
Date:   Mon, 17 May 2010 16:03:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
        rtc-linux@googlegroups.com, david-b@pacbell.net,
        a.zummo@towertech.it, akpm@linux-foundation.org
Subject: Re: [PATCH] rtc-cmos: Fix binary mode support
Message-ID: <20100517150353.GA15578@linux-mips.org>
References: <m3zl0mwpez.fsf@anduin.mandriva.com>
 <20100511141039.GG13576@linux-mips.org>
 <1274108154.14193.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1274108154.14193.3.camel@localhost>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 17, 2010 at 10:55:54PM +0800, Wu Zhangjin wrote:

> Just found a bug introduced in this patch, please take a look at the 754
> line after applying it, a ";" is needed to append the "dev_warn(dev,
> "only 24-hr supported\n")".

I silently fixed this when applying the patch.

Thanks anyway!

  Ralf
