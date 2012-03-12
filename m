Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2012 18:47:28 +0100 (CET)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:48687 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903607Ab2CLRrV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2012 18:47:21 +0100
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
        (envelope-from <linville@tuxdriver.com>)
        id 1S79Kr-0003t1-Uy; Mon, 12 Mar 2012 13:47:06 -0400
Received: from linville-8530p.local (linville-8530p.local [127.0.0.1])
        by linville-8530p.local (8.14.4/8.14.4) with ESMTP id q2CHfHqh022284;
        Mon, 12 Mar 2012 13:41:17 -0400
Received: (from linville@localhost)
        by linville-8530p.local (8.14.4/8.14.4/Submit) id q2CHfE4U022263;
        Mon, 12 Mar 2012 13:41:14 -0400
Date:   Mon, 12 Mar 2012 13:41:14 -0400
From:   "John W. Linville" <linville@tuxdriver.com>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/7] bcma: scan for extra address space
Message-ID: <20120312174113.GC2778@tuxdriver.com>
References: <1331496505-18697-1-git-send-email-hauke@hauke-m.de>
 <1331496505-18697-4-git-send-email-hauke@hauke-m.de>
 <CAGRGNgX116dRB03NTL_DFZ4b_PYcdY+Un_cVwt6ZUGR1bwZzHA@mail.gmail.com>
 <4F5D3679.3090900@hauke-m.de>
 <CAGRGNgWsO9s2rW1pKBFWd_-0oTAGs9_RXNGyn_y7ic=0Zer=qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRGNgWsO9s2rW1pKBFWd_-0oTAGs9_RXNGyn_y7ic=0Zer=qQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Mar 12, 2012 at 12:30:54PM +1100, Julian Calaby wrote:
> Hi Hauke,
> 
> On Mon, Mar 12, 2012 at 10:34, Hauke Mehrtens <hauke@hauke-m.de> wrote:

> > I will fix this, should I resend the hole series or just this patch?
> 
> I'm not sure the rest of the series made it to linux-wireless, so
> maybe you should resend everything.

FWIW, this was the only one I saw...

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
