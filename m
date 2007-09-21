Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 12:42:58 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:7183 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20024989AbXIULmt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 12:42:49 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1IYguG-0007Jd-00; Fri, 21 Sep 2007 12:42:48 +0100
Received: from stanmore.mips.com ([192.168.192.169])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1IYguD-00037z-00; Fri, 21 Sep 2007 12:42:45 +0100
Message-ID: <46F3AE34.1090405@mips.com>
Date:	Fri, 21 Sep 2007 12:42:44 +0100
From:	Elizabeth Oldham <beth@mips.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	KokHow.Teh@infineon.com
CC:	linux-mips@linux-mips.org,
	Friedrich-Nachtmann.External@infineon.com, kurt@mips.com
Subject: Re: YAMON booting Linux kernels from malta board harddisk....
References: <31E09F73562D7A4D82119D7F6C1729860254C469@sinse303.ap.infineon.com> <46F390C5.402@mips.com> <31E09F73562D7A4D82119D7F6C1729860254C65D@sinse303.ap.infineon.com> <46F39A1D.8090101@mips.com> <31E09F73562D7A4D82119D7F6C1729860254C6D6@sinse303.ap.infineon.com> <46F3A432.4060903@mips.com> <31E09F73562D7A4D82119D7F6C1729860254C742@sinse303.ap.infineon.com>
In-Reply-To: <31E09F73562D7A4D82119D7F6C1729860254C742@sinse303.ap.infineon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: beth@mips.com
Return-Path: <beth@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: beth@mips.com
Precedence: bulk
X-list: linux-mips

KokHow.Teh@infineon.com wrote:
Hi KH,

> 	My question was which partition to put the md.conf? Does it go
> with the mb.bin or it can be put at any other partition?

It does not have to go with the binary image. "mb.conf" needs to go in 
/dev/hda2 and 3 as I described unless you change the source - its hardcoded.

Shall we take this off list?
Beth
