Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2003 22:34:36 +0000 (GMT)
Received: from mailout04.sul.t-online.com ([IPv6:::ffff:194.25.134.18]:22729
	"EHLO mailout04.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225320AbTKTWeE>; Thu, 20 Nov 2003 22:34:04 +0000
Received: from fwd05.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1AMxN3-00015H-01; Thu, 20 Nov 2003 23:33:53 +0100
Received: from denx.de (E2tQDaZAZe9fDI9msO0tGD7od4PmCBGXVPHE3CeMAZpZEOlMPslIEH@[217.235.221.72]) by fmrl05.sul.t-online.com
	with esmtp id 1AMxMp-1PNhZY0; Thu, 20 Nov 2003 23:33:39 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 03CE742D86; Thu, 20 Nov 2003 23:33:36 +0100 (MET)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 03BFFC5F5F; Thu, 20 Nov 2003 23:33:35 +0100 (MET)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 0085BC5F5E; Thu, 20 Nov 2003 23:33:35 +0100 (MET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dan Malek <dan@embeddededge.com>, Colin.Helliwell@Zarlink.Com,
	linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Compressed kernels 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Thu, 20 Nov 2003 22:02:57 +0100."
             <20031120210257.GA758@linux-mips.org> 
Date: Thu, 20 Nov 2003 23:33:30 +0100
Message-Id: <20031120223335.03BFFC5F5F@atlas.denx.de>
X-Seen: false
X-ID: E2tQDaZAZe9fDI9msO0tGD7od4PmCBGXVPHE3CeMAZpZEOlMPslIEH@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20031120210257.GA758@linux-mips.org> you wrote:
>
> Compressed kernels seem to be fairly high on everybody's list.  Due to
> size limits of some boatloaders and flash memory being always too small
> and too expensive I guess there would also be some interest in bzip2
> support.

Well, instead of doing this in the Linux kernel, you could also do
it in the boot loader.  U-Boot supports both gzip and bzip2 decom-
pression.


Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If programming was easy, they wouldn't need something as  complicated
as a human being to do it, now would they?
                       - L. Wall & R. L. Schwartz, _Programming Perl_
