Received:  by oss.sgi.com id <S553851AbQJ3KlN>;
	Mon, 30 Oct 2000 02:41:13 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:30981 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553848AbQJ3KlE>;
	Mon, 30 Oct 2000 02:41:04 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6DCD99D8; Mon, 30 Oct 2000 11:41:02 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C8898900C; Mon, 30 Oct 2000 11:39:48 +0100 (CET)
Date:   Mon, 30 Oct 2000 11:39:48 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: atomic.h changes fixed bug Was: CVS Update@oss.sgi.com: linux
Message-ID: <20001030113948.B1016@paradigm.rfc822.org>
References: <20001026235921Z553785-493+346@oss.sgi.com> <20001029172517.C2663@paradigm.rfc822.org> <20001029174732.D2663@paradigm.rfc822.org> <20001030021741.B20700@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001030021741.B20700@bacchus.dhis.org>; from ralf@oss.sgi.com on Mon, Oct 30, 2000 at 02:17:41AM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 30, 2000 at 02:17:41AM +0100, Ralf Baechle wrote:
> > So it seems there is still some problem in some i/o stuff concerning
> > the different disk ...
> 
> I only get those corruption reports from Indy users but from no other
> platform.

Non Indy users also report this (Klaus Naumann e.g.) but i do not see
this on my R4400 I2 only on the R4600 Indy ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
