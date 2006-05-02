Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 12:06:21 +0100 (BST)
Received: from host54-127.pool873.interbusiness.it ([87.3.127.54]:574 "HELO
	localhost.localdomain") by ftp.linux-mips.org with SMTP
	id S8133496AbWEBLGG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 May 2006 12:06:06 +0100
Received: by localhost.localdomain (Postfix, from userid 501)
	id D2665110DFE; Tue,  2 May 2006 13:05:56 +0200 (CEST)
Subject: ip27 not working
From:	Michele Carla` <goldfinger@member.fsf.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 02 May 2006 13:05:55 +0200
Message-Id: <1146567955.3112.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Return-Path: <goldfinger@member.fsf.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: goldfinger@member.fsf.org
Precedence: bulk
X-list: linux-mips

Yesterday I have tried last 2.6 from git on a Origin-2000, I have
xcompiled it with gcc-3.4, and booted it via tftpd with:
"bootp(): console=ttyS0 root=/dev/sda1", but after downloading the
kernel, it doesn't print anything and freeze ! any idea ?

if needed I can provide an account on the Origin 

-- 
Pluralitas non est ponenda sine neccesitate
Frustra fit per plura quod potest fieri per pauciora
Entia non sunt multiplicanda praeter necessitatem

                                   Occam's Razor

MiChele Carla` aKa Goldfinger <goldfinger@member.fsf.org>
