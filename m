Received:  by oss.sgi.com id <S42518AbQJFIBE>;
	Fri, 6 Oct 2000 01:01:04 -0700
Received: from ns4.Sony.CO.JP ([202.238.80.4]:9747 "EHLO ns4.sony.co.jp")
	by oss.sgi.com with ESMTP id <S42517AbQJFIAq>;
	Fri, 6 Oct 2000 01:00:46 -0700
Received: from mail3.sony.co.jp (gatekeeper7.Sony.CO.JP [202.238.80.21])
	by ns4.sony.co.jp (R8) with ESMTP id RAA24753;
	Fri, 6 Oct 2000 17:00:43 +0900 (JST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8) with ESMTP id RAA25368;
	Fri, 6 Oct 2000 17:05:27 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail3.sony.co.jp (R8) with ESMTP id RAA25331;
	Fri, 6 Oct 2000 17:05:27 +0900 (JST)
Received: from email.sm.sony.co.jp (email.sm.sony.co.jp [43.11.253.2]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id QAA07399; Fri, 6 Oct 2000 16:59:04 +0900 (JST)
Received: from sm.sony.co.jp (kei@gaia.sm.sony.co.jp [43.11.132.48]) by email.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id QAA00127; Fri, 6 Oct 2000 16:55:03 +0900 (JST)
Message-Id: <200010060755.QAA00127@email.sm.sony.co.jp>
To:     Mike McDonald <mikemac@mikemac.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Linux-VR test7 hangs when execing init 
In-reply-to: Your message of Thu, 05 Oct 2000 20:40:17 -0700.
             <200010060340.UAA21853@saturn.mikemac.com> 
Date:   Fri, 06 Oct 2000 17:00:41 +0900
From:   Hiroshi Kawashima <kei@sm.sony.co.jp>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi.

>   Recently the Linux-VR tree synced up with the SGI tree at test7
> (from test4). As a result of this updating of the Linux-VR tree, my
> kernels either hang or Oops while execing init. A minimal kernel will
> hang and a normally config'd kernel will Oops. Does anyone know of any
> changes in the ELF code or the ext2 filesystem that might be the cause
> fo this? Any other ideas as to the cause or how to go about tracking
> it down?

It should be problem around PCMCIA is broken on test7.
Some are working for fixing this (on linuxce list), but not
completed yet.
----
Kawashima
