Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 14:48:51 +0000 (GMT)
Received: from mx1.wp.pl ([212.77.101.5]:23989 "EHLO mx1.wp.pl")
	by ftp.linux-mips.org with ESMTP id S20038953AbXBAOsq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Feb 2007 14:48:46 +0000
Received: (wp-smtpd smtp.wp.pl 20587 invoked from network); 1 Feb 2007 15:47:42 +0100
Received: from apn-239-74.gprsbal.plusgsm.pl (HELO [87.251.239.74]) (laurentp@[87.251.239.74])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-mips@linux-mips.org>; 1 Feb 2007 15:47:42 +0100
Message-ID: <45C1FE3D.8080304@wp.pl>
Date:	Thu, 01 Feb 2007 15:50:37 +0100
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Advice needed.
References: <45C0C956.2050009@wp.pl>    <20916.201.240.249.124.1170279547.squirrel@www.amilda.org>    <200701312302.05473.florian.fainelli@int-evry.fr>    <45C11812.9050808@wp.pl> <10879.201.240.249.124.1170335347.squirrel@www.amilda.org>
In-Reply-To: <10879.201.240.249.124.1170335347.squirrel@www.amilda.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000                                      
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

<cut>

>dd would certainly work. I would suggest you to check the way AMiLDA
>generates the firmware image. It's a lot more practical than a dd :D
>  
>
Thanks, i'll look at this (just finished downloading source). But my
question was NOT concerning GENERATING image (that part
of toolchain works, so let it be), but FLasing it. Normally done by webs
app. And as i see in Amilda, it uses the same scheme -> webs-buried C
function. And I would have an alternative, because of: first -> have no
source for webs-buried functions supplied by Edimax, so I have only
choice of using built binary no chance to simply add some functionality,
second -> webs is quite heavyweight, approx 450kb -> it is a lot on
system with 2M Flash expanded to 5M Ramdisk.

BTW maybe someone reading this knows what Edimax devices have 4M flash?

W.P.
