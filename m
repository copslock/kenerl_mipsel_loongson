Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 23:58:05 +0100 (BST)
Received: from mail.alphastar.de ([194.59.236.179]:7691 "EHLO
	mail.alphastar.de") by ftp.linux-mips.org with ESMTP
	id S8133728AbWC1W54 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Mar 2006 23:57:56 +0100
Received: from Snailmail (217.249.193.38)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Wed, 29 Mar 2006 01:04:54 +0200
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id k2SN6p6h001069
	for <linux-mips@linux-mips.org>; Wed, 29 Mar 2006 01:06:51 +0200
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.11-rc3-ip28) with ESMTP id k2SN6mkN000648
	for <linux-mips@linux-mips.org>; Wed, 29 Mar 2006 01:06:48 +0200
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id k2SN6maN000645
	for <linux-mips@linux-mips.org>; Wed, 29 Mar 2006 01:06:48 +0200
Date:	Wed, 29 Mar 2006 01:06:48 +0200 (CEST)
From:	peter fuerst <pf@net.alphadv.de>
To:	linux-mips@linux-mips.org
Subject: Re: compilation problem with kernel 2.6.15 
In-Reply-To: <20060328143708.57991.qmail@web53507.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0603290104010.634@Indigo2.Peter>
References: <20060328143708.57991.qmail@web53507.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



On Tue, 28 Mar 2006, Krishna wrote:

> Date: Tue, 28 Mar 2006 06:37:08 -0800 (PST)
> From: Krishna <dhunjukrishna@yahoo.com>
> Reply-To: dhunjukrishna@gmail.com
> To: linux-mips@linux-mips.org
> Subject: compilation problem with kernel 2.6.15
>
> I tried to cross compile kernel 2.6.15 for BCM1480. Please tell me what the following error indicates:
> ...

Hi !

You are trying to use gcc 4.2, aren't you ?

`fault_in_pages_readable' is defined as follows:

fault_in_pages_readable(const char __user *uaddr, int size)
{
    volatile char c;
    int ret;
    ret = __get_user(c, uaddr);
    ...
}

this invokes the __get_user_nocheck(c,uaddr,sizeof(*uaddr)) macro:

#define __get_user_nocheck(x,ptr,size)	\
({	\
    __typeof(*(ptr)) __gu_val =  (__typeof(*(ptr))) 0;	\
    ...	\
})

defining `__gu_val' of type `const char', which gcc 4.2 (don't know about 4.1)
no longer accepts as asm-output (lvalue).  At least until this macro will be
changed, you should switch back to gcc 4.0.

kind regards

pf
