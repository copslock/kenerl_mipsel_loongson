Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2003 19:49:26 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:61853
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225352AbTJaTtO>; Fri, 31 Oct 2003 19:49:14 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AFfGX-0007l7-00; Fri, 31 Oct 2003 13:49:01 -0600
Message-ID: <3FA2BCA5.6070604@realitydiluted.com>
Date: Fri, 31 Oct 2003 14:48:53 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: David Kesselring <dkesselr@mmc.atmel.com>
CC: linux-mips@linux-mips.org
Subject: Re: latest build - xconfig
References: <Pine.GSO.4.44.0310311420480.22698-100000@ares.mmc.atmel.com>
In-Reply-To: <Pine.GSO.4.44.0310311420480.22698-100000@ares.mmc.atmel.com>
Content-Type: multipart/mixed;
 boundary="------------030003030004090309030609"
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030003030004090309030609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Kesselring wrote:
> It seems like xconfig is broken on the code currently in cvs.
> ./tkparse < ../arch/mips/config.in >> kconfig.tk
> arch/mips/config-shared.in: 894: can't handle
> dep_bool/dep_mbool/dep_tristate condition
> make[1]: *** [kconfig.tk] Error 1
> 
I just checked in the fix. Here's the patch too for reference.

-Steve

--------------030003030004090309030609
Content-Type: text/plain;
 name="eisa-xconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eisa-xconfig.patch"

Index: config-shared.in
===================================================================
RCS file: /home/cvs/linux/arch/mips/Attic/config-shared.in,v
retrieving revision 1.1.2.91
diff -u -r1.1.2.91 config-shared.in
--- config-shared.in	22 Oct 2003 06:58:37 -0000	1.1.2.91
+++ config-shared.in	31 Oct 2003 19:47:28 -0000
@@ -891,7 +891,7 @@
 
 if [ "$CONFIG_SGI_IP22" = "y" -o "$CONFIG_MIPS_MAGNUM_4000" = "y" -o \
      "$CONFIG_OLIVETTI_M700" = "y" -o "$CONFIG_SNI_RM200_PCI" = "y" ]; then
-   dep_bool 'EISA bus support' CONFIG_EISA
+   bool 'EISA bus support' CONFIG_EISA
 fi
 
 if [ "$CONFIG_PCI" != "y" ]; then

--------------030003030004090309030609--
