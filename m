Received:  by oss.sgi.com id <S42271AbQHHU4h>;
	Tue, 8 Aug 2000 13:56:37 -0700
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:28153
        "HELO nilpferd.fachschaften.tu-muenchen.de") by oss.sgi.com with SMTP
	id <S42218AbQHHU4H>; Tue, 8 Aug 2000 13:56:07 -0700
Received: (qmail 1747 invoked from network); 8 Aug 2000 20:55:35 -0000
Received: from neptun.fachschaften.tu-muenchen.de (129.187.176.23)
  by nilpferd.fachschaften.tu-muenchen.de with SMTP; 8 Aug 2000 20:55:35 -0000
Date:   Tue, 8 Aug 2000 22:55:34 +0200 (CEST)
From:   Adrian Bunk <bunk@fs.tum.de>
X-Sender: bunk@neptun.fachschaften.tu-muenchen.de
To:     linux-mips@oss.sgi.com
Subject: Problem with recent mips kernel from CVS
Message-ID: <Pine.NEB.4.21.0008082252310.10793-100000@neptun.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

I wasn't able to configure the kernel 2.4.0-test6-pre7 from CVS without
creating the (empty) file linux/drivers/mtd/Config.in . After I created
this file, configuring worked.

cu,
Adrian

-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi
