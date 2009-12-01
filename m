Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 16:58:39 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38038 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492779AbZLAP6g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 16:58:36 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB1Fwlbd005937;
        Tue, 1 Dec 2009 15:58:47 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB1FwkdH005936;
        Tue, 1 Dec 2009 15:58:46 GMT
Date:   Tue, 1 Dec 2009 15:58:46 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: Re: [PATCH 2/2] Loongson: disable FLATMEM
Message-ID: <20091201155846.GC23697@linux-mips.org>
References: <1259650542-31922-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259650542-31922-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 02:55:42PM +0800, Wu Zhangjin wrote:

> With FLATMEM, The STD(Hibernation) for Loongson will fail, and there are
> also some other problems(break the files) when using NFS or CIFS(samba).
> 
> And as the config help of SPARSEMEM says:
> 
> "This option provides some potential performance benefits, along with
> decreased code complexity."
> 
> So, to avoid the potential problems of FLATMEM, we disable FLATMEM
> directly and use SPARSEMEM instead.
> 
> Relative Email thread:
> 
> http://groups.google.com/group/loongson-dev/browse_thread/thread/b6b65890ec2b0f24/feb43e5aa7f55d9b?show_docid=feb43e5aa7f55d9b
> 
> Reported-by: Tatu Kilappa <tatu.kilappa@gmail.com>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Applied - though I'm not so sure if I can get this one to Linus as
close to a release as we are now.

Thanks!

  Ralf
