Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Sep 2002 14:16:26 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:30117 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122960AbSIIMQZ>;
	Mon, 9 Sep 2002 14:16:25 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g89CGGUD004226;
	Mon, 9 Sep 2002 05:16:17 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA03562;
	Mon, 9 Sep 2002 05:16:17 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g89CGDb24282;
	Mon, 9 Sep 2002 14:16:13 +0200 (MEST)
Message-ID: <3D7C910A.6D217586@mips.com>
Date: Mon, 09 Sep 2002 14:16:10 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: 64-bit kernel patch
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

I have send this patch before, although it's a little bit different from
the previous one.
The patch fixes the ipc syscalls in the o32 wrapper/conversion routines,
which is needed when running a 64-bit kernel on an o32 userland.
Ralf, could you please apply.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
