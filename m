Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2003 19:02:25 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:46318 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225208AbTHGSCW>;
	Thu, 7 Aug 2003 19:02:22 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA03973
	for <linux-mips@linux-mips.org>; Thu, 7 Aug 2003 11:02:09 -0700
Message-ID: <3F329421.D86566A9@mvista.com>
Date: Thu, 07 Aug 2003 12:02:09 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: PATCH:2.4:CONFIG_BINFMT_IRIX
References: <3F2FF67D.8B0C2DFB@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips

This seams to be a better way to eliminate the irix
stuff from being automatically included when switching
a board from le to be.

I tested this with config, oldconfig, menuconfig
and xconfig and in all cases the default for
CONFIG_BINFMT_IRIX is now N.


2.4
Index: arch/mips/defconfig
===================================================================
RCS file: /home/cvs/linux/arch/mips/defconfig,v
retrieving revision 1.117.2.52
diff -u -r1.117.2.52 defconfig
--- arch/mips/defconfig 16 Jul 2003 19:27:30 -0000      1.117.2.52
+++ arch/mips/defconfig 7 Aug 2003 17:44:27 -0000
@@ -112,7 +112,7 @@
 # General setup
 #
 # CONFIG_CPU_LITTLE_ENDIAN is not set
-CONFIG_BINFMT_IRIX=y
+# CONFIG_BINFMT_IRIX is not set
 CONFIG_ARC_CONSOLE=y
 # CONFIG_IP22_EISA is not set
 CONFIG_NET=y


2.6
Index: arch/mips/defconfig
===================================================================
RCS file: /home/cvs/linux/arch/mips/defconfig,v
retrieving revision 1.211
diff -u -r1.211 defconfig
--- arch/mips/defconfig 31 Jul 2003 17:28:07 -0000      1.211
+++ arch/mips/defconfig 7 Aug 2003 17:55:32 -0000
@@ -130,7 +130,7 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
-CONFIG_BINFMT_IRIX=y
+# CONFIG_BINFMT_IRIX is not set
 
 #
 # Memory Technology Devices (MTD)



Michael Pruznick wrote:
> 
> All this does is put "CONFIG_BINFMT_IRIX is not set" into the
> config files so that when switching dual-endian systems from LE
> to BE this will default to "n" instead of "y".
> 
> The main problem with this is that, in general, there is no
> need/desire to have CONFIG_BINFMT_IRIX included just because
> the kernel is BE.  Rather than being forced to disable this,
> I think the default should be off.
> 
> In some older kernels, it this causes compile errors, but that
> problem doesn't seam to exit in the latest 2.4 tree.
> 
> I tested this with menuconfig and xconfig.
> 
> I'm not an expert in all the subtle dependencies issues with
> the config.in files so there may be a better way do to this.
> 
> cvs diff -uN arch/mips/config-shared.in
> Index: arch/mips/config-shared.in
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/Attic/config-shared.in,v
> retrieving revision 1.1.2.80
> diff -u -r1.1.2.80 config-shared.in
> --- arch/mips/config-shared.in  5 Aug 2003 11:13:39 -0000       1.1.2.80
> +++ arch/mips/config-shared.in  5 Aug 2003 17:07:24 -0000
> @@ -817,6 +817,8 @@
> 
>  if [ "$CONFIG_CPU_LITTLE_ENDIAN" = "n" ]; then
>     bool 'Include IRIX binary compatibility' CONFIG_BINFMT_IRIX
> +else
> +   define_bool CONFIG_BINFMT_IRIX n
>  fi
> 
>  if [ "$CONFIG_CPU_R10000" = "y" ]; then

-- 
Michael Pruznick, michael_pruznick@mvista.com, www.mvista.com
MontaVista Software, 1237 East Arques Ave, Sunnyvale, CA 94085
direct voice/fax:970-266-1108, main office:408-328-9200
