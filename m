Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 12:15:37 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48725 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491205Ab0JRKPe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Oct 2010 12:15:34 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9IAFW5W032384;
        Mon, 18 Oct 2010 11:15:32 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9IAFVUt032382;
        Mon, 18 Oct 2010 11:15:31 +0100
Date:   Mon, 18 Oct 2010 11:15:31 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix build failure on asm/fcntl.h
Message-ID: <20101018101531.GD27377@linux-mips.org>
References: <1287333699-1254-1-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1287333699-1254-1-git-send-email-namhyung@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 18, 2010 at 01:41:39AM +0900, Namhyung Kim wrote:

>   CC      security/integrity/ima/ima_fs.o
> In file included from linux/include/linux/fcntl.h:4:0,
>                  from linux/security/integrity/ima/ima_fs.c:18:
> linux/arch/mips/include/asm/fcntl.h:63:2: error: expected specifier-qualifier-list before 'off_t'
> make[3]: *** [security/integrity/ima/ima_fs.o] Error 1
> make[2]: *** [security/integrity/ima/ima_fs.o] Error 2
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>

Thanks, applied.

  Ralf
