Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2004 08:03:15 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:50059 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225200AbUAJIDO>;
	Sat, 10 Jan 2004 08:03:14 +0000
Received: from zebra.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0A83AQF014892;
	Sat, 10 Jan 2004 09:03:10 +0100 (MET)
Received: from dimitri by zebra.sonytel.be with local (Exim 3.35 #1 )
	id 1AfE5Q-0007ZW-00; Sat, 10 Jan 2004 09:03:12 +0100
Date: Sat, 10 Jan 2004 09:03:12 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
Message-ID: <20040110080312.GA28970@sonycom.com>
References: <20031223114644.GA5458@sonycom.com> <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl> <20040109220148.GA3314@sonycom.com> <20040110011922.GA14930@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110011922.GA14930@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.3.28i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Sat, Jan 10, 2004 at 02:19:22AM +0100, Thiemo Seufer wrote:
> [snip]
> The supposed way is to use -mabi=FOO -march=BAR, where BAR can also be
> e.g. "mips3". 

The -march=mipsN is from gcc-3.3 and higher, right ? 

> This will choose the proper (probably generic) architecture
> as well as the ISA defines. 

I expected, when using -march=r4100, that MIPS3 would be used. That was
apparently not the case (is this maybe a bug in gcc-3.2.2 ?).

> Btw, the ISA defines aren't used in the
> kernel anymore.

Well, asm-mips/asm.h still contains some #ifdef's based on the
_MIPS_ISA. 


Dimitri

-- 
Dimitri Torfs       |  NSCE 
dimitri@sonycom.com |  The Corporate Village
tel: +32 2 7008541  |  Da Vincilaan 7 - D1 
fax: +32 2 7008622  |  B-1935 Zaventem - Belgium
