Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 22:09:58 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:64497 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225480AbUAOWJ5>;
	Thu, 15 Jan 2004 22:09:57 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0FM9rK21655;
	Thu, 15 Jan 2004 14:09:53 -0800
Date: Thu, 15 Jan 2004 14:09:53 -0800
From: Jun Sun <jsun@mvista.com>
To: Kevin Paul Herbert <kph@cisco.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [PATCH 2.6] DEBUG_INFO, KGDB and etc...
Message-ID: <20040115140953.F18368@mvista.com>
References: <20040115112201.E18368@mvista.com> <1074196652.24675.28.camel@shakedown>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1074196652.24675.28.camel@shakedown>; from kph@cisco.com on Thu, Jan 15, 2004 at 11:57:35AM -0800
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2004 at 11:57:35AM -0800, Kevin Paul Herbert wrote:
> In the top level makefile, there is already:
> 
> 	ifdef CONFIG_DEBUG_INFO
> 	CFLAGS		+= -g
> 	endif
> 
> I don't see why you need to add it to arch/mips/Makefile. Your Kconfig
> changes seem fine though.
> 

That is right.  Thanks for catching this.

The original problem started when KGDB did not cause "-g" to be included.
I simply looked at 2.4 and cooked the patch.  

The corrected patch is attached.

Jun

--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk1

diff -Nru link/arch/mips/Kconfig.orig link/arch/mips/Kconfig
--- link/arch/mips/Kconfig.orig	Thu Jan 15 10:55:57 2004
+++ link/arch/mips/Kconfig	Thu Jan 15 11:12:23 2004
@@ -1233,23 +1233,6 @@
 	  This allows applications to run more reliably even when the system is
 	  under load.
 
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	default y if KGDB
-	help
-	  If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
-
-config SB1XXX_CORELIS
-	bool "Corelis Debugger"
-	depends on SIBYTE_SB1xxx_SOC && DEBUG_INFO
-	help
-	  Select compile flags that produce code that can be processed by the
-	  Corelis mksym utility and UDB Emulator.
-
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
 	depends on DEBUG_KERNEL
@@ -1471,6 +1454,7 @@
 config KGDB
 	bool "Remote GDB kernel debugging"
 	depends on DEBUG_KERNEL
+	select DEBUG_INFO
 	help
 	  If you say Y here, it will be possible to remotely debug the MIPS
 	  kernel using gdb. This enlarges your kernel image disk size by
@@ -1486,6 +1470,23 @@
 	  would like kernel messages to be formatted into GDB $O packets so
 	  that GDB prints them as program output, say 'Y'.
 
+config DEBUG_INFO
+	bool "Compile the kernel with debug info"
+	depends on DEBUG_KERNEL && !KGDB
+	default y if KGDB
+	help
+	  If you say Y here the resulting kernel image will include
+	  debugging info resulting in a larger kernel image.
+	  Say Y here only if you plan to use gdb to debug the kernel.
+	  If you don't debug the kernel, you can say N.
+
+config SB1XXX_CORELIS
+	bool "Corelis Debugger"
+	depends on SIBYTE_SB1xxx_SOC && DEBUG_INFO
+	help
+	  Select compile flags that produce code that can be processed by the
+	  Corelis mksym utility and UDB Emulator.
+
 config RUNTIME_DEBUG
 	bool "Enable run-time debugging"
 	depends on DEBUG_KERNEL

--UFHRwCdBEJvubb2X--
