Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jan 2005 14:40:29 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:34404
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224947AbVAIOkY>; Sun, 9 Jan 2005 14:40:24 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CneEv-00064U-00; Sun, 09 Jan 2005 15:40:21 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CneEq-0002EY-00; Sun, 09 Jan 2005 15:40:16 +0100
Date: Sun, 9 Jan 2005 15:40:16 +0100
To: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Cc: linux-mips@linux-mips.org
Subject: Re: IP32 RTC fixlet
Message-ID: <20050109144016.GP31335@rembrandt.csv.ica.uni-stuttgart.de>
References: <41E0B2C2.7000909@total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E0B2C2.7000909@total-knowledge.com>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ilya A. Volynets-Evenbakh wrote:
> IP32 power button delivers interrupt throug RTC,
> so we can't let generic RTC driver use this interrupt.
> Following patchlet allows us to still use generic RTC driver
> to read/write time, and yet support handling button presses.

Applied, with the include for it removed as well.


Thiemo
