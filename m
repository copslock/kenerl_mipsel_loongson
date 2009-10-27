Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2009 02:38:09 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:62406 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493344AbZJ0BiE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2009 02:38:04 +0100
Received: by yxe42 with SMTP id 42so5265640yxe.22
        for <multiple recipients>; Mon, 26 Oct 2009 18:37:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=U4vsnlF/NLm3RPIW3lHE8+KHwrwHlQ4xg0IqTbBxiMw=;
        b=mLmGmBi5Fc6sdkIPfX7hosd4KkWwqj+i4Houk2INV8EqLWT6jJvsqiSSnqd9Z6Vmjf
         T/mKhwWAW6yYUsJB/T5nIaTYMzHfL4Bkp7ubUEgRby2J4R4oRSC7btLZx9VRT/VX8vJi
         0tGI3XBbmRa4Hp193CVOIFkYFqhnUi+KKz0y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=IrQ8ctM8mxE2CTjuHxCW6VzoUwBv1Lmpe8ACxZ13l21gvmf/5uxxckyhn7R7PMZeKM
         LfYQeAxuVXf4xiyzOm+ExyKoDce+wZqRf9Ee6+V4a0jIlDJj6wF9LWzpqa0JhXqu2fgT
         6itd3qdkmdBmvSULZR00d0Gbpgu1CVKv8ZHP8=
Received: by 10.90.40.37 with SMTP id n37mr17964024agn.74.1256607477709;
        Mon, 26 Oct 2009 18:37:57 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm1586137yxe.20.2009.10.26.18.37.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 18:37:57 -0700 (PDT)
Subject: Re: What ever happened to: [PATCH] MIPS: add support for
 gzip/bzip2/lzma compressed kernel images
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	rostedt@goodmis.org
Cc:	LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
	alex@digriz.org.uk, ithamar.adema@team-embedded.nl,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1256606966.26028.364.camel@gandalf.stny.rr.com>
References: <1256606966.26028.364.camel@gandalf.stny.rr.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Tue, 27 Oct 2009 09:37:48 +0800
Message-Id: <1256607468.5499.7.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

On Mon, 2009-10-26 at 21:29 -0400, Steven Rostedt wrote:
> Hi,
> 
> I'm playing with ftrace on MIPS thanks to Lemote for supplying me a
> machine. And I noticed that, although Wu's repo gives me a nice vmlinuz
> to install, the default kernels do not.
> 
> Wu wrote a nice patch that adds this feature, and I see that he posted
> it a few months back:
> 
> http://www.linux-mips.org/archives/linux-mips/2009-08/msg00056.html
> 
> I do not see it in the mainline nor in Ralf's repo on kernel.org. I'm
> hoping that it did not get lost and forgotten. What ever happened to it?

Ralf have added this to his -queue git repo:

http://www.linux-mips.org/git?p=linux-queue.git;a=commit;h=9d20b1ddf20c3ead5e381a1d06471c33d7f3cb6d

Thanks :-)
	Wu Zhangjin
