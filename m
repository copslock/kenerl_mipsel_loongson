Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8II9Vq03804
	for linux-mips-outgoing; Tue, 18 Sep 2001 11:09:31 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8II9Se03800
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 11:09:28 -0700
Message-Id: <200109181809.f8II9Se03800@oss.sgi.com>
Received: (qmail 1166 invoked from network); 18 Sep 2001 18:03:39 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 18 Sep 2001 18:03:39 -0000
Date: Wed, 19 Sep 2001 2:8:47 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Gerald Champagne <gerald.champagne@esstech.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Freeing global memory used only by __init functions
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8II9Se03801
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Gerald Champagne£¬
      I think __initdata attribute is the answer.You just need to 
put init data in init data section(via __initdata),there are many examples
in kernel.


ÔÚ 2001-09-18 12:58:00 you wrote£º
>I noticed that several global buffers are used by a few functions marked
>as __init functions.  I assume that the code space used by these functions
>will be freed up when kernel initialization is completed, but can the
>associated global memory be freed up as well?
>
>An example can be found in arch/mips/mips-boards/generic/cmdline.c:
>
>char arcs_cmdline[COMMAND_LINE_SIZE];
>char * __init prom_getcmdline(void);
>void  __init prom_init_cmdline(void);
>
>arcs_cmdline is only used by these two functions and one other function
>marked as __init.
>
>This buffer is small, but it can apply to larger buffers as well.  For
>example, in arch/mips/mips-boards/generic/printf.c, I think the functions
>putPromChar and getPromChar should be marked as __init functions, and the
>1k buffer "buf" is never used after initialization.  Can this 1k be recovered?
>
>I know kmalloc could normally be used in kernel code, but that won't work on
>initialization code used before kmalloc is initialized.
>
>Thanks.
>
>Gerald

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
