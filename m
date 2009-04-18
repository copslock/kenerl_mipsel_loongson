Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2009 14:32:52 +0100 (BST)
Received: from xylophone.i-cable.com ([203.83.115.99]:1754 "HELO
	xylophone.i-cable.com") by ftp.linux-mips.org with SMTP
	id S28774297AbZDRNbC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Apr 2009 14:31:02 +0100
Received: (qmail 16486 invoked by uid 508); 18 Apr 2009 13:30:53 -0000
Received: from 203.83.114.121 by xylophone (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7737.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.182551 secs); 18 Apr 2009 13:30:53 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 18 Apr 2009 13:30:52 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n3IDUe5I027785;
	Sat, 18 Apr 2009 21:30:51 +0800 (HKT)
Date:	Sat, 18 Apr 2009 21:30:35 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, yanh@lemote.com, zhangfx@lemote.com,
	penglj@lemote.com
Subject: Re: [PATCH] Loongson 2 requires no NOP insns to work around hazards
Message-ID: <20090418133034.GA20331@adriano.hkcable.com.hk>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, yanh@lemote.com, zhangfx@lemote.com,
	penglj@lemote.com
References: <1239786112-22120-1-git-send-email-r0bertz@gentoo.org> <20090418122234.GH11339@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090418122234.GH11339@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 14:22 Sat 18 Apr     , Ralf Baechle wrote:
> On Wed, Apr 15, 2009 at 05:01:52PM +0800, Zhang Le wrote:
> 
> > Quoting from Loongson2FUserGuide.pdf:
> > 
> > 5.22.1 Hazards
> > The processor detects most of the pipeline hazards in hardware, including CP0 hazards and
> > load hazards. No NOP instructions are required to correct instruction sequences.
> 
> Patch looks ok - but *please* generate patches against a new source tree.
> Your patch rejects because of another patches that was applied over two
> week before you sent this one.

Ah, sorry, I didn't check carefully, I thought I was operating on the master
branch. 

> 
> Applied,

Thanks.

-- 
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973
