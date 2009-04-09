Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 23:56:43 +0100 (BST)
Received: from gateway03.websitewelcome.com ([74.52.223.144]:26794 "HELO
	gateway03.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S28577335AbZDIWyy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Apr 2009 23:54:54 +0100
Received: (qmail 27988 invoked from network); 9 Apr 2009 22:56:18 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway03.websitewelcome.com with SMTP; 9 Apr 2009 22:56:18 -0000
Received: from [217.109.65.213] (port=1526 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1Ls38z-00023G-Lt; Thu, 09 Apr 2009 17:54:50 -0500
Message-ID: <49DE7CC0.3010907@paralogos.com>
Date:	Fri, 10 Apr 2009 00:54:56 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	David Wuertele <dave+gmane@wuertele.com>
CC:	linux-mips@linux-mips.org
Subject: Re: What is the right way to setup MIPS timer irq in 2.6.29?
References: <loom.20090408T165537-312@post.gmane.org> <loom.20090409T195344-317@post.gmane.org>
In-Reply-To: <loom.20090409T195344-317@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

David Wuertele wrote:
> I think I might not need the CEVT components... I'm going to look into that
> next.  But I wish there was some easy to find documentation about why this
> code had to be moved into the arch/mips/cevt-*.c and arch/mips/csrc-*.c
> libraries.
>   
The "architecture independent" common event timer infrastructure has the
defects of being very poorly documented and (in my opinion) messier than
it needs to be.  But it has the virtue of making it straightforward to
get tickless operation via CONFIG_NO_HZ, which improves both throughput
and power consumption on most MIPS platforms.  If you've got it working
on your platform, keep it!

          Regards,

          Kevin K.
