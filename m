Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5IIBmT17331
	for linux-mips-outgoing; Mon, 18 Jun 2001 11:11:48 -0700
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5IIBkV17327
	for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 11:11:47 -0700
Received: from murphy.dk (brian.localnet [10.0.0.2])
        by ubik.localnet (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f5IIBbq6012730
        for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 20:11:39 +0200
Message-ID: <3B2E4458.1637A08A@murphy.dk>
Date: Mon, 18 Jun 2001 20:11:36 +0200
From: Brian Murphy <brian@murphy.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Problems with mips2 compiled libc and linux 2.4.3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


It seems that this check(in asm-mips/elf.h):

#define elf_check_arch(hdr)
\
({
\
        int __res = 1;
\
        struct elfhdr *__h = (hdr);
\

\
        if ((__h->e_machine != EM_MIPS) &&
\
            (__h->e_machine != EM_MIPS_RS4_BE))
\
                __res = 0;
\
        if (__h->e_flags & EF_MIPS_ARCH)
\
                __res = 0;
\

\
        __res;
\
})

which is called in fs/binfmt_elf.c causes the loading of init to fail if

it is linked with a glibc compiled with -mips2. It is the second if test

which fails if any of the high 4 bits in the flags are set. According to
the
specs these are set for the various mipsx (x != 1) flavors - this seems
to mean
that we do no allow anything higher than mips1 run on linux - can this
be
true? If so, why?

/Brian
