Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:56:57 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:14979 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225227AbTC0Cze>;
	Thu, 27 Mar 2003 02:55:34 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 2FBC446A59; Thu, 27 Mar 2003 03:54:08 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: sgiserial 3/7: globals are 0 initialized by default
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:54:08 +0100
Message-ID: <m27kalecz3.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

globals are already zero initialized.


 build/drivers/sgi/char/sgiserial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN build/drivers/sgi/char/sgiserial.c~sgiserial_zero_initialize build/drivers/sgi/char/sgiserial.c
--- 24/build/drivers/sgi/char/sgiserial.c~sgiserial_zero_initialize	2003-03-22 01:57:47.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/sgiserial.c	2003-03-22 01:58:00.000000000 +0100
@@ -49,8 +49,8 @@
 #define NUM_SERIAL 1     /* One chip on board. */
 #define NUM_CHANNELS (NUM_SERIAL * 2)
 
-struct sgi_zslayout *zs_chips[NUM_SERIAL] = { 0, };
-struct sgi_zschannel *zs_channels[NUM_CHANNELS] = { 0, 0, };
+struct sgi_zslayout *zs_chips[NUM_SERIAL];
+struct sgi_zschannel *zs_channels[NUM_CHANNELS];
 struct sgi_zschannel *zs_conschan;
 struct sgi_zschannel *zs_kgdbchan;
 

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
