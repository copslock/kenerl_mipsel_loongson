Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g54BfCnC025199
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 04:41:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g54BfCwX025198
	for linux-mips-outgoing; Tue, 4 Jun 2002 04:41:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g54Bf1nC025195
	for <linux-mips@oss.sgi.com>; Tue, 4 Jun 2002 04:41:05 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id PAA01065;
	Tue, 4 Jun 2002 15:43:06 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA12041; Tue, 4 Jun 2002 15:36:18 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id PAA25417; Tue, 4 Jun 2002 15:37:41 +0400 (MSK)
Message-ID: <3CFCA790.9C698A6D@niisi.msk.ru>
Date: Tue, 04 Jun 2002 15:42:08 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: mb() and friends again
References: <Pine.GSO.3.96.1020603182621.14451E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej,

In previous version of your patch there was the change in mm/c-r3k.c:

static void r3k_dma_cache_wback_inv(unsigned long start, unsigned long
size)
{
-       wbflush();
+       iob();
        r3k_flush_dcache_range(start, start + size);
}

Why did you drop it? It's definetely required.

While you patch operates in unusual terms from hw point of view, it does
right thins by stating that external wbs do differ from internal wb.

Regards,
Gleb.

Ah. The patch shall be applied, certainly.
