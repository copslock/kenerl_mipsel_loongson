Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 13:15:56 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50091 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903691Ab1KJMPw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 13:15:52 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAACFpTD009236;
        Thu, 10 Nov 2011 12:15:51 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAACFoKT009234;
        Thu, 10 Nov 2011 12:15:50 GMT
Date:   Thu, 10 Nov 2011 12:15:50 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH mips-next] MIPS: Alchemy: DB1200 audio support depends on
 MIPS arch
Message-ID: <20111110121550.GD21453@linux-mips.org>
References: <1320926163-27311-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320926163-27311-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9253

On Thu, Nov 10, 2011 at 12:56:03PM +0100, Manuel Lauss wrote:

> Fix the x86-allmodconfig build failure reported by Stephen Rothwell.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> Please fold into patch "[PATCH 05/18] MIPS: Alchemy: DB1300 support"; it applies
> in top of it.  The next patch in the series will then throw a reject in this
> file because of the change.

Done.

  Ralf
