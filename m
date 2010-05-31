Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 00:47:05 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45362 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491892Ab0EaWrC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Jun 2010 00:47:02 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4VMkx9F003483;
        Mon, 31 May 2010 23:46:59 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4VMkwCw003481;
        Mon, 31 May 2010 23:46:58 +0100
Date:   Mon, 31 May 2010 23:46:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH] mips: fix build with O=...
Message-ID: <20100531224658.GB2789@linux-mips.org>
References: <20100530141939.GA22153@merkur.ravnborg.org>
 <AANLkTilwqYZc9-vtHsdBg1JwIOiYEPBtuRG-Rqg6nxNC@mail.gmail.com>
 <20100531180321.GA27518@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100531180321.GA27518@merkur.ravnborg.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 26950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, May 31, 2010 at 08:03:21PM +0200, Sam Ravnborg wrote:

> >From b96ea542b6786a44ab1a70d53a2796bd0d60b521 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 31 May 2010 19:58:18 +0200
> Subject: [PATCH] mips: fix build with O=...
> 
> The newly added platform support introduced
> a regression so build with O=... failed.
> 
> Fix this by prefixing Makefile include paths with $(srctree).

Thanks, I've folded this patch into the original patch.

  Ralf
