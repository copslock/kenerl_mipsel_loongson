Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jan 2005 19:47:53 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:60248
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224842AbVAOTrt>; Sat, 15 Jan 2005 19:47:49 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Cpttk-0003rq-00; Sat, 15 Jan 2005 20:47:48 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Cpttk-00031c-00; Sat, 15 Jan 2005 20:47:48 +0100
Date: Sat, 15 Jan 2005 20:47:48 +0100
To: Tom =?iso-8859-1?Q?Vr=E1na?= <tom@voda.cz>
Cc: linux-mips@ftp.linux-mips.org
Subject: Re: crosscompiling and ...
Message-ID: <20050115194748.GP31149@rembrandt.csv.ica.uni-stuttgart.de>
References: <41E96411.90305@voda.cz> <20050115185509.GO31149@rembrandt.csv.ica.uni-stuttgart.de> <41E96D32.4020400@voda.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41E96D32.4020400@voda.cz>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 6928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Tom Vrána wrote:
[snip]
> Thanks, your guess is right ;-) I got that one one fixed. What I got now 
> is a complaint:
> 
> mipsIRQ.S: Assembler messages:
> mipsIRQ.S:116: Error: absolute expression required `li'
> mipsIRQ.S:120: Error: absolute expression required `and'
> mipsIRQ.S:127: Error: absolute expression required `and'
> 
> the trouble causing code is this (STATUS_IE) :
> 
> LEAF(mips_int_lock)
>         .set noreorder
>         mfc0    v0, CP0_STATUS
>         li              v1, ~STATUS_IE

STATUS_IE isn't visible for the preprocessor, which means the assembler
sees a symbol named "status_ie" instead of an immediate constant.


Thiemo
