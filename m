Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2008 17:15:42 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:22414 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23352525AbYKGRPk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Nov 2008 17:15:40 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4914778f0001>; Fri, 07 Nov 2008 12:14:57 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 7 Nov 2008 09:14:54 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 7 Nov 2008 09:14:54 -0800
Message-ID: <4914778E.1040906@caviumnetworks.com>
Date:	Fri, 07 Nov 2008 09:14:54 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Christoph Hellwig <hch@lst.de>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 05/29] MIPS: Add Cavium OCTEON processor support files
 to arch/mips/cavium-octeon/executive and asm/octeon.
References: <491358F5.7040002@caviumnetworks.com> <1226004875-27654-5-git-send-email-ddaney@caviumnetworks.com> <20081107083712.GA7205@lst.de>
In-Reply-To: <20081107083712.GA7205@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2008 17:14:54.0711 (UTC) FILETIME=[5A43F870:01C940FC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:
> Still lacks an explanation what the mess in the executive directory
> actually does.

I will try to explain it.

First a little background:  The OCTEON processor has many CPU cores 
(current parts have up to 16, but more are possible).  It also has a 
variety of on-chip hardware blocks for things like network acceleration, 
encryption and RAID.

One typical configuration is to run Linux on several of the CPU cores, 
and other dedicated applications on the other cores.

Resource allocation between the various programs running on the system 
(Linux kernel and other dedicated applications) needs to be coordinated. 
  The code we use to do this we call the 'executive'.  We have gathered 
all of this code together and placed it in the executive directory.

Included in the patch set are the following files:

cvmx-bootmem.c and cvmx-sysinfo.c -- Coordinates memory allocation.  All 
memory used by the Linux kernel is obtained here at boot time.

cvmx-l2c.c -- Coordinates operations on the shared level 2 cache.

octeon-model.c  -- Probes chip capabilities and version.

Of these files, the only one that doesn't interact with other programs 
running on the system is octeon-model.c.

Now if we look at other Linux ports we should consider xen.  You will 
note that it occupies its own directory and coordinates access to shared 
resources.  The analogy is not perfect, but there is some precedent for 
grouping this type of code together in a single place.

> And as mentioned before I don't think any amount of
> explanation would actually be enough for it, so please kill the mess
> and write it as proper kernel code.
> 

We are certainly open to suggestions, but we feel that keeping this 
shared resource management code segregated will result in easier 
maintenance and thus a higher quality kernel in the future.

Any suggestions as to how the code could be made more 'proper' are 
welcome, but telling us to kill the whole lot doesn't help us much 
unless you can suggest something better.

In any event, thanks for taking the time to look at it,
David Daney
