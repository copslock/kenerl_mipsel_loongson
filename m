Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2004 19:17:35 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:49838 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225397AbUAYTRe>;
	Sun, 25 Jan 2004 19:17:34 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0PJHSw1000239;
	Sun, 25 Jan 2004 20:17:29 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id UAA18288;
	Sun, 25 Jan 2004 20:17:27 +0100 (MET)
Date: Sun, 25 Jan 2004 20:17:26 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
Message-ID: <20040125191726.GA18263@sonycom.com>
References: <20031223114644.GA5458@sonycom.com> <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl> <20040120204026.GA9470@sonycom.com> <Pine.LNX.4.55.0401211449170.11137@jurand.ds.pg.gda.pl> <20040121145120.GA14288@sonycom.com> <20040121183551.GA21411@sonycom.com> <Pine.LNX.4.55.0401221700510.16353@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401221700510.16353@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 22, 2004 at 05:10:23PM +0100, Maciej W. Rozycki wrote:
> 
>  Thanks for digging into it.  Actually after fixing the typos I've noticed
> gcc 2.95.4 always implies the ISA from the ABI unless overridden and
> -mabi=64 implies -mips4, so it bails out with -march/-mcpu set to
> something like r4600.  This also proves the uncertainity about what's
> passed to gas and so far including an ISA specification in gas settings is
> tolerable if carefully chosen.  So here's a set of new updates -- now the
> ISA specifier is removed from gcc flags only if it actually works and the
> ISA specifier for gas is untouched.
> 
>  Hopefully this is the last attempt.  Please try it.
> 

Ok for me (tested the HEAD one).

Dimitri


-- 
Dimitri Torfs       |  NSCE 
dimitri@sonycom.com |  The Corporate Village
tel: +32 2 7008541  |  Da Vincilaan 7 - D1 
fax: +32 2 7008622  |  B-1935 Zaventem - Belgium
