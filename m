Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2005 07:39:47 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.199]:33739 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8226671AbVGMGjb> convert rfc822-to-8bit;
	Wed, 13 Jul 2005 07:39:31 +0100
Received: by zproxy.gmail.com with SMTP id n29so67339nzf
        for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 23:40:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q31+cmtjkL/nbvRq2iu/Iqz6FoHT+Od9UABSjBbE+JSvvJG2hy9hrOFH1lwVtO6JohOvW3tzk0T5PkP1jtvht+Fh0SgNM//EJaj8IWklO8Z52k86493wN9GICqJxAP0wxJWIHePBsq4E/E52BRLOwRK723G1Quu9q2tLdmsBhvs=
Received: by 10.36.222.26 with SMTP id u26mr634305nzg;
        Tue, 12 Jul 2005 23:40:31 -0700 (PDT)
Received: by 10.36.57.12 with HTTP; Tue, 12 Jul 2005 23:40:31 -0700 (PDT)
Message-ID: <4955666b05071223405849abf6@mail.gmail.com>
Date:	Wed, 13 Jul 2005 15:40:31 +0900
From:	Yoichi Yuasa <yyuasa@gmail.com>
Reply-To: Yoichi Yuasa <yyuasa@gmail.com>
To:	IHOLLO <ihollo@tom.com>
Subject: Re: ADM5120: linux-2.4.31-adm.diff.bz2 does not support PCI bus?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <42D47A74.9070709@tom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <42D47A74.9070709@tom.com>
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yyuasa@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

2005/7/13, IHOLLO <ihollo@tom.com>:
> Hi,
> 
> I am now working on a board with ADM5120 processor and want a kernel
> newer than 2.4.18, so I tried the linux-2.4.31-adm.diff.bz2 patch
> against vanilla 2.4.31 (http://www.linux-mips.org/wiki/ADMtek#Linux_2.4)
> but failed to compile it with PCI Bus support (It compiles OK without
> CONFIG_PCI). The compile error looks like this:

Did you turn on New PCI bus code(CONFIG_PCI_NEW)?

Yoichi
