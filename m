Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Feb 2003 22:08:02 +0000 (GMT)
Received: from p508B76F7.dip.t-dialin.net ([IPv6:::ffff:80.139.118.247]:49054
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224939AbTBBWIB>; Sun, 2 Feb 2003 22:08:01 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h12M80u02256;
	Sun, 2 Feb 2003 23:08:00 +0100
Date: Sun, 2 Feb 2003 23:08:00 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix r3k exception handler location
Message-ID: <20030202230800.A2213@linux-mips.org>
References: <20030202214952.GL30469@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030202214952.GL30469@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Sun, Feb 02, 2003 at 10:49:52PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 02, 2003 at 10:49:52PM +0100, Thiemo Seufer wrote:

> this patch is untested, but I just can't see how a r3k can boot without it.

Because it's not a R4000 ;-)

R3000 has different exception vector locations than R4000.

  Ralf
