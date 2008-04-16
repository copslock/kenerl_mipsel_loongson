Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 14:32:41 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:31702 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20023684AbYDPNci (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2008 14:32:38 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m3GDVW0V029103
	for <linux-mips@linux-mips.org>; Wed, 16 Apr 2008 06:31:32 -0700 (PDT)
Received: from [192.168.236.12] (cthulhu [192.168.236.12])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m3GDWMOB009908
	for <linux-mips@linux-mips.org>; Wed, 16 Apr 2008 06:32:28 -0700 (PDT)
Message-ID: <4805FFE6.5080903@mips.com>
Date:	Wed, 16 Apr 2008 15:32:22 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Patches for 34K APRP
Content-Type: multipart/mixed;
 boundary="------------030103020306010003010808"
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030103020306010003010808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

APRP operation of the 34K has been multiply broken
in 2.6.24.4.  The following patch set gets things
working seemingly reliably. The first two were previously
submitted to Ralf as essential to get RP programs to launch
safely. The larger third patch is new, and gets the Linux
I/O  services for the RP working again, and fixes formatting
in a few places.

Note that SMTC has scheduling problems in 2.6.24,
so testing under SMTC has been limited to boots with
only one TC acting as a Linux CPU.

	Regards,

	Kevin K.

--------------030103020306010003010808
Content-Type: text/x-patch;
 name="0001-Fixes-necessary-for-non-SMP-kernels-and-non-relocata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Fixes-necessary-for-non-SMP-kernels-and-non-relocata.pa";
 filename*1="tch"
