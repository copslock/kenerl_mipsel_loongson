Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 20:40:34 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:65489 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225559AbUATUkd>;
	Tue, 20 Jan 2004 20:40:33 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0KKeTw1006574;
	Tue, 20 Jan 2004 21:40:29 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id VAA09656;
	Tue, 20 Jan 2004 21:40:28 +0100 (MET)
Date: Tue, 20 Jan 2004 21:40:28 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
Message-ID: <20040120204026.GA9470@sonycom.com>
References: <20031223114644.GA5458@sonycom.com> <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 20, 2004 at 01:37:16PM +0100, Maciej W. Rozycki wrote:
> 
>  It took a bit longer than I planned, sorry.  Anyway, here are two
> functionally equivalent patches, for 2.4 and the head, that remove an ISA
> specification if a tool supports "-march=" and "-mabi=" at the same time.  
> Please try the appropriate one.
> 

Tried the head one, it had some typos (patch follows). Unfortunately, as I wrote
earlier, gcc-3.2 doesn't set the ISA correctly when using -march=, so
it doesn't work for 3.2. 


--- linux-mips-2.6.orig/arch/mips/Makefile	2004-01-06 21:17:57.000000000 +0100
+++ linux.work/arch/mips/Makefile	2004-01-20 21:14:12.000000000 +0100
@@ -111,6 +111,12 @@
 if test x$(gcc-abi) != x$(gas-abi); then \
 	gas_abi="-Wa,-$(gas-abi) -Wa,-mgp$(gcc-abi)"; \
 fi; \
+if test "$$gcc_opt" = -march= && test -n "$$gcc_abi"; then \
+	gcc_isa=; \
+fi; \
+if test "$$gas_opt" = -Wa,-march= && test -n "$$gas_abi"; then \
+	gas_isa=; \
+fi; \
 echo $$gcc_abi $$gcc_opt$$gcc_cpu $$gcc_isa $$gas_abi $$gas_opt$$gas_cpu $$gas_isa)
 
 #


-- 
Dimitri Torfs       |  NSCE 
dimitri@sonycom.com |  The Corporate Village
tel: +32 2 7008541  |  Da Vincilaan 7 - D1 
fax: +32 2 7008622  |  B-1935 Zaventem - Belgium
