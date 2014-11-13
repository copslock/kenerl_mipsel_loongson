Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 01:17:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47150 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013576AbaKMARVgsaMS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 01:17:21 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAD0GKxj008094;
        Thu, 13 Nov 2014 01:16:20 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAD0GJvO008093;
        Thu, 13 Nov 2014 01:16:19 +0100
Date:   Thu, 13 Nov 2014 01:16:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] binfmt_elf: allow arch code to examine PT_LOPROC
 ... PT_HIPROC headers
Message-ID: <20141113001618.GC3839@linux-mips.org>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
 <1410420623-11691-4-git-send-email-paul.burton@imgtec.com>
 <20141112134059.GA12619@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141112134059.GA12619@ulmo>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, Nov 12, 2014 at 02:41:04PM +0100, Thierry Reding wrote:

> Hi Ralf,
> 
> This commit showed up in linux-next and causes a warning in linux/elf.h
> because it doesn't know struct file. I've fixed it locally with this:
> 
> ---
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index 6bd15043a585..dac5caaa3509 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -4,6 +4,8 @@
>  #include <asm/elf.h>
>  #include <uapi/linux/elf.h>
>  
> +struct file;
> +
>  #ifndef elf_read_implies_exec
>    /* Executables for which elf_read_implies_exec() returns TRUE will
>       have the READ_IMPLIES_EXEC personality flag set automatically.
> ---
> 
> Would you mind squashing that into the above commit to get rid of the
> warning?

To fix the warnings reported by sfr on powerpc64 this morning I moved
most of the code added to <linux/elf.h> into fs/binfmt_elf.c.  That
should also have taken care of the warnings you saw for ARM.

  Ralf
