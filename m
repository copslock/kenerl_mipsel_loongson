Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 12:55:12 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:41316
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225007AbUIPLzI>; Thu, 16 Sep 2004 12:55:08 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1C7uqw-0001Jd-00; Thu, 16 Sep 2004 13:55:06 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1C7uqv-0004QS-00; Thu, 16 Sep 2004 13:55:05 +0200
Date: Thu, 16 Sep 2004 13:55:05 +0200
To: Filip Onkelinx <Filip@Linux4.Be>
Cc: linux-mips@linux-mips.org
Subject: Re: vr4131 : cache/linesize
Message-ID: <20040916115505.GF21351@rembrandt.csv.ica.uni-stuttgart.de>
References: <41497B5B.8000402@Linux4.Be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41497B5B.8000402@Linux4.Be>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Filip Onkelinx wrote:
[snip]
> Any idea why the reported icache linesize is different between2.4 and 
> 2.6 ? Which one should I trust ?

Because the old 2.4 reporting was broken. 2.4.27 should report the same
as 2.6.8.


Thiemo
