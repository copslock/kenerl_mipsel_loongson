Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2004 21:34:22 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:11005 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225785AbUESUeV>;
	Wed, 19 May 2004 21:34:21 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA02714;
	Wed, 19 May 2004 13:34:17 -0700
Message-ID: <40ABC4C8.4000006@mvista.com>
Date: Wed, 19 May 2004 14:34:16 -0600
From: Michael Pruznick <mpruznick@mvista.com>
Reply-To: mpruznick@mvista.com
Organization: MontaVista
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: BE pci/ide/harddisk vs localbus/pcmcia/ide/cf byteswap issues
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mpruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpruznick@mvista.com
Precedence: bulk
X-list: linux-mips

Is this problem below solved in a better way for other boards that I can
use as a template for the dbau1500be?

With the dbau1500be I'm currently using the ugly patch below so that
both pci/ide/harddisk and localbus/pcmcia/ide/cf work at the same time.

Looks like the problem I'm running into is that pci is LE and
pcmcia is BE.  Since the ide code is common it will do software
swap for both cases or neither case.  Since one is LE and the
other BE, one is always in correct byte order and the other is the
wrong byte order.  What I need is to be able to swap in one case but
not the other.

The patch below modifies the common code so that it knows the pcmcia
i/o range and corrects the byte order in that case.

The only BE bit I found for the dbau1500be pcmcia is read-only and the
manual say not to be used with pcmcia.  I verified this bit is not set
and attempting to set this bit doesn't have any effect.  I'm familiar with
the rbhma4300 which has a similar setup, but does have a pcmcia BE bit,
and does not have this problem.

===================================================================
--- drivers/pcmcia/au1000_generic.c
+++ drivers/pcmcia/au1000_generic.c
@@ -59,11 +59,17 @@
  static int pc_debug;
  #endif

+#ifndef CONFIG_CPU_LITTLE_ENDIAN
+u32 dbau1500be_pcmcia_base;
+u32 dbau1500be_pcmcia_stop;
+#endif
+
  MODULE_LICENSE("GPL");
  MODULE_AUTHOR("Pete Popov, MontaVista Software <ppopov@mvista.com>");
  MODULE_DESCRIPTION("Linux PCMCIA Card Services: Au1x00 Socket Controller");
@@ -225,6 +231,12 @@
                 }
  #endif
         }
+       #ifndef CONFIG_CPU_LITTLE_ENDIAN
+       dbau1500be_pcmcia_base = pcmcia_socket[0].virt_io;
+       dbau1500be_pcmcia_stop = pcmcia_socket[socket_count-1].virt_io + 0x1000;
+       #endif

         /* Only advertise as many sockets as we can detect: */
         if(register_ss_entry(socket_count, &au1000_pcmcia_operations)<0){
===================================================================
--- include/asm-mips/ide.h
+++ include/asm-mips/ide.h
@@ -163,9 +163,19 @@
  #define outsw(port, addr, count) ide_outsw(port, addr, count)
  #define outsl(port, addr, count) ide_outsl(port, addr, count)

+#ifdef CONFIG_MIPS_DB1500
+extern u32 dbau1500be_pcmcia_base;
+extern u32 dbau1500be_pcmcia_stop;
+#endif
+
  static inline void ide_insw(unsigned long port, void *addr, unsigned int count)
  {
         while (count--) {
+       #ifdef CONFIG_MIPS_DB1500
+       if ( ( port >= dbau1500be_pcmcia_base ) && ( port < dbau1500be_pcmcia_stop ) )
+               *(u16 *)addr = le16_to_cpu(*(volatile u16 *)(mips_io_port_base + port));
+       else
+       #endif
                 *(u16 *)addr = *(volatile u16 *)(mips_io_port_base + port);
                 addr += 2;
         }
@@ -174,6 +184,11 @@
  static inline void ide_outsw(unsigned long port, void *addr, unsigned int count)
  {
         while (count--) {
+       #ifdef CONFIG_MIPS_DB1500
+       if ( ( port >= dbau1500be_pcmcia_base ) && ( port < dbau1500be_pcmcia_stop ) )
+               *(volatile u16 *)(mips_io_port_base + (port)) = cpu_to_le16(*(u16 *)addr);
+       else
+       #endif
                 *(volatile u16 *)(mips_io_port_base + (port)) = *(u16 *)addr;
                 addr += 2;
         }
@@ -182,6 +197,11 @@
  static inline void ide_insl(unsigned long port, void *addr, unsigned int count)
  {
         while (count--) {
+       #ifdef CONFIG_MIPS_DB1500
+       if ( ( port >= dbau1500be_pcmcia_base ) && ( port < dbau1500be_pcmcia_stop ) )
+               *(u32 *)addr = le32_to_cpu(*(volatile u32 *)(mips_io_port_base + port));
+       else
+       #endif
                 *(u32 *)addr = *(volatile u32 *)(mips_io_port_base + port);
                 addr += 4;
         }
@@ -190,6 +210,11 @@
  static inline void ide_outsl(unsigned long port, void *addr, unsigned int count)
  {
         while (count--) {
+       #ifdef CONFIG_MIPS_DB1500
+       if ( ( port >= dbau1500be_pcmcia_base ) && ( port < dbau1500be_pcmcia_stop ) )
+               *(volatile u32 *)(mips_io_port_base + (port)) = cpu_to_le32(*(u32 *)addr);
+       else
+       #endif
                 *(volatile u32 *)(mips_io_port_base + (port)) = *(u32 *)addr;
                 addr += 4;
         }
===================================================================
