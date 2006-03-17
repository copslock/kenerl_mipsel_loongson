Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 00:45:17 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.206]:50325 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133445AbWCQApJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Mar 2006 00:45:09 +0000
Received: by nproxy.gmail.com with SMTP id i2so355038nfe
        for <linux-mips@linux-mips.org>; Thu, 16 Mar 2006 16:54:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VJhPKkV8+e/qFZmfJ1VrV3//FZ3KICft9OkoiUd4jbme7eskqs9rrGk/i01XEwcVVMcwo9FeG5frR3/bIDDlLjZRbqGhmYmj7NwqhpAFjczMHtPkAbh/e/co5vnOfW9phhz0Y3qyr0ka5qllVqSExc94Wj8e1bEJEk1veEKtHyY=
Received: by 10.48.224.18 with SMTP id w18mr1119915nfg;
        Thu, 16 Mar 2006 16:54:25 -0800 (PST)
Received: by 10.48.144.19 with HTTP; Thu, 16 Mar 2006 16:54:25 -0800 (PST)
Message-ID: <50c9a2250603161654u52f6f5dbkddbc582bdc58b942@mail.gmail.com>
Date:	Fri, 17 Mar 2006 08:54:25 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: how to use telnetd of busybox
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <cda58cb80603152342wcf14e48n@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250603152248s4e0343ccwfb44f9ad30300f67@mail.gmail.com>
	 <cda58cb80603152342wcf14e48n@mail.gmail.com>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/16/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> 2006/3/16, zhuzhenhua <zzh.hust@gmail.com>:
> >
> > do i miss something? maybe need any other service for telnetd?
> >
>
> Did you enable pty support in your kernel ?
i add the pty support both in kernel and busybox

>
> --
>                Franck
>
