Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 14:46:48 +0000 (GMT)
Received: from ex.2n.cz ([213.29.92.11]:29660 "EHLO ex.2n.cz")
	by ftp.linux-mips.org with ESMTP id S20048664AbXAXOqo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2007 14:46:44 +0000
Received: from orphique ([192.168.22.100]) by ex.2n.cz with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 24 Jan 2007 15:46:16 +0100
Received: from ladis by orphique with local (Exim 3.36 #1 (Debian))
	id 1H9jNu-0005Bl-00
	for <linux-mips@linux-mips.org>; Wed, 24 Jan 2007 15:45:58 +0100
Date:	Wed, 24 Jan 2007 15:45:58 +0100
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: how to choose journal filesystem for embedded linux?
Message-ID: <20070124144557.GA19790@orphique>
References: <50c9a2250701231805y62ec67f0v83d2fcf3ae2c55da@mail.gmail.com> <45B6E02D.1040206@gmail.com> <50c9a2250701232104k317049b3ve1890524cc2ddfea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250701232104k317049b3ve1890524cc2ddfea@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Ladislav Michl <ladis@linux-mips.org>
X-OriginalArrivalTime: 24 Jan 2007 14:46:16.0568 (UTC) FILETIME=[66E49780:01C73FC6]
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 24, 2007 at 01:04:03PM +0800, zhuzhenhua wrote:
> On 1/24/07, Maarten Lankhorst <m.b.lankhorst@gmail.com> wrote:
> >Have you tried jffs2? Journaled Flash FileSystem 2
> 
> the JFFS2 is combile filesytem with FLASH. but our FLASH driver team
> have developed a driver good enough to handle FLASH as HD, so we don't
> want to use the special FLASH filesystem

Could you provide a short explanation about advantages of such solution?

	ladis
