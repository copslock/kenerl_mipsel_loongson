Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2004 16:10:16 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:44318
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225383AbUA0QKP>; Tue, 27 Jan 2004 16:10:15 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AlVn1-0004E6-00; Tue, 27 Jan 2004 17:10:11 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AlVn1-0000ho-00; Tue, 27 Jan 2004 17:10:11 +0100
Date: Tue, 27 Jan 2004 17:10:11 +0100
To: kip.r2@free.fr
Cc: linux-mips@linux-mips.org
Subject: Re: MIPS Kernel size
Message-ID: <20040127161011.GI1315@rembrandt.csv.ica.uni-stuttgart.de>
References: <1075215091.40167af364b77@imp1-a.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075215091.40167af364b77@imp1-a.free.fr>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

kip.r2@free.fr wrote:
> What will be the approximate size for a minimal MIPS kernel?

IIRC a 2.4 kernel with the bare minimum to boot on a cobalt
machine is a bit below 600k compressed. You will miss many
drivers on such a System. :-)


Thiemo
