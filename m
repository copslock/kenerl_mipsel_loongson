Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2009 14:13:58 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:41527 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021485AbZEXNNw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2009 14:13:52 +0100
Received: by pzk40 with SMTP id 40so2533056pzk.22
        for <multiple recipients>; Sun, 24 May 2009 06:13:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=XPd0RxWgIAiUYXJQRGL7Mkyfvvmie0n7UcmIz/s97J4=;
        b=bH7bHspwbkgyvoJDmyfeotXHWp4MAXjtAAUJr5s/h0IPxIPoPFw5m8URVQc24riafw
         keGdlgSqjigDZhPASOM7kRDaKNIDiWhJr8KbffXnCkmGu0ZJRM4HljyHWye9TvLV7nRn
         MRhdMJAKkvra5PvX48bfNy88uEnwl2HjYpY0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Kr1AIJQ7Ti+Hq/GN7giuK1boblaC/z8XQYPw0yEH6pteJZYehPdHpwUNR4lcdayr4a
         i7+26bPNkeoYzn8H8bVcw2aTFKBKLjLySgUR9YkMNU4tLgEFU6Inx5DZZExJqa02EwOS
         Nby7THjAqxA3OPobPR5YOXtz+0lbRYMvG0/Qw=
Received: by 10.114.211.1 with SMTP id j1mr12429119wag.176.1243170825465;
        Sun, 24 May 2009 06:13:45 -0700 (PDT)
Received: from ?192.168.2.242? ([202.201.14.140])
        by mx.google.com with ESMTPS id m34sm12217089waf.21.2009.05.24.06.13.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 06:13:44 -0700 (PDT)
Subject: Re: [loongson-PATCH-v1 22/27] Hibernation Support in mips system
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <20090521124318.GC19476@linux-mips.org>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	 <817be0da759e19d781e98237cc70efeb33f10a40.1242855716.git.wuzhangjin@gmail.com>
	 <20090521124318.GC19476@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sun, 24 May 2009 21:13:22 +0800
Message-Id: <1243170803.15634.3.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-05-21 at 13:43 +0100, Ralf Baechle wrote:
> On Thu, May 21, 2009 at 06:11:11AM +0800, wuzhangjin@gmail.com wrote:
> 
> This patch does no longer apply.  When submitting new code please always
> base it on the latest development kernel.  Any -stable kernel will probably
> be too old.
> 
> Can you rebase this patch to the master branch of linux-mips.org and
> re-submit?  Thanks!
> 

seems rebase will generate lots of merge conflicts, i am cloning the
master branch of linux-mips.org and build a new branch.

>   Ralf
