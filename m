Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g639wIRw023560
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 3 Jul 2002 02:58:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g639wIFN023559
	for linux-mips-outgoing; Wed, 3 Jul 2002 02:58:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g639wERw023549
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 02:58:14 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA06021
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 03:02:11 -0700 (PDT)
	mail_from (ica2_ts@csv.ica.uni-stuttgart.de)
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17Pglv-000xEO-00
	for linux-mips@oss.sgi.com; Wed, 03 Jul 2002 11:50:03 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17PgoD-0008JD-00
	for <linux-mips@oss.sgi.com>; Wed, 03 Jul 2002 11:52:25 +0200
Date: Wed, 3 Jul 2002 11:52:24 +0200
To: linux-mips@oss.sgi.com
Subject: Re: Small correction for fault.c
Message-ID: <20020703095224.GV16753@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020703144404.4d349037.yoichi_yuasa@montavista.co.jp> <20020703081539.GU16753@rembrandt.csv.ica.uni-stuttgart.de> <20020703181651.779116be.yoichi_yuasa@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020703181651.779116be.yoichi_yuasa@montavista.co.jp>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Yoichi Yuasa wrote:
[snip]
> > In file included from fault.c:23:
> > /bigdisk/combined/source-linux/include/linux/vt_kern.h:32: error:
> > MAX_NR_CONSOLES' undeclared here (not in a function)
> 
> I did checkout cvs and I checked also about MIPS64.
> There was no problem by my correction.
> 
> "arch/mips64/mm/fault.c" is including <linux/sched.h>.
> <linux/sched.h> is including <linux/tty.h>.

Then you are using a different CVS than I do. In CVS at oss.sgi.com,
linux/sched.h does not include linux/tty.h.


Thiemo
