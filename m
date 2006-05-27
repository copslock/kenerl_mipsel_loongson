Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 May 2006 19:06:23 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:60370 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133765AbWE0RGO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 May 2006 19:06:14 +0200
Received: (qmail 14979 invoked from network); 27 May 2006 21:14:17 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 27 May 2006 21:14:17 -0000
Message-ID: <447886CF.7040701@ru.mvista.com>
Date:	Sat, 27 May 2006 21:05:19 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Jordan Crouse <jordan.crouse@amd.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Fix non-linear memory mapping on MIPS
References: <44772379.30903@ru.mvista.com>
In-Reply-To: <44772379.30903@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Sergei Shtylyov wrote:

>    Fix the non-linear memory mapping done via remap_file_pages() -- it 
> didn't work on any MIPS CPU because the page offset was clashing with 
> _PAGE_FILE and some other page protection bits which should have been 
> left zeros for this kind of pages.

    Actally, _PAGE_ACCESSED which as we initially thought needed preserving, 
should be usable as well, so I'll repost the patch that implements 28-bit page 
offsets for R3k and MIPS32 shortly...

>    The patch has been tested on MIPS32, MIPS64, and Alchemy CPUs, only 
> R3000/TX3927 part hasn't been tested for the lack of time...

WBR, Sergei
