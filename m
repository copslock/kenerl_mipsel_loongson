Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 16:55:32 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.181]:47449 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023257AbXFRPz3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 16:55:29 +0100
Received: by py-out-1112.google.com with SMTP id f31so3333137pyh
        for <linux-mips@linux-mips.org>; Mon, 18 Jun 2007 08:55:28 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ln0m+VKbEQ4vp9Cr18y/LGfZvEo9trg0BlFr4JBF4pCVgL4Ze63kJzqUSWb4twG9NdH6hThACEhsUGKHh2XYqOyaYLklEtxRSkLVLs57LZCH3MUMzGvs3ii8aovLY6X0rIW2nXL9MrWRCe8RkzgYKGAwJU/wBehy4qQmnyyexnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pqn2/awg2nbUsaiT+PucshbFyG+B4Tnsm4e2unEBL6gRUhzKj3eBWwl3BPAWgkG0nih0K1v5DVKbLYpHvWb+Jq2YM48lTeUgo26PePQOTziSp6bgJcaLYal4dZie8JzAggAYkF1vY4sLHWkFPLM09ous2pXHJJwM1tpsvPREUEw=
Received: by 10.65.214.2 with SMTP id r2mr9663124qbq.1182182128257;
        Mon, 18 Jun 2007 08:55:28 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Mon, 18 Jun 2007 08:55:28 -0700 (PDT)
Message-ID: <cda58cb80706180855k5eaa732aufc937980acf7d037@mail.gmail.com>
Date:	Mon, 18 Jun 2007 17:55:28 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <cda58cb80706180838t4b51c3e4v1392ab4c76773d43@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	 <11818164024053-git-send-email-fbuihuu@gmail.com>
	 <20070614.212913.82089068.nemoto@toshiba-tops.co.jp>
	 <20070617000448.GA30807@linux-mips.org>
	 <cda58cb80706180722n18e79a49vfa61450526e6af76@mail.gmail.com>
	 <20070618151422.GA4864@linux-mips.org>
	 <cda58cb80706180838t4b51c3e4v1392ab4c76773d43@mail.gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/18/07, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Hi Ralf,
>
> On 6/18/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Mon, Jun 18, 2007 at 04:22:39PM +0200, Franck Bui-Huu wrote:
> >
> > > were an interface for _generic_ rtc only. But all the following
> > > platforms don't seem to use the generic rtc though it initialises
> > > these function pointers... Any idea why ?
> >
> > Because unless drivers/char/Kconfig is getting changed to prevent that is
> > is possible to enable CONFIG_GEN_RTC, so this code was necessary for
> > correctness.
>
> Sorry I don't understand...
>

Ok I think I'm understanding now. So you mean that most of the
following platforms:

    arch/mips/ddb5xxx/common/rtc_ds1386.c
    arch/mips/dec/time.c
    arch/mips/lasat/setup.c
    arch/mips/mips-boards/atlas/atlas_setup.c
    arch/mips/mips-boards/malta/malta_setup.c
    arch/mips/momentum/ocelot_3/setup.c
    arch/mips/momentum/ocelot_c/setup.c
    arch/mips/pmc-sierra/yosemite/setup.c
    arch/mips/sgi-ip22/ip22-time.c
    arch/mips/sgi-ip32/ip32-setup.c
    arch/mips/sibyte/swarm/setup.c
    arch/mips/sni/a20r.c
    arch/mips/sni/pcimt.c
    arch/mips/sni/pcit.c
    arch/mips/sni/rm200.c
    arch/mips/tx4938/common/rtc_rx5c348.c

implements set and get rtc functions because genrtc can be enabled in
Kconfig ???

If so what about the following patch:

-- 8< --

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 55253a6..e8f3b0c 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -813,7 +813,7 @@ config SGI_IP27_RTC

 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV &&
!S390 && !SUPERH
+	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV &&
!S390 && !SUPERH && !MIPS
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- >8 --

and burn all the genrtc platform methods ?

Thanks
-- 
               Franck
