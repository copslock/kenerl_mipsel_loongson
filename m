Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2006 07:33:41 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.200]:4283 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8127173AbWCPHdd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Mar 2006 07:33:33 +0000
Received: by zproxy.gmail.com with SMTP id l8so315240nzf
        for <linux-mips@linux-mips.org>; Wed, 15 Mar 2006 23:42:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lebpyRzEtUPa9gpzsFjNZosOkv+f40O2VBhjom0grF99zqrvFnMUyPAUFvTJNpcDWdTnex0dJA5R5XarETMJAlmml1f99CAd73I4F5GymFm7gp/xnayf1DB2bKpSxce7wU16BksjG9c357fvYbnWYJiJvbLZejdZUUzJ2DZOAHU=
Received: by 10.36.221.24 with SMTP id t24mr726242nzg;
        Wed, 15 Mar 2006 23:42:47 -0800 (PST)
Received: by 10.36.49.14 with HTTP; Wed, 15 Mar 2006 23:42:47 -0800 (PST)
Message-ID: <cda58cb80603152342wcf14e48n@mail.gmail.com>
Date:	Thu, 16 Mar 2006 08:42:47 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	zhuzhenhua <zzh.hust@gmail.com>
Subject: Re: how to use telnetd of busybox
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <50c9a2250603152248s4e0343ccwfb44f9ad30300f67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250603152248s4e0343ccwfb44f9ad30300f67@mail.gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/3/16, zhuzhenhua <zzh.hust@gmail.com>:
>
> do i miss something? maybe need any other service for telnetd?
>

Did you enable pty support in your kernel ?

--
               Franck
