Received:  by oss.sgi.com id <S42253AbQFNTQ6>;
	Wed, 14 Jun 2000 12:16:58 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:43864 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42195AbQFNTQh>; Wed, 14 Jun 2000 12:16:37 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA08238
	for <linux-mips@oss.sgi.com>; Wed, 14 Jun 2000 12:21:38 -0700 (PDT)
	mail_from (tsbogend@alpha.franken.de)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA53112
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Jun 2000 12:16:10 -0700 (PDT)
	mail_from (tsbogend@alpha.franken.de)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08909
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jun 2000 12:16:01 -0700 (PDT)
	mail_from (tsbogend@alpha.franken.de)
Received: by rachael.franken.de 
	for linux@cthulhu.engr.sgi.com
	id m132Idv-00285JC; Wed, 14 Jun 2000 21:16:03 +0200 (MET DST)
Received: from dns.franken.de(193.175.24.33), claiming to be "chico.franken.de"
 via SMTP by rachael.franken.de, id smtpdAAAa17379; Wed Jun 14 21:15:32 2000
Received: by chico.franken.de with UUCP 
	for linux@cthulhu.engr.sgi.com
	id m132IdP-005DCnC; Wed, 14 Jun 2000 21:15:31 +0200 (MET DST)
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA02042;
	Wed, 14 Jun 2000 21:14:04 +0200
Date:   Wed, 14 Jun 2000 21:14:03 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Guido Guenther <guido.guenther@gmx.net>, linux@cthulhu.engr.sgi.com
Subject: Re: newport: glyph cursor and cmap
Message-ID: <20000614211403.A1996@alpha.franken.de>
References: <20000614125351.A24432@bert.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000614125351.A24432@bert.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Wed, Jun 14, 2000 at 12:53:52PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jun 14, 2000 at 12:53:52PM +0200, Guido Guenther wrote:
> I'm currently trying to add a hw-cursor to the xserver. As far as I
> understand the xmap9 docs the cursor has its own colormap on the cmap
> chip sperate from the "normal" colormap. Can someone provide a small
> codepiece or docs on how two manipulate this part of the cmap chip(via the
> dcb)?  (i didn't find anything about the cmap chips on oss.sgi.com).

have you looked at newport_con.c ? It uses a hardware cursor.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
