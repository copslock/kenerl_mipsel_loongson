Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g63Bh4Rw030411
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 3 Jul 2002 04:43:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g63Bh4es030410
	for linux-mips-outgoing; Wed, 3 Jul 2002 04:43:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g63Bh1Rw030401
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 04:43:01 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA08075
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 03:57:04 -0700 (PDT)
	mail_from (ica2_ts@csv.ica.uni-stuttgart.de)
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17Phcj-000xKw-00
	for linux-mips@oss.sgi.com; Wed, 03 Jul 2002 12:44:37 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17Phf1-0001HQ-00
	for <linux-mips@oss.sgi.com>; Wed, 03 Jul 2002 12:46:59 +0200
Date: Wed, 3 Jul 2002 12:46:59 +0200
To: linux-mips@oss.sgi.com
Subject: Re: Small correction for fault.c
Message-ID: <20020703104659.GX16753@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020703144404.4d349037.yoichi_yuasa@montavista.co.jp> <20020703081539.GU16753@rembrandt.csv.ica.uni-stuttgart.de> <20020703181651.779116be.yoichi_yuasa@montavista.co.jp> <20020703095224.GV16753@rembrandt.csv.ica.uni-stuttgart.de> <20020703192428.78aa0c58.yoichi_yuasa@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020703192428.78aa0c58.yoichi_yuasa@montavista.co.jp>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Yoichi Yuasa wrote:
[snip]
> > Then you are using a different CVS than I do. In CVS at oss.sgi.com,
> > linux/sched.h does not include linux/tty.h.
> 
> I use version 2.4.19-rc1(linux_2_4 tag) on oss.sgi.com.

I use HEAD. The change from CVS Revision 1.61 to 1.62 was dropping
the tty.h include. Apparently a 2.5 cleanup.


Thiemo
