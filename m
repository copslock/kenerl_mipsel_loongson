Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 14:48:17 +0000 (GMT)
Received: from mail.baslerweb.com ([145.253.187.130]:20892 "EHLO
	mail.baslerweb.com") by ftp.linux-mips.org with ESMTP
	id S20022301AbXCMOsM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2007 14:48:12 +0000
Received: (from smtpd@127.0.0.1) by mail.baslerweb.com (8.13.4/8.13.4)
	id l2DEj2q0015784; Tue, 13 Mar 2007 15:45:02 +0100
Received: from unknown [172.16.20.75] by gateway id /processing/kwDbU8kk; Tue Mar 13 15:45:02 2007
Received: from ahr040s.basler.corp ([172.16.20.40]) by AHR075S.basler.corp with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 13 Mar 2007 15:45:02 +0100
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To:	Ralf Baechle <ralf@linux-mips.org>
Date:	Tue, 13 Mar 2007 15:45:00 +0100
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org
References: <20070313142230.GA692@linux-mips.org>
In-Reply-To: <20070313142230.GA692@linux-mips.org>
MIME-Version: 1.0
Message-Id: <200703131545.01221.thomas.koeller@baslerweb.com>
X-OriginalArrivalTime: 13 Mar 2007 14:45:02.0139 (UTC) FILETIME=[2E5BA0B0:01C7657E]
X-SecurE-Mail-Gateway: Version: 5.00.3.1 (smtpd: 6.53.8.7) Date: 20070313144502Z
Subject: Re: Oscar awards
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Tuesday 13 March 2007 15:22, Ralf Baechle wrote:
> So with the Viper 2 (non-)support gone all but one of the 46 MIPS defconfig
> files actually build with the one exception being excite_defconfig:
> 
>   CC      arch/mips/basler/excite/excite_prom.o
>   CC      arch/mips/basler/excite/excite_setup.o
> arch/mips/basler/excite/excite_setup.c: In function 'excite_init_console':
> arch/mips/basler/excite/excite_setup.c:115: error: 'UPIO_RM9000' undeclared (first use in this function)
> arch/mips/basler/excite/excite_setup.c:115: error: (Each undeclared identifier is reported only once
> arch/mips/basler/excite/excite_setup.c:115: error: for each function it appears in.)
> arch/mips/basler/excite/excite_setup.c:116: error: 'PORT_RM9000' undeclared (first use in this function)
> make[1]: *** [arch/mips/basler/excite/excite_setup.o] Error 1
> make: *** [arch/mips/basler/excite] Error 2
> make: Leaving directory `/var/tmp/kernel-orig'

This will change as soon as the rm9k_serial-patches currently in the -mm tree are merged upstream.
Btw., any comments about http://www.linux-mips.org/archives/linux-mips/2007-03/msg00012.html?

regards,
tk

-- 
_______________________________

Thomas Köller, Software Developer

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel. +49 (0) 4102 - 463 390
Fax +49 (0) 4102 - 463 390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com

Vorstand: Dr.-Ing. Dietmar Ley (Vorsitzender) · John P. Jennings · Peter Krumhoff · Aufsichtsratsvorsitzender: Norbert Basler
Basler AG · Amtsgericht Ahrensburg HRB 4090 · Ust-IdNr.: DE 135 098 121 · Steuer-Nr.: 30 292 04497

_______________________________
