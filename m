Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 22:40:25 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:48870 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28573735AbXKZWkQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2007 22:40:16 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Iwmch-0006QN-00
	for linux-mips@linux-mips.org; Mon, 26 Nov 2007 23:40:15 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 86229C2B24; Mon, 26 Nov 2007 23:38:14 +0100 (CET)
Date:	Mon, 26 Nov 2007 23:38:14 +0100
To:	linux-mips@linux-mips.org
Subject: SGI IP28 support
Message-ID: <20071126223814.GA21339@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

I finally cleaned up Peter Fuerst's IP28 patches and solved some of
the IP28 issues in an IMHO more eye-friendly way (no ip26ucmem).
My IP28 boots with these patches from an Debian sarge NFS root and
is able to dd data from the harddrive. I'm going to send this patches
to this list and the subsystem maintainers.

There is one change missing to get a working SCSI driver, because
a proper fix will be done in 2.6.25. The quick&dirty workaround is
below. The workaround makes sure that the sense_buffer lives in
its own cache line by aligning and extendin it.

The patch "Use real cache invalidate" still contains one problem.
It will not flush the cache correctly, if the given size is bigger
than the second level cache. The problem is, that there is no index
invalidate cache operation available. I have two ideas to solve that.
One is to always do a range invalidate (maybe just by using this only
for R10k machines, which usually have quite big caches) or scan through
the cache and use the tag informations to do hit invalidate. If anybody
has a better idea please speak up :-)

Have fun with the patches,
Thomas.


diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 3f47e52..3f3d7aa 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -87,11 +87,13 @@ struct scsi_cmnd {
 	struct request *request;	/* The command we are
 				   	   working on */
 
+	unsigned char xxx1[0x48];
 #define SCSI_SENSE_BUFFERSIZE 	96
 	unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE];
 				/* obtained by REQUEST SENSE when
 				 * CHECK CONDITION is received on original
 				 * command (auto-sense) */
+	unsigned char xxx2[32];
 
 	/* Low-level done function - can be used by low-level driver to point
 	 *        to completion function.  Not used by mid/upper level code. */




-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
