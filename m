Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2004 21:51:13 +0000 (GMT)
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([IPv6:::ffff:80.5.120.4]:54439
	"EHLO dhcp23.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225375AbUBYVvM>; Wed, 25 Feb 2004 21:51:12 +0000
Received: from dhcp23.swansea.linux.org.uk (localhost.localdomain [127.0.0.1])
	by dhcp23.swansea.linux.org.uk (8.12.10/8.12.10) with ESMTP id i1PLle0r026293;
	Wed, 25 Feb 2004 21:47:40 GMT
Received: (from alan@localhost)
	by dhcp23.swansea.linux.org.uk (8.12.10/8.12.10/Submit) id i1PLlcDC026291;
	Wed, 25 Feb 2004 21:47:38 GMT
X-Authentication-Warning: dhcp23.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: IDE driver problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"Liu Hongming (Alan)" <alanliu@trident.com.cn>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
In-Reply-To: <20040225181645.GA10742@linux-mips.org>
References: <15F9E1AE3207D6119CEA00D0B7DD5F680219C882@TMTMS>
	 <20040225171315.GB17217@linux-mips.org>
	 <Pine.GSO.4.58.0402251836510.2843@waterleaf.sonytel.be>
	 <20040225181645.GA10742@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1077745654.26288.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 25 Feb 2004 21:47:35 +0000
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Mer, 2004-02-25 at 18:16, Ralf Baechle wrote:
> Oh, those.  I fear every possible way to hookup the IDE bus in a more or
> particularly less intelligent way to a system has already been found out
> there ...

You would be suprised. You can do PIO IDE on just about anything. I
think the most grotesque I've seen is bitbanged IDE PIO on GPIO ports
