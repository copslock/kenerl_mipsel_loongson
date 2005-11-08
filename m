Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 11:00:40 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:20230 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8135810AbVKHLAX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Nov 2005 11:00:23 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA8B1Ym1006339;
	Tue, 8 Nov 2005 11:01:34 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA8B1YKc006338;
	Tue, 8 Nov 2005 11:01:34 GMT
Date:	Tue, 8 Nov 2005 11:01:34 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: git and tags...
Message-ID: <20051108110134.GA2689@linux-mips.org>
References: <cda58cb80511080249w7d902821n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80511080249w7d902821n@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 08, 2005 at 11:49:48AM +0100, Franck wrote:

> I'm trying to retrieve a linux kernel by tag using git. Let's say for
> example I want my working tree to be a linux 2.6.12 copy from git
> repository. How can I do that ?
> 
> I tried these commands but it seems that there's no tag in git repository
> 
> git clone rsync://ftp.linux-mips.org/git/linux.git linux.git
> git pull http://www.linux-mips.org/pub/scm/linux.git tag linux_2_6_12

ls .git/refs/tags to see the tag names.  

  Ralf
