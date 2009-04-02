Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 08:47:16 +0100 (BST)
Received: from sitar.i-cable.com ([203.83.115.100]:63198 "HELO
	sitar.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20024935AbZDBHrI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Apr 2009 08:47:08 +0100
Received: (qmail 4601 invoked by uid 508); 2 Apr 2009 07:46:57 -0000
Received: from 203.83.114.121 by sitar (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/8786.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.087543 secs); 02 Apr 2009 07:46:57 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 2 Apr 2009 07:46:56 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n327kubP027265;
	Thu, 2 Apr 2009 15:46:56 +0800 (HKT)
Date:	Thu, 2 Apr 2009 15:46:42 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Graziano Sorbaioli <graziano@gnu.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: getcontext needs to be implemented on mips
Message-ID: <20090402074641.GB28319@adriano.hkcable.com.hk>
Mail-Followup-To: Graziano Sorbaioli <graziano@gnu.org>,
	linux-mips@linux-mips.org
References: <49D376E4.4090503@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D376E4.4090503@gnu.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 16:15 Wed 01 Apr     , Graziano Sorbaioli wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi all,
> 
> in a previous email I notified the list about a bug related to my wvdial
> on gnewsense mips-l.
> 
> This bug is not related to my Lemote Yeeloong or gNewSense mips-l.
> 
> The problem is that getcontext needs to be implemented on mips.
> 
> Someone wrote a patch but it is for glibc 2.9 and needs to be modified
> to function with glibc 2.7 (the version gnewsense mips-l is using right
> now).
 
Hi, Graziano,

Could you please just try glibc 2.9? Is there any difficulties with that?
Backporting is no fun, I am afraid. Few, if not none, people would like to do
that, unless paid.

Zhang, Le
http://zhangle.is-a-geek.org
