Received:  by oss.sgi.com id <S554011AbRBNVUR>;
	Wed, 14 Feb 2001 13:20:17 -0800
Received: from sovereign.org ([209.180.91.170]:9118 "EHLO lux.homenet")
	by oss.sgi.com with ESMTP id <S554008AbRBNVUD>;
	Wed, 14 Feb 2001 13:20:03 -0800
Received: (from jfree@localhost)
	by lux.homenet (8.11.2/8.11.2/Debian 8.11.2-1) id f1ELKOM05658;
	Wed, 14 Feb 2001 14:20:24 -0700
From:   Jim Freeman <jfree@sovereign.org>
Date:   Wed, 14 Feb 2001 14:20:24 -0700
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: bi-endian toolchain switches
Message-ID: <20010214142024.A5614@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

For bi-endian cross-compiler toolchains, something akin to the following
patch can be helpful for setting endianness switches according to
CONFIG_CPU_LITTLE_ENDIAN :

	--- linux/arch/mips/Makefile	2001/02/14 21:04:31	1.1
	+++ linux/arch/mips/Makefile	2001/02/14 21:07:00
	@@ -18,9 +18,13 @@
	 ifdef CONFIG_CPU_LITTLE_ENDIAN
	 tool-prefix	= mipsel-linux-
	 output-format	= elf32-littlemips
	+export LD		= $(CROSS_COMPILE)ld -EL
	+export CC		= $(CROSS_COMPILE)cc -EL
	 else
	 tool-prefix	= mips-linux-
	 output-format	= elf32-bigmips
	+export LD		= $(CROSS_COMPILE)ld -EB
	+export CC		= $(CROSS_COMPILE)cc -EB
	 endif
	 
	 ifdef CONFIG_CROSSCOMPILE
