Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 15:05:45 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:11234 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024719AbXIDOFg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Sep 2007 15:05:36 +0100
Received: by nf-out-0910.google.com with SMTP id 30so1457639nfu
        for <linux-mips@linux-mips.org>; Tue, 04 Sep 2007 07:05:17 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VP8h0e8ImcaVgj6njER7nHFOKChhAbH5SbzgjCizlHI4vVpNCEwuISTKJI/OvERnzCPuwKpszfc7ZdU8LNSojb/DN2N0cM4MuuasYs+oxq8buAE9mJjhpqg+5XO6JhrmoVMs1xKQMpkUi/SCrMwIGRBmEmwC+dEJ9mFIdgYL+l4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WGDFp4vjzT/wJLwHgXbwoRxBLiGpZ7NMp5uTnQpII8vIq3ru3DPlppcd1MmEqI0i87sAoUKbDRiR+dB9PwdERPOhr/ZPHTcNTFZbGpqV9ayn6b0k6f85DM3XDVeyde23AQaGymvUOmfLY+cCujHEDL0n74awfs0MoiT/KwYI3vg=
Received: by 10.78.138.6 with SMTP id l6mr2643828hud.1188914717345;
        Tue, 04 Sep 2007 07:05:17 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id o36sm1790518hub.2007.09.04.07.05.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Sep 2007 07:05:16 -0700 (PDT)
Message-ID: <46DD6616.6030303@gmail.com>
Date:	Tue, 04 Sep 2007 16:05:10 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
References: <46DC29F0.3060200@gmail.com>	<20070904.005400.52128244.anemo@mba.ocn.ne.jp>	<46DD53BE.2070004@gmail.com> <20070904.225402.106261140.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070904.225402.106261140.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue, 04 Sep 2007 14:46:54 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> I'll look at it further, but any testcase are welcome.
> 
> I found the reason.
> 
> do_execve()
>   copy_strings()
>     flush_kernel_dcache_page()
>   search_binary_handler()
>     load_elf_binary()
>       setup_arg_pages()
>         shift_arg_pages()
>           move_page_tables()
>             flush_cache_range()
> 
> And MIPS flush_cache_range() blasts whole dcache!  That's why empty
> flush_kernel_dcache_page() was enough for now.  

Yeah, that what I think too and that's also why I was suggesting to
test a plain 2.6.23-rc5 with the randomize_va_space=0. Please see my
previous reply...

Could you give it a try ?

		Franck
