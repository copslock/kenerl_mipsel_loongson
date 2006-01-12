Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 18:03:29 +0000 (GMT)
Received: from p549F60EF.dip.t-dialin.net ([84.159.96.239]:20106 "EHLO
	p549F60EF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133356AbWAOSCw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jan 2006 18:02:52 +0000
Received: from [IPv6:::ffff:210.190.142.172] ([IPv6:::ffff:210.190.142.172]:62915
	"HELO smtp.mba.ocn.ne.jp") by linux-mips.net with SMTP
	id <S870688AbWALOmr>; Thu, 12 Jan 2006 15:42:47 +0100
Received: from localhost (p3016-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.16])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 121C384F5; Thu, 12 Jan 2006 23:41:08 +0900 (JST)
Date:	Thu, 12 Jan 2006 23:40:38 +0900 (JST)
Message-Id: <20060112.234038.07644223.anemo@mba.ocn.ne.jp>
To:	dan@debian.org
Cc:	linux-mips@linux-mips.org
Subject: Re: QEMU and kernel 2.6.15
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060111201354.GA22873@nevyn.them.org>
References: <20060111144355.GA17275@nevyn.them.org>
	<20060112.000904.74752908.anemo@mba.ocn.ne.jp>
	<20060111201354.GA22873@nevyn.them.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 11 Jan 2006 15:13:54 -0500, Daniel Jacobowitz <dan@debian.org> said:

dan> Just to check, could you try -m 32 or -m 128?  It shouldn't rely
dan> on more than 16MB, but the boundary condition may be wrong.

dan> Beyond that, I have no idea what might be wrong.

I tried both but it did not help.  Thank you anyway.
---
Atsushi Nemoto
