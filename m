Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4V0vWnC010590
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 17:57:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4V0vWNS010589
	for linux-mips-outgoing; Thu, 30 May 2002 17:57:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4V0vVnC010586
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 17:57:31 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4V0wl002329
	for linux-mips@oss.sgi.com; Thu, 30 May 2002 17:58:47 -0700
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UDhNnC003555
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 06:43:23 -0700
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com [194.25.134.83]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA00228
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 06:44:53 -0700 (PDT)
	mail_from (florian@void.s.bawue.de)
Received: from fwd00.sul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 17DQ4m-0000O4-08; Thu, 30 May 2002 15:34:48 +0200
Received: from void.s.bawue.de (520095841842-0001@[62.155.180.20]) by fmrl00.sul.t-online.com
	with esmtp id 17DQ4c-1yhO1QC; Thu, 30 May 2002 15:34:38 +0200
Received: from florian by void.s.bawue.de with local (Exim 3.33 #1 (Debian))
	id 17DP5M-0002Bk-00; Thu, 30 May 2002 14:31:20 +0200
Date: Thu, 30 May 2002 14:31:20 +0200
To: linux-mips@oss.sgi.com
Subject: Re: __flush_cache_all() miscellany
Message-ID: <20020530123120.GB1203@void.s.bawue.de>
Mail-Followup-To: Florian Laws <florian@void.s.bawue.de>,
	linux-mips@oss.sgi.com
References: <1022691053.7644.16.camel@ldt-sj3-022.sj.broadcom.com> <20020529140759.A888@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020529140759.A888@dea.linux-mips.net>
User-Agent: Mutt/1.3.28i
From: Florian Laws <florian@void.s.bawue.de>
X-Sender: 520095841842-0001@t-dialin.net
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 29, 2002 at 02:07:59PM -0700, Ralf Baechle wrote:
> > 
> > Which caches does this apply to?  It looks like the current
> > implementations assume L1 only.
> 
> The operation got introduced for the R10000 where we only need to flush
> the caches during initialization or the (unlikely on Origin) case of

Which case?

Thanks,

Florian
