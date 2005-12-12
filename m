Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2005 20:48:09 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:28623 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S8133561AbVLLUru (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Dec 2005 20:47:50 +0000
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 29DED707DB;
	Mon, 12 Dec 2005 21:48:09 +0100 (CET)
X-Auth-Info: RZkLzvwwc5bJR3JRqsRUpwhQeQj5KkzHbuuowkI1cNs=
X-Auth-Info: RZkLzvwwc5bJR3JRqsRUpwhQeQj5KkzHbuuowkI1cNs=
Received: from mail.denx.de (p549661B8.dip.t-dialin.net [84.150.97.184])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 1058E93E01;
	Mon, 12 Dec 2005 21:48:09 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 64D55180019;
	Mon, 12 Dec 2005 21:48:08 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 4A664353A44;
	Mon, 12 Dec 2005 21:48:08 +0100 (MET)
To:	Rodolfo Giometti <giometti@linux.it>
cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: advice on JTAG 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 12 Dec 2005 21:40:35 +0100."
             <20051212204035.GL5132@hulk.enneenne.com> 
Date:	Mon, 12 Dec 2005 21:48:08 +0100
Message-Id: <20051212204808.4A664353A44@atlas.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20051212204035.GL5132@hulk.enneenne.com> you wrote:
> 
> I'm looking for a good JTAG system to debug a MIPS AU1100 based
> board.

Abatron BDI2000...

> I'd like to have the possibility to put hardware and software break
> points in u-boot and linux source code. Also I prefere a system who
> completely supports the GNU/Linux system as host.

...with firmware "bdiGDB".

> Can you please suggest me some links? :)

http://www.abatron.ch/products/xr/aspx/r.1/Sv.63713d7b43526570313d7b693d394f54565743484b33513244474b394a594556537d7d/rx/products_detail.htm

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Faith may be defined briefly as an illogical belief in the  occurence
of the improbable.                                    - H. L. Mencken
