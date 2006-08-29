Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 08:31:38 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.200]:29407 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20037824AbWH2Hbf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 08:31:35 +0100
Received: by nz-out-0102.google.com with SMTP id i1so1002159nzh
        for <linux-mips@linux-mips.org>; Tue, 29 Aug 2006 00:31:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=JzSekLnNa9md9hvEGOCjiVUaSk8SmINUGp3LufP62Tca/QiVBNcVt/HckmZyzDZmjDNP51McZQbcqqawJG9m+FDN1bePVllanWrIiTMrbyTUKNf5tqKQnPwZCwYT86JQS4IpA9K+hKLlTdAkMghdhgUZ05+Ww7Xg0oHnz21Pkrg=
Received: by 10.64.184.14 with SMTP id h14mr8074477qbf;
        Tue, 29 Aug 2006 00:31:33 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id q15sm1407670qbq.2006.08.29.00.31.28;
        Tue, 29 Aug 2006 00:31:29 -0700 (PDT)
Message-ID: <44F3ED4B.9090202@innova-card.com>
Date:	Tue, 29 Aug 2006 09:31:23 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	vagabon.xyz@gmail.com
Subject: Re: [PATCH] make prepare_frametrace() not clobber v0
References: <20060829.121022.130240504.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060829.121022.130240504.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Since lmo commit 323a380bf9e1a1679a774a2b053e3c1f2aa3f179 ("Simplify
> dump_stack()") made prepare_frametrace() always inlined, using $2 (v0)
> in __asm__ is not safe anymore.  We can use $1 (at) instead.  Also we

Thanks, good catch !

		Franck
