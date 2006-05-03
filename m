Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 May 2006 17:22:22 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:30377 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S7620187AbWECQWL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 May 2006 17:22:11 +0100
Received: (qmail 9540 invoked by uid 101); 3 May 2006 16:21:59 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 3 May 2006 16:21:59 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k43GLwpK003741;
	Wed, 3 May 2006 09:21:59 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF5WAYP>; Wed, 3 May 2006 09:21:58 -0700
Message-ID: <5C1FD43E5F1B824E83985A74F396286E01DD4E88@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Don Hiatt <Don_Hiatt@pmc-sierra.com>
To:	"'Ratin'" <mrahman@sypixx.com>
Cc:	linux-mips@linux-mips.org
Subject: RE: changing IP address on mipsel-linux
Date:	Wed, 3 May 2006 09:21:54 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Don_Hiatt@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Don_Hiatt@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Perhaps you mean you want to set the IP for a NFS mounted filesystem?

If so you can pass "ip=dhcp" or ip="192.168.13.120" as a kernel argument.

Cheers,

don

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Ratin
Sent: Wednesday, May 03, 2006 9:12 AM
To: Freddy Spierenburg
Cc: linux-mips@linux-mips.org
Subject: Re: changing IP address on mipsel-linux


Hi Freddy, Thanks for your response, I appreciate your help. I am kind of 
new to this version of Linux.
The uname -a gives me this:

Linux 192.168.0.62 2.6.10-idt20050328 #1 Tue Dec 13 10:36:55 PST 2005 mips 
unknown

 Ratin
