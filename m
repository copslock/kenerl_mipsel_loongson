Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6AGegk30794
	for linux-mips-outgoing; Tue, 10 Jul 2001 09:40:42 -0700
Received: from pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6AGeeV30790
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 09:40:41 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GG9002D6NNLJM@mta7.pltn13.pbi.net> for linux-mips@oss.sgi.com;
 Tue, 10 Jul 2001 09:40:34 -0700 (PDT)
Date: Tue, 10 Jul 2001 09:39:02 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: MIPS Cross Compiler Tools
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Reply-to: ppopov@pacbell.net
Message-id: <3B4B2FA6.4080508@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
References: <25369470B6F0D41194820002B328BDD27D22@ATLOPS>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Marc Karasek wrote:

> I had a question about the cross compiler tools for MIPS, specifically
> glibc.  I d/l the rpms from oss.sgi.com,  but they are only binutils, and
> the compiler (C, C++).  
> 
> Are most people building glibc against these or are you building the tools
> completely from scratch?  As glibc is needed to compile anything else other
> than the kernel. 

Friday or Monday MontaVista should have the HHL2.0 Journeyman mips 
release on the ftp site which will include the userland apps, cross AND 
native tools, etc.  The tools and glibc are very up to date. I would 
suggest checking Monday for the release and using that instead of 
building your own.

Pete
