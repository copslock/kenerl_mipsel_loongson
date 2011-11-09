Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 10:14:05 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39858 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903546Ab1KIJN7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 10:13:59 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA99Dv5Y012737;
        Wed, 9 Nov 2011 09:13:57 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA99Dt76012731;
        Wed, 9 Nov 2011 09:13:55 GMT
Date:   Wed, 9 Nov 2011 09:13:55 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Kernel hangs occasionally during boot.
Message-ID: <20111109091355.GB5513@linux-mips.org>
References: <y>
 <1320764341-4275-1-git-send-email-alcooperx@gmail.com>
 <20111108175532.GA15493@linux-mips.org>
 <4EBA2E65.3010009@niisi.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EBA2E65.3010009@niisi.msk.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7579

On Wed, Nov 09, 2011 at 11:40:21AM +0400, Gleb O. Raiko wrote:

> >Author: Al Cooper <alcooperx@gmail.com> Tue Nov 8 09:59:01 2011 -0500
> >Comitter: Ralf Baechle <ralf@linux-mips.org> Tue Nov 8 16:52:51 2011 +0000
> >Commit: 9121470d99c029493bd55daa11607b398fe9aea3
> >Gitweb: http://git.linux-mips.org/g/linux/9121470d
> Could you fix those links, it's broken after you moved git repo in?

Future emails will use URLs that look like

   http://git.linux-mips.org/g/ralf/linux/9121470d

with the full repository path sans the .git suffix.  There also is a
compat hack to keep the URLs from a few thousand old commit mails working.

Thanks for reporting!

  Ralf
