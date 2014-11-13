Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 18:29:36 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55429 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013422AbaKMR3fHSb5u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 18:29:35 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sADHTWAu025754;
        Thu, 13 Nov 2014 18:29:32 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sADHTTWL025753;
        Thu, 13 Nov 2014 18:29:29 +0100
Date:   Thu, 13 Nov 2014 18:29:29 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] binfmt_elf: load interpreter program headers
 earlier
Message-ID: <20141113172929.GA24983@linux-mips.org>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
 <1410420623-11691-3-git-send-email-paul.burton@imgtec.com>
 <20141113122011.GE23422@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141113122011.GE23422@ulmo>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44141
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

On Thu, Nov 13, 2014 at 01:20:20PM +0100, Thierry Reding wrote:

> kmemleak started complaining for me recently and the stacktrace (see
> below) points to this function:
> 
> 	unreferenced object 0xec0f77c0 (size 192):
> 	  comm "kworker/u8:0", pid 169, jiffies 4294939367 (age 86.360s)
> 	  hex dump (first 32 bytes):
> 	    01 00 00 70 1c ef 01 00 1c ef 01 00 1c ef 01 00  ...p............
> 	    a0 00 00 00 a0 00 00 00 04 00 00 00 04 00 00 00  ................
> 	  backtrace:
> 	    [<c00ec080>] __kmalloc+0x104/0x190
> 	    [<c01387d4>] load_elf_phdrs+0x60/0x8c
> 	    [<c0138cb4>] load_elf_binary+0x280/0x12d8
> 	    [<c00f8ef0>] search_binary_handler+0x80/0x1f0
> 	    [<c00fa370>] do_execveat_common+0x570/0x658
> 	    [<c00fa480>] do_execve+0x28/0x30
> 	    [<c0038eb4>] ____call_usermodehelper+0x144/0x19c
> 	    [<c000e638>] ret_from_fork+0x14/0x3c
> 	    [<ffffffff>] 0xffffffff
[...]
> I think what happens is that the interp_elf_phdata memory is freed only
> in the error cleanup path, but not when the function actually succeeds.
> 
> The attached patch plugs the leak for me.
> 
> Thierry

> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index f95da60e440e..8a9be83e88c2 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1029,6 +1029,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		}
>  	}
>  
> +	kfree(interp_elf_phdata);
>  	kfree(elf_phdata);
>  
>  	set_binfmt(&elf_format);

Folded in and testing now.

  Ralf
