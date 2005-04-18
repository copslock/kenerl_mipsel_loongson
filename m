Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 00:17:59 +0100 (BST)
Received: from mailout02.sul.t-online.com ([IPv6:::ffff:194.25.134.17]:9395
	"EHLO mailout02.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225753AbVDRXRm>; Tue, 19 Apr 2005 00:17:42 +0100
Received: from fwd34.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1DNfUn-0002Jh-00; Tue, 19 Apr 2005 01:17:37 +0200
Received: from denx.de (bpRcT8ZHYeoV+4PIzmI31n+ZYprjwvWwNcOr+Z-Y6jOc1Smtp84rcb@[84.150.101.52]) by fwd34.sul.t-online.de
	with esmtp id 1DNfUa-0tXbSy0; Tue, 19 Apr 2005 01:17:24 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id A3C0C42C64; Tue, 19 Apr 2005 01:17:23 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id CFEAFC1519; Tue, 19 Apr 2005 01:17:22 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id BAA0613D94A; Tue, 19 Apr 2005 01:17:22 +0200 (MEST)
To:	John Tully <tully@mikrotik.com>
Cc:	linux-mips@linux-mips.org, cordova@uninet.com.br
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: Linux for RouterBoard532 - CPU MIPS32 4Kc - IDT 79RC32434. 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 18 Apr 2005 17:54:05 +0300."
             <6.2.1.2.0.20050418174810.0382e410@frog.mt.lv> 
Date:	Tue, 19 Apr 2005 01:17:17 +0200
Message-Id: <20050418231722.CFEAFC1519@atlas.denx.de>
X-ID:	bpRcT8ZHYeoV+4PIzmI31n+ZYprjwvWwNcOr+Z-Y6jOc1Smtp84rcb@t-dialin.net
X-TOI-MSGID: d42a9de3-b727-4231-aa93-5a7d00f45f3e
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <6.2.1.2.0.20050418174810.0382e410@frog.mt.lv> you wrote:
> I work for MikroTik and we make the RB500.  We are trying to add more 
> documentation to make it easy to do more things with Linux.  At the moment, 
> the CF image at least lets you quickly start on developing Linux 
> applications.  Allot of what you need can be figured out from the kernel 
> patch on the specs page for the RB500 at www.routerboard.com , but that is 
> not so much fun.  We will add more documentation on the NAND device and 
> such features.  So, please check the site and I can also write to this list 
> as we add more info.

Thanks. Just two more questions now:

* Are you working on a 2.6.x version ?

* Is the NAND flash support supposed to be working?  All  I  can  get
  from it is only error messages.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Anyone can count the seeds in an apple.
No one can count the apples in a seed.
