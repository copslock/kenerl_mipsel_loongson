Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 14:43:00 +0100 (BST)
Received: from dns0.mips.com ([63.167.95.198]:40662 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20023719AbYDPNm5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2008 14:42:57 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m3GDfraa029120
	for <linux-mips@linux-mips.org>; Wed, 16 Apr 2008 06:41:53 -0700 (PDT)
Received: from [192.168.236.12] (cthulhu [192.168.236.12])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m3GDgmtj010150
	for <linux-mips@linux-mips.org>; Wed, 16 Apr 2008 06:42:49 -0700 (PDT)
Message-ID: <48060258.8050904@mips.com>
Date:	Wed, 16 Apr 2008 15:42:48 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Patches for 34K APRP
References: <4805FFE6.5080903@mips.com>
In-Reply-To: <4805FFE6.5080903@mips.com>
Content-Type: multipart/mixed;
 boundary="------------090906030603000704070808"
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090906030603000704070808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sigh.  Some mailers (including Thunderbird for Windows)
seem to be unable to handle the attachment of the patch
files by Thunderbird.  So I attach them as a .tgz, which
even Outlook should be able to deal with correctly.

	Regards,

	Kevin K.

Kevin D. Kissell wrote:
> APRP operation of the 34K has been multiply broken
> in 2.6.24.4.  The following patch set gets things
> working seemingly reliably. The first two were previously
> submitted to Ralf as essential to get RP programs to launch
> safely. The larger third patch is new, and gets the Linux
> I/O  services for the RP working again, and fixes formatting
> in a few places.
> 
> Note that SMTC has scheduling problems in 2.6.24,
> so testing under SMTC has been limited to boots with
> only one TC acting as a Linux CPU.
> 
>     Regards,
> 
>     Kevin K.


--------------090906030603000704070808
Content-Type: application/x-compressed-tar;
 name="aprprollup_160408.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="aprprollup_160408.tgz"

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
--------------090906030603000704070808--
