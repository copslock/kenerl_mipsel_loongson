Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f43Hm7e11050
	for linux-mips-outgoing; Thu, 3 May 2001 10:48:07 -0700
Received: from the-village.bc.nu (router-100M.swansea.linux.org.uk [194.168.151.17])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f43Hm6F11045
	for <linux-mips@oss.sgi.com>; Thu, 3 May 2001 10:48:06 -0700
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14vNGm-0005uW-00; Thu, 3 May 2001 18:52:04 +0100
Subject: Re: Has anyone successfully reduced the size of libc.so?
To: anthony.wei@philips.com
Date: Thu, 3 May 2001 18:52:01 +0100 (BST)
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr, brad@ltc.com
In-Reply-To: <0056910011804600000002L102*@MHS> from "anthony.wei@philips.com" at May 03, 2001 12:19:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vNGm-0005uW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Has anyone successfully  reduced the size of the libc.so?

Not much. And Ulrich made very valid points about why this would fail.
Someone should probably port newlib over as that is designed to be modular.
