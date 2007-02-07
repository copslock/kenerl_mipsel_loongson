Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2007 18:05:11 +0000 (GMT)
Received: from mx5.wp.pl ([212.77.101.9]:15005 "EHLO mx1.wp.pl")
	by ftp.linux-mips.org with ESMTP id S20039501AbXBGSFG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Feb 2007 18:05:06 +0000
Received: (wp-smtpd smtp.wp.pl 16732 invoked from network); 7 Feb 2007 19:03:59 +0100
Received: from apn-239-193.gprsbal.plusgsm.pl (HELO [87.251.239.193]) (laurentp@[87.251.239.193])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-mips@linux-mips.org>; 7 Feb 2007 19:03:59 +0100
Message-ID: <45CA1552.3080100@wp.pl>
Date:	Wed, 07 Feb 2007 19:07:14 +0100
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Advice needed.
References: <45C0C956.2050009@wp.pl>             <20916.201.240.249.124.1170279547.squirrel@www.amilda.org>             <200701312302.05473.florian.fainelli@int-evry.fr>             <45C11812.9050808@wp.pl>          <10879.201.240.249.124.1170335347.squirrel@www.amilda.org>          <45C1FE3D.8080304@wp.pl>       <16445.201.240.249.124.1170423826.squirrel@www.amilda.org>       <45C3BB23.2070309@wp.pl>    <50812.201.230.45.190.1170482268.squirrel@www.amilda.org>    <45C45DDA.1000805@wp.pl> <24895.201.240.249.124.1170686083.squirrel@www.amilda.org>
In-Reply-To: <24895.201.240.249.124.1170686083.squirrel@www.amilda.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000                                      
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

<cut>

>The configuration structure is difficult to understand (even if you have
>the C header containing the struct)
>  
>
I don't have any header files for flash. Do you? In tarballs for BR,
there is no source for utilities like flash.
I'm trying to "decode" this structure, variable-by-variable. I have used
your flash utility source

>Just use the "flash" program.
>  
>
The one, that comes with original firmware? But what about webs, as i
looked into, this needs too some knowledge of flash datastructures.?


About webs -> will try to add some printf for debugging, and see.

BTW, maybe the JP3 connector (just 12 little holes) is the JTAG. Will
upload photo i think tomorrow. I have checked this with ohmometer and
pin-map of 8186, and it seems to be JTAG + RESET+ something(?). You have
published schema of JTAG cable, but what software shall anyone use?

W.Piotrzkowski.
