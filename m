Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 19:33:03 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:31567
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224861AbTDQSdA>; Thu, 17 Apr 2003 19:33:00 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 196EBt-000YRA-00
	for linux-mips@linux-mips.org; Thu, 17 Apr 2003 20:32:57 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 196EBt-0006Qc-00
	for <linux-mips@linux-mips.org>; Thu, 17 Apr 2003 20:32:57 +0200
Date: Thu, 17 Apr 2003 20:32:57 +0200
To: linux-mips@linux-mips.org
Subject: Re: What is .MIPS.options ELF section?
Message-ID: <20030417183257.GF32329@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030417094759.C1642@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030417094759.C1642@mvista.com>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:
> 
> I started to play with the new N32/N64 toolchains.  I notice a new
> section is generated for kernel, called .MIPS.options.  (it actually
> causes some grief for some firmware)
> 
> Can someone enlighten me a little bit on what it is? 

In its current state it is basically a replacement for .reginfo.
For kernels etc. it can simply be /DISCARD/'ed.


Thiemo
