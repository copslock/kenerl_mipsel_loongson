Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2010 18:08:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54119 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493128Ab0ASRIN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jan 2010 18:08:13 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0JD5LEw022454;
        Tue, 19 Jan 2010 14:05:24 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0JD5ISd022450;
        Tue, 19 Jan 2010 14:05:18 +0100
Date:   Tue, 19 Jan 2010 14:05:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v1] MIPS: Add support of LZO-compressed kernels
Message-ID: <20100119130517.GA22438@linux-mips.org>
References: <2efc4ca08c90ad087a2e84cadee03eb09b5268ba.1263558635.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2efc4ca08c90ad087a2e84cadee03eb09b5268ba.1263558635.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12623

On Fri, Jan 15, 2010 at 08:34:46PM +0800, Wu Zhangjin wrote:

> (Changes from v0: 'align "lzo" with the rest of the suffixes/tool names' as
>  Sergei suggested.)
> 
> The commit "lib: add support for LZO-compressed kernels" has been merged
> into linus' 2.6.33-rc4 tree, so, It is time to add the support for MIPS.
> 
> NOTE: to enable this support, the lzop application is needed.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks, applied.

  Ralf
