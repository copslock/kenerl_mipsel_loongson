Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f86KZoM26093
	for linux-mips-outgoing; Thu, 6 Sep 2001 13:35:50 -0700
Received: from relay ([207.81.96.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f86KZkd26087
	for <linux-mips@oss.sgi.com>; Thu, 6 Sep 2001 13:35:46 -0700
Received: from quicklogic.com ([207.81.96.153])
	by relay (8.8.7/8.8.7) with ESMTP id RAA13938
	for <linux-mips@oss.sgi.com>; Thu, 6 Sep 2001 17:10:49 -0400
Message-ID: <3B97DE48.10507@quicklogic.com>
Date: Thu, 06 Sep 2001 16:36:24 -0400
From: Dan Aizenstros <dan@quicklogic.com>
Organization: QuickLogic Canada
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Changes to arch/mips/kernel/setup.c
Content-Type: multipart/mixed;
 boundary="------------030203010705080500010207"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------030203010705080500010207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello All,

The latest changes to the setup.c file does not work correctly and
cause a compile failure.  I have attached a patch which fixes it.

Dan Aizenstros
QuickLogic Canada

--------------030203010705080500010207
Content-Type: text/plain;
 name="setup.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup.c.diff"

Index: setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.70
diff -u -r1.70 setup.c
--- setup.c	2001/09/06 02:42:30	1.70
+++ setup.c	2001/09/06 20:32:43
@@ -367,12 +367,12 @@
 				mips_cpu.options |= MIPS_CPU_FPU;
 			mips_cpu.scache.flags = MIPS_CACHE_NOT_PRESENT;
 			break;
-#endif /* CONFIG_CPU_MIPS32 */
 		default:
 			mips_cpu.cputype = CPU_UNKNOWN;
 			break;
 		}
 		break;
+#endif /* CONFIG_CPU_MIPS32 */
 	case PRID_COMP_SIBYTE:
 		switch (mips_cpu.processor_id & 0xff00) {
 		case PRID_IMP_SB1:

--------------030203010705080500010207--
