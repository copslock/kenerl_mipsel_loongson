Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 15:54:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33234 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493335Ab0AZOym (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2010 15:54:42 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0QEsnkI010414;
        Tue, 26 Jan 2010 15:54:50 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0QEsnjc010412;
        Tue, 26 Jan 2010 15:54:49 +0100
Date:   Tue, 26 Jan 2010 15:54:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [RFC PATCH] MIPS: Alchemy: debug output for compressed kernels
Message-ID: <20100126145448.GD17849@linux-mips.org>
References: <1263404818-23038-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1263404818-23038-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16737

On Wed, Jan 13, 2010 at 06:46:58PM +0100, Manuel Lauss wrote:

> Hook up the compressed debug output for all Alchemy systems supported
> by current kernel codebase.
> 
> Cc: Wu Zhangjin <wuzhangjin@gmail.com>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> The code is built for all alchemy systems since I doubt anyone would
> solder on an extra UART chip instead of using the built-in ones.

Hardware folks tend have interesting ideas to say the least :)  But until
then I'm happy to queue this patch for 2.6.34.

Thanks,

  Ralf
