Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f81EwhV13559
	for linux-mips-outgoing; Sat, 1 Sep 2001 07:58:43 -0700
Received: from fe010.worldonline.dk (fe010.worldonline.dk [212.54.64.195])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f81Ewfd13556
	for <linux-mips@oss.sgi.com>; Sat, 1 Sep 2001 07:58:41 -0700
Received: (qmail 22617 invoked by uid 0); 1 Sep 2001 14:58:34 -0000
Received: from 213.237.49.98.skovlyporten.dk (HELO tuxedo.skovlyporten.dk) (213.237.49.98)
  by fe010.worldonline.dk with SMTP; 1 Sep 2001 14:58:34 -0000
Received: by tuxedo.skovlyporten.dk (Postfix, from userid 501)
	id E3AA47CF9; Sat,  1 Sep 2001 16:58:42 +0200 (CEST)
Date: Sat, 1 Sep 2001 16:58:42 +0200
From: Lars Munch <lars@segv.dk>
To: linux-mips@oss.sgi.com
Subject: set_except_vector question
Message-ID: <20010901165842.B13357@tuxedo.skovlyporten.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi

I have been looking at the set_except_vector function in
arch/mips[64]/kernel/traps.c and wondering why the handler
address is changed/recalculated before it is stored:

*(volatile u32 *)(KSEG0+0x200) = 0x08000000 | (0x03ffffff & (handler >> 2));
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  

Could someone please enlighten me?

Thanks
Lars Munch 
