Received:  by oss.sgi.com id <S42206AbQJLCPC>;
	Wed, 11 Oct 2000 19:15:02 -0700
Received: from u-252.karlsruhe.ipdial.viaginterkom.de ([62.180.18.252]:26119
        "EHLO u-252.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42180AbQJLCOg>; Wed, 11 Oct 2000 19:14:36 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870102AbQJLCNk>;
        Thu, 12 Oct 2000 04:13:40 +0200
Date:   Thu, 12 Oct 2000 04:13:40 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Macro error in 2.4.0-test9 (unaligned.h)
Message-ID: <20001012041339.A28300@bacchus.dhis.org>
References: <39E49824.92128925@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39E49824.92128925@ti.com>; from jharrell@ti.com on Wed, Oct 11, 2000 at 10:41:08AM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 11, 2000 at 10:41:08AM -0600, Jeff Harrell wrote:

> ~~~~~~~~~~~~8< snippet from  /include/asm-mips/unaligned.h --------
> 
> #define put_unaligned(x,ptr)      \                   <<== shouldn't  x
> actually be val here?
>     do {         \
>          switch (sizeof(*(ptr))) {     \
>              case 1:        \
>               *(unsigned char *)ptr = (val);    \
>                break;       \
>              case 2:        \

Fixed six days ago ...

  Ralf
