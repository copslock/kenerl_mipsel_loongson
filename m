Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2009 19:45:15 +0000 (GMT)
Received: from gate.ebshome.net ([208.106.21.240]:62166 "EHLO gate.ebshome.net")
	by ftp.linux-mips.org with ESMTP id S21366000AbZBQTpM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Feb 2009 19:45:12 +0000
Received: (qmail 25683 invoked by uid 1000); 17 Feb 2009 11:45:09 -0800
Date:	Tue, 17 Feb 2009 11:45:09 -0800
From:	Eugene Surovegin <ebs@ebshome.net>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	post@pfrst.de, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: cacheflush system call-MIPS
Message-ID: <20090217194509.GA16134@gate.ebshome.net>
References: <f5a7b3810902100716t2658ce95t2dcc7f85634522@mail.gmail.com> <20090211131649.GA1365@linux-mips.org> <Pine.LNX.4.58.0902140002180.408@Indigo2.Peter> <20090213235603.GA32274@linux-mips.org> <Pine.LNX.4.58.0902150312460.459@Indigo2.Peter> <499AEE98.1010908@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <499AEE98.1010908@caviumnetworks.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <ebs@ebshome.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebs@ebshome.net
Precedence: bulk
X-list: linux-mips

On Tue, Feb 17, 2009 at 09:06:32AM -0800, David Daney wrote:
> peter fuerst wrote:
>>> Why does it need that flush?
>> To prepare the update-area (in the Shadow-FB) for DMA to RE.
>
> And on systems where the root frame buffer is directly manipulated by the 
> CPU, the video system is continually using DMA to refresh the display.  A 
> cache flush can be required to eliminate transient visual glitches.

In this case using uncached fb access is the only way to avoid 
glitches - you cannot control cache line evictions. And it's usually 
faster to use uncached mappings for effectively write-only regions.

-- 
Eugene
