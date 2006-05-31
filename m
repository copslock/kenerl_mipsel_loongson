Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 08:11:10 +0200 (CEST)
Received: from wr-out-0506.google.com ([64.233.184.228]:27662 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8133448AbWEaGLC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 08:11:02 +0200
Received: by wr-out-0506.google.com with SMTP id i23so862695wra
        for <linux-mips@linux-mips.org>; Tue, 30 May 2006 23:11:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kEsabfzS4QnI0FMxplVYG8w/q9xbO184VLCmQksV/dRE+xOJyXYhlRkYx8dWrgxl03LGNAI52yO3oWmbQhLrh5IkyA3TNwBxU8kE9DynfNF6RraPmLJZ5H9h5saizMMwnx70aa+qSti1qltG1R15bXfCOlS8vW3ErCsKfabw4S8=
Received: by 10.54.146.5 with SMTP id t5mr1227831wrd;
        Tue, 30 May 2006 23:11:00 -0700 (PDT)
Received: by 10.54.156.9 with HTTP; Tue, 30 May 2006 23:11:00 -0700 (PDT)
Message-ID: <5800c1cc0605302311p2d1f024bm96ac6e08cda1bc2f@mail.gmail.com>
Date:	Wed, 31 May 2006 14:11:00 +0800
From:	"Bin Chen" <binary.chen@gmail.com>
To:	zhuzhenhua <zzh.hust@gmail.com>
Subject: Re: how to disable interrupt in application?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <50c9a2250605301733t788c16f9k739c17e4a6a4efee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <50c9a2250605301733t788c16f9k739c17e4a6a4efee@mail.gmail.com>
Return-Path: <binary.chen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: binary.chen@gmail.com
Precedence: bulk
X-list: linux-mips

man sigprocmask

On 5/31/06, zhuzhenhua <zzh.hust@gmail.com> wrote:
> our project have a video decoder code run as application. there is
> some short code want to be run uninterruptable. is there anyway to do
> it?
> thanks for any hints
> Best Regards
>
>
> zhuzhenhua
>
>
