Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:58:47 +0100 (CET)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:58707 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993932AbdKHUxok2--C convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 21:53:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174424; x=1541710424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vcrOdM94v8LUKqLm6Oc5JKKm6VgVmOfh1DUpie8h6FU=;
  b=j1muiuH1uGb82qxSGnyCwDXD3H4GQClOZdCmKTzhTCZlu82YS92dpSaj
   bhaZya58sMmGbnGAuCPZn4AwSN0g4C62NJCktgqTOYg3h41gZNzIBw542
   voPSdEvnHxshW1nrfWGXIV9nEzwcqsUv253SzHOQu/tycWXVNJodpSMXJ
   8=;
Received: from unknown (HELO fldsmtpi03.verizon.com) ([166.68.71.145])
  by fldsmtpe03.verizon.com with ESMTP; 08 Nov 2017 20:53:40 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi03.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:52:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174361; x=1541710361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vcrOdM94v8LUKqLm6Oc5JKKm6VgVmOfh1DUpie8h6FU=;
  b=YlknLmVK9xDvYlIANtu5Y+iwR+Q8YnytkRjDYiGNWic21/SnD58VedQp
   VewMfTyK/7VE5N3zll5LryoOwrMpBABvi7+8HDm+6yalnpR4+pq0uIjlh
   U+FoXlPiiWX87IbHLyn9fzd18FKM9vVmPptsa/52EIo6tE10B4VNwkruW
   8=;
Received: from pioneer.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.34])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174358; x=1541710358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vcrOdM94v8LUKqLm6Oc5JKKm6VgVmOfh1DUpie8h6FU=;
  b=Ofe7kYvMdBO2q/4QJH697y/uVh0Ig0rguDQ6CnmbZ4O32CwiZJhyYZCG
   BxeADPVcXjeDyWb5Oz88s0zYQDo+yhdBgJybfc/kckaPJgV7O19JLyOqU
   R++XwayK6ozusaqKsugYKbjAHvl9j0QnToeKNzw4pG0am9jkOmWMJX34c
   Q=;
X-Host: pioneer.tdc.vzwcorp.com
Received: from ohtwi1exh003.uswin.ad.vzwcorp.com ([10.144.218.45])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:52:38 +0000
Received: from tbwexch04apd.uswin.ad.vzwcorp.com (153.114.162.28) by
 OHTWI1EXH003.uswin.ad.vzwcorp.com (10.144.218.45) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:52:38 -0500
Received: from OMZP1LUMXCA19.uswin.ad.vzwcorp.com (144.8.22.197) by
 tbwexch04apd.uswin.ad.vzwcorp.com (153.114.162.28) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 15:52:37 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA19.uswin.ad.vzwcorp.com (144.8.22.197) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 14:52:37 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Wed, 8 Nov 2017 14:52:36 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
Subject: [PATCH AUTOSEL for-3.18 23/27] MIPS: End asm function prologue macros
 with .insn
Thread-Topic: [PATCH AUTOSEL for-3.18 23/27] MIPS: End asm function prologue
 macros with .insn
Thread-Index: AQHTWNNIDOC9+vKwDUi3XmEuGm5mwA==
Date:   Wed, 8 Nov 2017 20:51:00 +0000
Message-ID: <20171108205049.27612-23-alexander.levin@verizon.com>
References: <20171108205049.27612-1-alexander.levin@verizon.com>
In-Reply-To: <20171108205049.27612-1-alexander.levin@verizon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.144.60.250]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <alexander.levin@one.verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.levin@one.verizon.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit 08889582b8aa0bbc01a1e5a0033b9f98d2e11caa ]

When building a kernel targeting a microMIPS ISA, recent GNU linkers
will fail the link if they cannot determine that the target of a branch
or jump is microMIPS code, with errors such as the following:

    mips-img-linux-gnu-ld: arch/mips/built-in.o: .text+0x542c:
    Unsupported jump between ISA modes; consider recompiling with
    interlinking enabled.
    mips-img-linux-gnu-ld: final link failed: Bad value

or:

    ./arch/mips/include/asm/uaccess.h:1017: warning: JALX to a
    non-word-aligned address

Placing anything other than an instruction at the start of a function
written in assembly appears to trigger such errors. In order to prepare
for allowing us to follow function prologue macros with an EXPORT_SYMBOL
invocation, end the prologue macros (LEAD, NESTED & FEXPORT) with a
.insn directive. This ensures that the start of the function is marked
as code, which always makes sense for functions & safely prevents us
from hitting the link errors described above.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14508/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/include/asm/asm.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 7c26b28bf252..859cf7048347 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -54,7 +54,8 @@
 		.align	2;				\
 		.type	symbol, @function;		\
 		.ent	symbol, 0;			\
-symbol:		.frame	sp, 0, ra
+symbol:		.frame	sp, 0, ra;			\
+		.insn
 
 /*
  * NESTED - declare nested routine entry point
@@ -63,8 +64,9 @@ symbol:		.frame	sp, 0, ra
 		.globl	symbol;				\
 		.align	2;				\
 		.type	symbol, @function;		\
-		.ent	symbol, 0;			 \
-symbol:		.frame	sp, framesize, rpc
+		.ent	symbol, 0;			\
+symbol:		.frame	sp, framesize, rpc;		\
+		.insn
 
 /*
  * END - mark end of function
@@ -86,7 +88,7 @@ symbol:
 #define FEXPORT(symbol)					\
 		.globl	symbol;				\
 		.type	symbol, @function;		\
-symbol:
+symbol:		.insn
 
 /*
  * ABS - export absolute symbol
-- 
2.11.0
