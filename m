Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 18:54:50 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:63728 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20026620AbYEMRyq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2008 18:54:46 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4DHrjq5007727;
	Tue, 13 May 2008 19:53:45 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4DHrZG1007723;
	Tue, 13 May 2008 18:53:36 +0100
Date:	Tue, 13 May 2008 18:53:35 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jean Delvare <khali@linux-fr.org>
cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] RTC: SWARM I2C board initialization (#2)
In-Reply-To: <20080513191732.259d0ab2@hyperion.delvare>
Message-ID: <Pine.LNX.4.55.0805131849470.7267@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805130249230.535@cliff.in.clinika.pl>
 <20080513133416.59a8d943@hyperion.delvare> <Pine.LNX.4.55.0805131747590.7267@cliff.in.clinika.pl>
 <20080513191732.259d0ab2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Jean,

> 		printk(KERN_ERR
> 		       "i2c-swarm: cannot register board I2C devices\n");

 Thanks -- that's the one I missed.  I think there is no point in
resending the whole set for this change only, so I will post an update for
this patch only.

> I don't really want to include a mips arch patch in my public i2c tree,
> that would be confusing. I think I'll just wait. I have the mips patch
> in my local tree, so quilt will tell me when it hits upstream.

 Well, your local tree is what I had in mind indeed.  I agree it would be 
confusing to publish the MIPS change through the i2c repository.

  Maciej
