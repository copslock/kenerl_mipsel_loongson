Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OEPMnC031599
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 07:25:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OEPMn5031598
	for linux-mips-outgoing; Mon, 24 Jun 2002 07:25:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OEPHnC031595
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 07:25:18 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17MUpR-00013H-00; Mon, 24 Jun 2002 16:28:29 +0200
Date: Mon, 24 Jun 2002 16:28:29 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Chien-Lung Wu <cwu@deltartp.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: cross-compiler
Message-ID: <20020624142829.GA4015@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Chien-Lung Wu <cwu@deltartp.com>, linux-mips@oss.sgi.com
References: <A4E787A2467EF849B00585F14C900559068906@dprn03.deltartp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A4E787A2467EF849B00585F14C900559068906@dprn03.deltartp.com>
User-Agent: Mutt/1.4i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Chien-Lung Wu wrote:
> I use the following tar-ball as base: (The newest one)
> 	a. binutils (2.11.2)
> 	b. gcc 3.1
> 	c. glibc 2.2.5
> 
> As a newbie in linux embedded system, could anyone kindly show me "HOWTO"
> build up a cross-compiler in general and specifically for MIPS (IDT
> R32334/32332)?
> 
> If you know any good stuffs in building cross-compiler and porting Linux to
> MIPS, please send me the web-side or pointers. Thanks in advance.

http://linux-mips.sourceforge.net/
http://www.junsun.net/linux/porting-howto/

HTH,
Johannes
