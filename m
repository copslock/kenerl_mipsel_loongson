Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2004 01:16:14 +0100 (BST)
Received: from hermes.fachschaften.tu-muenchen.de ([IPv6:::ffff:129.187.202.12]:18905
	"HELO hermes.fachschaften.tu-muenchen.de") by linux-mips.org
	with SMTP id <S8225426AbUGLAQJ>; Mon, 12 Jul 2004 01:16:09 +0100
Received: (qmail 10531 invoked from network); 12 Jul 2004 00:10:25 -0000
Received: from mimas.fachschaften.tu-muenchen.de (129.187.202.58)
  by hermes.fachschaften.tu-muenchen.de with QMQP; 12 Jul 2004 00:10:25 -0000
Date: Mon, 12 Jul 2004 02:16:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: ralf@linux-mips.org, kwalker@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: 2.6: sound/oss/swarm_cs4297a.c still required?
Message-ID: <20040712001604.GH4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Return-Path: <bunk@fs.tum.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@fs.tum.de
Precedence: bulk
X-list: linux-mips

Hi,

in 2.6 (I've checked 2.6.7-mm7) sound/oss/swarm_cs4297a.c is no longer 
listed in sound/oss/Makefile. Was this accidential, or should this file 
be removed?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
