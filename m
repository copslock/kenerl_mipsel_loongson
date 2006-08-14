Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2006 23:57:11 +0100 (BST)
Received: from p549F51CF.dip.t-dialin.net ([84.159.81.207]:44770 "EHLO
	p549F51CF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20039720AbWHNW5I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Aug 2006 23:57:08 +0100
Received: from sj-iport-6.cisco.com ([171.71.176.117]:31768 "EHLO
	sj-iport-6.cisco.com") by lappi.linux-mips.net with ESMTP
	id S1100053AbWHNQ2P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Aug 2006 18:28:15 +0200
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-6.cisco.com with ESMTP; 14 Aug 2006 09:27:56 -0700
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11.20060308/8.12.11) with ESMTP id k7EGRuGt002280;
	Mon, 14 Aug 2006 09:27:56 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id k7EGRulN019137;
	Mon, 14 Aug 2006 09:27:56 -0700 (PDT)
Received: from xfe-sjc-211.amer.cisco.com ([171.70.151.174]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 09:27:56 -0700
Received: from localhost.localdomain ([171.71.26.43]) by xfe-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 09:27:55 -0700
Received: by localhost.localdomain (Postfix, from userid 33217)
	id 53A494FDDB; Mon, 14 Aug 2006 09:27:55 -0700 (PDT)
To:	"Randy.Dunlap" <rdunlap@xenotime.net>
Cc:	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Koeller <thomas@koeller.dyndns.org>,
	Dave Jones <davej@redhat.com>, wim@iguana.be,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
X-Message-Flag:	Warning: May contain useful information
References: <200608102319.13679.thomas@koeller.dyndns.org>
	<20060811205639.GK26930@redhat.com>
	<200608120149.23380.thomas@koeller.dyndns.org>
	<20060814141445.GA10763@nineveh.rivenstone.net>
	<20060814153033.GA25215@mars.ravnborg.org>
	<20060814092124.84f7ff3e.rdunlap@xenotime.net>
From:	Roland Dreier <rdreier@cisco.com>
Date:	Mon, 14 Aug 2006 09:27:55 -0700
In-Reply-To: <20060814092124.84f7ff3e.rdunlap@xenotime.net> (Randy Dunlap's message of "Mon, 14 Aug 2006 09:21:24 -0700")
Message-ID: <adahd0fl1tg.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Aug 2006 16:27:55.0973 (UTC) FILETIME=[9916AF50:01C6BFBE]
DKIM-Signature:	a=rsa-sha1; q=dns; l=556; t=1155572876; x=1156436876;
	c=relaxed/simple; s=sjdkim2002; h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=rdreier@cisco.com; z=From:Roland=20Dreier=20<rdreier@cisco.com>
	|Subject:Re=3A=20[PATCH]=20Added=20MIPS=20RM9K=20watchdog=20driver;
	X=v=3Dcisco.com=3B=20h=3DAl1k+T+DvJ3bVRLjCw2daCVk+sw=3D; b=kaChd09ajgwZIFxkDB0Vs8wDYvpE651jDSyXilf0p8oeLRz4MboKJgur5mmlPMPBXPZg8ZtO
	DBhZ2Ba//fd7uFFw/6Ny5yrpJT+pmgrOurZX3jRglLt6uPWZtMWIn+1H;
Authentication-Results:	sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Return-Path: <rdreier@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdreier@cisco.com
Precedence: bulk
X-list: linux-mips

    Randy> Sure, autoconf.h is included, but I think his point is that
    Randy> CONFIG_WATCHDOG_NOWAYOUT may not be defined there at all,
    Randy> as in my 2.6.18-rc4 autoconf.h file, since my .config file
    Randy> says: # CONFIG_WATCHDOG_NOWAYOUT is not set

Huh?  How would including <linux/config.h> help with that?  And why
would you want CONFIG_WATCHDOG_NOWAYOUT to be defined if
WATCHDOG_NOWAYOUT is not set in your configuration?  That would
utterly break code that does something like

    #ifdef CONFIG_WATCHDOG_NOWAYOUT

 - R.
