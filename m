Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2007 16:33:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:38133 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025062AbXIEPdS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2007 16:33:18 +0100
Received: from localhost (p2126-ipad305funabasi.chiba.ocn.ne.jp [123.217.164.126])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F2403E5A8; Thu,  6 Sep 2007 00:31:53 +0900 (JST)
Date:	Thu, 06 Sep 2007 00:33:20 +0900 (JST)
Message-Id: <20070906.003320.25909195.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46DD53BE.2070004@gmail.com>
References: <46DC29F0.3060200@gmail.com>
	<20070904.005400.52128244.anemo@mba.ocn.ne.jp>
	<46DD53BE.2070004@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 04 Sep 2007 14:46:54 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> One thing you might want to try is:
> 
> 	$ echo 0 > /proc/sys/kernel/randomize_va_space
> 
> and see if your system still works fine. This command should avoid a
> data cache flush when moving the stack around. See shift_arg_pages().
> 
> With this, maybe you could give this testcase a try:
> 
> 	$ /bin/echo "`seq 10000`" > seq.txt
> 
> and see if seq.txt is correct. This command should pass to echo (not
> the bash builtin one) a long argument that should fill your
> dcache.

I tried this and everything worked fine with/without the
flush_kernel_dcache_page() ;)

> That said the execve syscall code is quite 'hairy' and it may not be
> suprising that after this syscall the dcache has been completly
> flushed and thus make the problem disappear.

Yes, there is an yet another path to "flush all dcache".

do_execve()
  copy_strings()
    flush_kernel_dcache_page()
  search_binary_handler()
    load_elf_binary()
      flush_old_exec()
        exec_mmap()
          mmput()
            exit_mmap()
              flush_cache_mm()
                r4k_blast_dcache()

Anyway, the implementation of flush_kernel_dcache_page() is very
simple so that we can believe it works correctly without any testcase.
Too optimistic? :)

---
Atsushi Nemoto
