Received:  by oss.sgi.com id <S553908AbRBNNQn>;
	Wed, 14 Feb 2001 05:16:43 -0800
Received: from 108dsl063.dsl.micron.net ([206.207.108.63]:29286 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S553862AbRBNNQT>; Wed, 14 Feb 2001 05:16:19 -0800
Received: (qmail 6501 invoked from network); 14 Feb 2001 06:16:08 -0700
Received: from stevej-lx.ridgerun.cxm (HELO ridgerun.com) (stevej@192.168.1.4)
  by ridgerun-lx.ridgerun.cxm with SMTP; 14 Feb 2001 06:16:08 -0700
Message-ID: <3A8A8518.F66EBFA3@ridgerun.com>
Date:   Wed, 14 Feb 2001 06:16:08 -0700
From:   Steve Johnson <stevej@ridgerun.com>
Organization: Ridgerun, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-bigphys i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     ldavies@oz.agile.tv
CC:     linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Ooops in kmalloc from request_region
References: <3A8A02E6.9030408@agile.tv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Liam,

    You can't call kmalloc that early in the startup process.  Look at main.c,
and init_IRQ comes before any of the memory initialization.

    Steve

Liam Davies wrote:

> I am currently at the stage of calling request_region in my irq_setup
> function.
> The call to request_region does a kmalloc which oops. The box has 256Mb Ram.
>
> Is this the right stage to be doing this call? Is there something that I
> have missed
> in setting up the memory regions or paging?
>
