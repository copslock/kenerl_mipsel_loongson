Received:  by oss.sgi.com id <S554258AbRBEPnq>;
	Mon, 5 Feb 2001 07:43:46 -0800
Received: from sovereign.org ([209.180.91.170]:27526 "EHLO lux.homenet")
	by oss.sgi.com with ESMTP id <S554255AbRBEPnd>;
	Mon, 5 Feb 2001 07:43:33 -0800
Received: (from jfree@localhost)
	by lux.homenet (8.11.2/8.11.2/Debian 8.11.2-1) id f15Fhdd07846
	for linux-mips@oss.sgi.com; Mon, 5 Feb 2001 08:43:39 -0700
From:   Jim Freeman <jfree@sovereign.org>
Date:   Mon, 5 Feb 2001 08:43:38 -0700
To:     linux-mips@oss.sgi.com
Subject: mips/config.in: CONFIG_SMP ?
Message-ID: <20010205084338.A7739@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

One of the following patches should be applied (parisc/config.in
does the former ...) ?


--- linux/arch/mips/config.in	2001/02/05 15:17:46	1.1
+++ linux/arch/mips/config.in	2001/02/05 15:40:52
@@ -3,6 +3,7 @@
 # see Documentation/kbuild/config-language.txt.
 #
 define_bool CONFIG_MIPS y
+define_bool CONFIG_SMP n
 
 mainmenu_name "Linux Kernel Configuration"
 



--- linux/arch/mips/config.in	2001/02/05 15:17:46	1.1
+++ linux/arch/mips/config.in	2001/02/05 15:18:06
@@ -460,7 +460,5 @@
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
-if [ "$CONFIG_SMP" != "y" ]; then
-   bool 'Run uncached' CONFIG_MIPS_UNCACHED
-fi
+bool 'Run uncached' CONFIG_MIPS_UNCACHED
 endmenu
