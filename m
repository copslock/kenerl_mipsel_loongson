Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 17:39:00 +0000 (GMT)
Received: from mx5.wp.pl ([212.77.101.9]:3730 "EHLO mx1.wp.pl")
	by ftp.linux-mips.org with ESMTP id S20038604AbXBHRiz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 17:38:55 +0000
Received: (wp-smtpd smtp.wp.pl 23002 invoked from network); 8 Feb 2007 18:37:50 +0100
Received: from apn-239-93.gprsbal.plusgsm.pl (HELO [87.251.239.93]) (laurentp@[87.251.239.93])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-mips@linux-mips.org>; 8 Feb 2007 18:37:50 +0100
Message-ID: <45CB60B9.2000204@wp.pl>
Date:	Thu, 08 Feb 2007 18:41:13 +0100
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Advice needed.
References: <45C0C956.2050009@wp.pl>                <20916.201.240.249.124.1170279547.squirrel@www.amilda.org>                <200701312302.05473.florian.fainelli@int-evry.fr>                <45C11812.9050808@wp.pl>             <10879.201.240.249.124.1170335347.squirrel@www.amilda.org>             <45C1FE3D.8080304@wp.pl>          <16445.201.240.249.124.1170423826.squirrel@www.amilda.org>          <45C3BB23.2070309@wp.pl>       <50812.201.230.45.190.1170482268.squirrel@www.amilda.org>       <45C45DDA.1000805@wp.pl>    <24895.201.240.249.124.1170686083.squirrel@www.amilda.org>    <45CA1552.3080100@wp.pl> <13985.201.240.249.124.1170947816.squirrel@www.amilda.org>
In-Reply-To: <13985.201.240.249.124.1170947816.squirrel@www.amilda.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000                                      
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

Użytkownik Sergio Aguayo napisał:

>><cut>
>>When Edimax was forced to release the sources, they released a different
>>source archive than the one currently available. That one contained some
>>more files than the current one does. I'll upload it today for you to
>>download it.
>>    
>>
OK, i'll wait for it. Please notify me.

<cut>

>webs and the flash program share some sources. Originally, flash's sources
>are contained in the LINUX directory of webs.
>
>  
>
This is why i am "disassembling" data structure. Looks like using a lot
of space -> 0x7FFA if the 2 bytes after signature are the length. If i
have found correctly, config data is 0x8000->0xFFFA in mdt, a bit
earlier are hardware parameters: 0x6000, and there is something (maybe
default config) at 0x6400.

>> About webs -> will try to add some printf for debugging, and see.

At this moment, have located, that problem is in flash parameters
loading (before socket binding etc), so i'll finish "dissasembling" and
return to webs.

<cut>

>That's a JTAG. But AFAIK no software can drive it yet (except maybe some
>commercial software?). See forum.amilda.org, forum MODs for some
>information that may be useful for you to experiment with jtag.
>  
>
Will look on the net, it's hard to believe, that no one developed JTAG
open source software.

W.Piotrzkowski.
