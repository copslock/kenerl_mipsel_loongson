Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G7fi016577
	for linux-mips-outgoing; Thu, 16 Aug 2001 00:41:44 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G7fhj16574
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 00:41:43 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA28951
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 00:41:34 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA14131
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 00:41:35 -0700 (PDT)
Received: from copsun17.mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7G7eFa07018
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 09:40:15 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun17.mips.com (8.9.1/8.9.0) id JAA00025
	for linux-mips@oss.sgi.com; Thu, 16 Aug 2001 09:40:14 +0200 (MET DST)
Message-Id: <200108160740.JAA00025@copsun17.mips.com>
Subject: Patch to get IDE CDROM working on MIPS
To: linux-mips@oss.sgi.com
Date: Thu, 16 Aug 2001 09:40:14 +0200 (MET DST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have gotten IDE CDROM support to work under MIPS now (tested on Malta
both LE and BE with 2.4.3 kernel). It was broken due to a stack
overwrite in the generic cdrom.c which for obscure reasons didn't kill an
x86 kernel, but does kill a MIPS kernel, see the patch below.

The patch has been accepted by the CDROM maintainer, but in case somebody
wants to experiment with IDE CDROM now, have fun!

/Hartvig

/home/hartvige/tmp/linux-2.4.3/drivers/cdrom> diff -u cdrom.c.ORG cdrom.c
--- cdrom.c.ORG Tue Aug 14 10:35:04 2001
+++ cdrom.c     Tue Aug 14 14:44:14 2001
@@ -2244,8 +2244,13 @@
        if ((ret = cdo->generic_packet(cdi, &cgc)))
                return ret;
 
-       cgc.cmd[8] = cgc.buflen = be16_to_cpu(ti->track_information_length) +
+       cgc.buflen = be16_to_cpu(ti->track_information_length) +
                     sizeof(ti->track_information_length);
+
+       if (cgc.buflen > sizeof(track_information))
+               cgc.buflen = sizeof(track_information);
+
+       cgc.cmd[8] = cgc.buflen;
        return cdo->generic_packet(cdi, &cgc);
 }
