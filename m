Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 12:43:31 +0100 (BST)
Received: from p508B72ED.dip.t-dialin.net ([IPv6:::ffff:80.139.114.237]:30229
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225788AbUGHLn1>; Thu, 8 Jul 2004 12:43:27 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i68BhOuq032141;
	Thu, 8 Jul 2004 13:43:24 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i68BhNgJ032138;
	Thu, 8 Jul 2004 13:43:23 +0200
Date: Thu, 8 Jul 2004 13:43:23 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>
Cc: linux-mips@ftp.linux-mips.org
Subject: Re: LO reg. gets trashed by kgdb in 2.4.x and older kernels
Message-ID: <20040708114323.GB16587@linux-mips.org>
References: <40E96E2A.2000403@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E96E2A.2000403@dev.rtsoft.ru>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 5428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 05, 2004 at 07:05:14PM +0400, Sergei Shtylyov wrote:

>     I have discovered that the gdb-low.S trashes the LO reg. instead of 
> restoring it. This was fixed for the 2.6 kernels but, as it seems, was left 
> unfixed in the earlier ones (run into this on 2.4.18/2.4.20). Here's the 
> patch
> against the lastest 2.4.x revision of the file...

Thanks.  This also was an ancient bug probably dating back to late '94 or
early '95 so all branches other than 2.6 were affected.

  Ralf
