Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Dec 2009 23:26:31 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56013 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1495504AbZLSW02 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Dec 2009 23:26:28 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBJMQKvw024272;
        Sat, 19 Dec 2009 22:26:20 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBJMQKWi024270;
        Sat, 19 Dec 2009 22:26:20 GMT
Date:   Sat, 19 Dec 2009 22:26:20 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Cleanup and Fixup of compressed kernel support
Message-ID: <20091219222620.GB23763@linux-mips.org>
References: <1260456913-7822-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1260456913-7822-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 10, 2009 at 10:55:13PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Changes:
> 
>     o Remove the .initrd section
>     the initrd section is put in vmlinux, not need to handle it here.
> 
>     o Move .MIPS.options, .options, .pdr, .reginfo, .comment, .note from
>     Makefile to the /DSICARD/ of ld.script
>     If not move the .MIPS.options, the kernel compiled with gcc
>     3.4.6 will not boot.
> 
>     o Clean up the file format.
>     o Remove several other un-needed sections.
> 
> Have tested this patch with gcc 3.4.6 and gcc 4.4.1, and also with,
> without the initrd file system. All of them works well.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Applied - but:

/home/ralf/src/linux/linux-mips/.git/rebase-apply/patch:173: space before tab in indent.
  	.sdata	: { *(.sdata) }
/home/ralf/src/linux/linux-mips/.git/rebase-apply/patch:174: space before tab in indent.
  	. = ALIGN(4);

  Ralf
