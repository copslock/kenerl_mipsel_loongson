Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2006 13:35:35 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:26362 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038440AbWKMNfa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2006 13:35:30 +0000
Received: from localhost (p3040-ipad01funabasi.chiba.ocn.ne.jp [61.207.77.40])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 01468B7EE; Mon, 13 Nov 2006 22:35:23 +0900 (JST)
Date:	Mon, 13 Nov 2006 22:38:00 +0900 (JST)
Message-Id: <20061113.223800.98359482.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] mips hpt cleanup: make clocksource_mips public
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <455774BD.6010706@ru.mvista.com>
References: <20061112.001028.41198601.anemo@mba.ocn.ne.jp>
	<455774BD.6010706@ru.mvista.com>
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
X-archive-position: 13184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 12 Nov 2006 22:23:41 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>     Good to see it. :-)
>     I have a suggestion though...

Thank you for review.

> > -		mips_hpt_read = dec_ioasic_hpt_read;
> > +		clocksource_mips.read = dec_ioasic_hpt_read;
> 
>     I'd like to see clocksource_mips.name overriden there as well.

Yes now it is possible without touching generic code.  You can do it
if you wanted.  I do not have strong feeling for custom name :)

Main purpose of this patch is to remove mips_hpt_read (which saves a
few cycles).

---
Atsushi Nemoto
