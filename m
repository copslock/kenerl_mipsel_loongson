Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2007 17:23:24 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:14275 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20038769AbXAaRXT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Jan 2007 17:23:19 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id C6162298571;
	Wed, 31 Jan 2007 12:22:41 -0500 (EST)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 31 Jan 2007 12:22:41 -0500 (EST)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 31 Jan 2007 09:22:40 -0800
Message-ID: <45C0D060.1070903@avtrex.com>
Date:	Wed, 31 Jan 2007 09:22:40 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To:	"W.P." <laurentp@wp.pl>
Cc:	linux-mips@linux-mips.org
Subject: Re: Advice needed.
References: <45C0C956.2050009@wp.pl>
In-Reply-To: <45C0C956.2050009@wp.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2007 17:22:40.0386 (UTC) FILETIME=[68F9D620:01C7455C]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

W.P. wrote:
> Hello,
> currently i am "fighting" with Edimax BR-6024Wg, (Realtek-8186 based,
> lexra-mips). I need an advice from a system developer/programmer:
> 
> 1). When using original firmware (EDIMAX-developed Linux-mips), task of
> upgrading firmware is done by web server binary: webs, which is GoAhead
> 2.1.1, BUT Edimax didn't published "applets" -> C functions, that
> implement real functionality.
> 
> 2). In /dev directory there is a block node with mtd name. I have cat'ed
> it's contents to /web, and downloaded to PC. File seems to be raw
> contents of Flash memory: 2048*1024bytes long. If I drop first 64kB and
> truncate file to same length that Edimax-supplied firmware, files show
> to be the same (using cmp). The first 64kB looks to contain among
> others, variables used in BR system. There is originally an utility
> "flash" to get/set variables.
> 
> Now the question:
> When I will have a new firmware (image) will it be safe(!?) to do such
> thing: (instead of using webs binary):
> cat /dev/mtd > some.file
> dd first 64k of some.file to other.file,
> then download image (from PC) to a third.file
> cat other.file third.file > /dev/mtd back.??????

Using cat or dd to write to /dev/mtd? probably will not work.  If there 
is a /dev/mtdblock? perhaps.  Otherwise use the mtd utilities (flashcp 
or nandwrite depending on the type of flash memory) to write to /dev/mtd?.

Take a look at this site for more information:

http://www.linux-mtd.infradead.org/

David Daney
