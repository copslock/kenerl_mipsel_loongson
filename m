Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 12:57:08 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:7452
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225255AbUCZM5H>; Fri, 26 Mar 2004 12:57:07 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B6qtU-0000RP-00; Fri, 26 Mar 2004 13:57:04 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B6qtU-0006Kz-00; Fri, 26 Mar 2004 13:57:04 +0100
Date: Fri, 26 Mar 2004 13:57:04 +0100
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org
Subject: Re: linker script problem
Message-ID: <20040326125704.GF9524@rembrandt.csv.ica.uni-stuttgart.de>
References: <200403261349.41783.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403261349.41783.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Thomas Koeller wrote:
[snip]
> in line #1. The -D"LOADADDR=" looks suspicious, but I
> have not been able to trace the problem beyond this point.

You haven't told what target you are compiling for. LOADADDR should
be defined in arch/mips*/Makefile for every subarchitecture.


Thiemo
