Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 17:16:42 +0000 (GMT)
Received: from p508B7F2C.dip.t-dialin.net ([IPv6:::ffff:80.139.127.44]:48925
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225322AbUKURQi>; Sun, 21 Nov 2004 17:16:38 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iALHESlA009204;
	Sun, 21 Nov 2004 18:14:28 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iALHENOr009203;
	Sun, 21 Nov 2004 18:14:23 +0100
Date: Sun, 21 Nov 2004 18:14:23 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ip32 build fix
Message-ID: <20041121171423.GA9177@linux-mips.org>
References: <20041121024144.GK20986@rembrandt.csv.ica.uni-stuttgart.de> <20041121065630.GA6701@linux-mips.org> <Pine.GSO.4.61.0411211017350.19680@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0411211017350.19680@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 21, 2004 at 10:18:26AM +0100, Geert Uytterhoeven wrote:

> FYI, this has been fixed differently in mainline:

Argh, I hat that.  Defining variables in the middle of a block is also
unhealthy ...

  Ralf
