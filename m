Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2003 19:25:07 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:59889 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225258AbTHESZF>;
	Tue, 5 Aug 2003 19:25:05 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA25187
	for <linux-mips@linux-mips.org>; Tue, 5 Aug 2003 11:25:02 -0700
Message-ID: <3F2FF67D.8B0C2DFB@mvista.com>
Date: Tue, 05 Aug 2003 12:25:01 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: PATCH:2.4:CONFIG_BINFMT_IRIX
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips


All this does is put "CONFIG_BINFMT_IRIX is not set" into the
config files so that when switching dual-endian systems from LE
to BE this will default to "n" instead of "y".

The main problem with this is that, in general, there is no
need/desire to have CONFIG_BINFMT_IRIX included just because
the kernel is BE.  Rather than being forced to disable this,
I think the default should be off.

In some older kernels, it this causes compile errors, but that
problem doesn't seam to exit in the latest 2.4 tree.

I tested this with menuconfig and xconfig.

I'm not an expert in all the subtle dependencies issues with
the config.in files so there may be a better way do to this.


cvs diff -uN arch/mips/config-shared.in
Index: arch/mips/config-shared.in
===================================================================
RCS file: /home/cvs/linux/arch/mips/Attic/config-shared.in,v
retrieving revision 1.1.2.80
diff -u -r1.1.2.80 config-shared.in
--- arch/mips/config-shared.in  5 Aug 2003 11:13:39 -0000       1.1.2.80
+++ arch/mips/config-shared.in  5 Aug 2003 17:07:24 -0000
@@ -817,6 +817,8 @@
 
 if [ "$CONFIG_CPU_LITTLE_ENDIAN" = "n" ]; then
    bool 'Include IRIX binary compatibility' CONFIG_BINFMT_IRIX
+else
+   define_bool CONFIG_BINFMT_IRIX n
 fi
 
 if [ "$CONFIG_CPU_R10000" = "y" ]; then
