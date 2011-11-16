Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 20:15:57 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45143 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903850Ab1KPTN5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 20:13:57 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAGJDrDd014589;
        Wed, 16 Nov 2011 19:13:53 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAGJDrox014587;
        Wed, 16 Nov 2011 19:13:53 GMT
Date:   Wed, 16 Nov 2011 19:13:53 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Greg KH <greg@kroah.com>
Cc:     Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 11/13] serial: add driver for the built-in UART of the
 AR933X SoC
Message-ID: <20111116191352.GK8932@linux-mips.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
 <1308597973-6037-12-git-send-email-juhosg@openwrt.org>
 <20110621095951.7dc1c9ee@lxorguk.ukuu.org.uk>
 <20110701211123.GA19805@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110701211123.GA19805@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13748

On Fri, Jul 01, 2011 at 02:11:23PM -0700, Greg KH wrote:

> On Tue, Jun 21, 2011 at 09:59:51AM +0100, Alan Cox wrote:
> > Looks good to me
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > 
> > and no problem here with it going via the MIPS tree (but make sure GregKH
> > is happy)
> 
> I'm happy with this.

Queued for 3.3.  Thanks folks!,

  Ralf
