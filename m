Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2008 15:24:04 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:34986 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S28586771AbYECOYB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 May 2008 15:24:01 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m43EMjQ9024475
	for <linux-mips@linux-mips.org>; Sat, 3 May 2008 07:22:46 -0700 (PDT)
Received: from [192.168.236.12] (cthulhu [192.168.236.12])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m43ENgX3029794
	for <linux-mips@linux-mips.org>; Sat, 3 May 2008 07:23:44 -0700 (PDT)
Message-ID: <481C756E.4070806@mips.com>
Date:	Sat, 03 May 2008 16:23:42 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	Linux MIPS Org <linux-mips@linux-mips.org>
Subject: Patch to APRP ELF Loader
Content-Type: multipart/mixed;
 boundary="------------000005000500030307010207"
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000005000500030307010207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please find attached a patch to the APRP ELF loader (vpe.c)
for the MIPS 34K which provides several requested/needed
fixes and enhancements, most notably in allowing large
stripped ELF binaries to be launched on the RP.

	Regards,

	Kevin K.

--------------000005000500030307010207
Content-Type: text/x-patch;
 name="0001-Rewrite-of-APRP-VPE-ELF-Loader.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Rewrite-of-APRP-VPE-ELF-Loader.patch"
