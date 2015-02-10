Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2015 01:22:25 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012911AbbBJAWYB772C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Feb 2015 01:22:24 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 241A4A5D;
        Tue, 10 Feb 2015 00:22:17 +0000 (UTC)
Date:   Mon, 9 Feb 2015 16:22:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     rtc-linux@googlegroups.com, Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [rtc-linux] [PATCH 01/02 resend] RTC: Add driver for DS1685
 family of real time clocks
Message-Id: <20150209162216.23a44ab270e0c9e60de79822@linux-foundation.org>
In-Reply-To: <20150209161844.942ff2d0ecd709a331083bac@linux-foundation.org>
References: <548B6892.9040200@gentoo.org>
        <20150209161844.942ff2d0ecd709a331083bac@linux-foundation.org>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Mon, 9 Feb 2015 16:18:44 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> > +	/* Platform read function, else default if mmio setup */
> > +	if (pdata->plat_read)
> > +		rtc->read = pdata->plat_read;
> 
> I'm trying to understand how this works and I'm not getting very far.

oop, never mind, it's there in patch 2/2.
