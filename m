Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2009 16:26:18 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4599 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022640AbZEDP0L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2009 16:26:11 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ff09080000>; Mon, 04 May 2009 11:26:00 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 May 2009 08:26:02 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 May 2009 08:26:02 -0700
Message-ID: <49FF090A.3030505@caviumnetworks.com>
Date:	Mon, 04 May 2009 08:26:02 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	Sam Ravnborg <sam@ravnborg.org>, Anders Kaseorg <andersk@mit.edu>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Lots of unexpected non-allocatable section warnings
References: <20090503110517.6d09bca2@hyperion.delvare> <20090503103010.GA27978@uranus.ravnborg.org> <20090503124848.276b437f@hyperion.delvare> <20090503180332.GA31820@uranus.ravnborg.org> <20090503202939.GA1237@uranus.ravnborg.org> <20090504082816.GA25378@roarinelk.homelinux.net>
In-Reply-To: <20090504082816.GA25378@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 May 2009 15:26:02.0781 (UTC) FILETIME=[A2760CD0:01C9CCCC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> Hi Sam,
> 
> On Sun, May 03, 2009 at 10:29:39PM +0200, Sam Ravnborg wrote:
>> This is due to the SUSE specific section as you expected.
>> We ignore sections named ".comment" but not ".comment" sections
>> with something appended to the name.
> 
> 
> On a related note, I see tons of the following warnings cross-building for
> MIPS:
> 
> WARNING: init/mounts.o (.mdebug.abi32): unexpected non-allocatable section.
> Did you forget to use "ax"/"aw" in a .S file?                              
> Note that for example <linux/init.h> contains                              
> section definitions for use in .S files.                                   
> 
> WARNING: init/mounts.o (.pdr): unexpected non-allocatable section.
> Did you forget to use "ax"/"aw" in a .S file?                     
> Note that for example <linux/init.h> contains                     
> section definitions for use in .S files. 
> 
> 
> I added ".pdr" and ".mdebug*" to the whitelist;  the resulting kernels still
> work.  (gcc-4.3.3, binutils-2.19.1)
> 

I too think they are needed.  Are you going to prepare a patch?

David Daney
