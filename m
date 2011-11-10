Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 19:06:30 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52343 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903561Ab1KJSG0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 19:06:26 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAAI6OLL030291;
        Thu, 10 Nov 2011 18:06:24 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAAI6Osc030284;
        Thu, 10 Nov 2011 18:06:24 GMT
Date:   Thu, 10 Nov 2011 18:06:24 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH mips-next] MIPS: Alchemy: pci: fix build: missing module.h
Message-ID: <20111110180624.GA30108@linux-mips.org>
References: <1320865362-16718-1-git-send-email-manuel.lauss@googlemail.com>
 <20111109191006.GA13280@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111109191006.GA13280@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9588

On Wed, Nov 09, 2011 at 07:10:06PM +0000, Ralf Baechle wrote:

> Thanks, applied.

And reverted again - in the new world of modules it should have included
<linux/export.h>, see http://lwn.net/Articles/453517/ for some background.

  Ralf
