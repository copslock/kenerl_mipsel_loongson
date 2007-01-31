Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2007 22:26:47 +0000 (GMT)
Received: from mx1.wp.pl ([212.77.101.5]:1379 "EHLO mx1.wp.pl")
	by ftp.linux-mips.org with ESMTP id S20038807AbXAaW0l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2007 22:26:41 +0000
Received: (wp-smtpd smtp.wp.pl 2774 invoked from network); 31 Jan 2007 23:25:38 +0100
Received: from apn-236-153.gprsbal.plusgsm.pl (HELO [87.251.236.153]) (laurentp@[87.251.236.153])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with RC4-MD5 encrypted SMTP
          for <linux-mips@linux-mips.org>; 31 Jan 2007 23:25:38 +0100
Message-ID: <45C11812.9050808@wp.pl>
Date:	Wed, 31 Jan 2007 23:28:34 +0100
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Advice needed.
References: <45C0C956.2050009@wp.pl> <20916.201.240.249.124.1170279547.squirrel@www.amilda.org> <200701312302.05473.florian.fainelli@int-evry.fr>
In-Reply-To: <200701312302.05473.florian.fainelli@int-evry.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000                                      
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

<cut>

>The board he is talking about is based on a rtl8186 which has few things in 
>common with admtek 5120?
>  
>
As i realize, it is a MIPS too, and he's talking about utilities, not
the kernel. (I'll download sources tomorrow, i have only GPRS internet
connection, so i will take several hours, and the i'll examine it). At
least some idea ;)

<cut>

>I think you had better using dd rather than cat, because /dev/mtdblock are 
>block devices, and should be treated like that. If your image has a valid 
>format, i.e : the bootloader accepts it, unless you made important 
>modifications to the system code, it should at least be booting.
>  
>

Using dd also suggests padding resulting file to 2048*1024 bytes, am i
right? And using block size of 64k?
As of image, i remarked, that file resulting from reading /dev/mtd look
like: boot&variables(64k) + original image I have uploaded using Edimax
program(approx 1.9M) + zeros to the end of 2M boundary.

So you think it may work? (dd ?) Image generation and upload using
Edimax-supplied tools works.

W.P.
