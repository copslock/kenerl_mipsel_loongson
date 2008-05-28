Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2008 04:15:18 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.247]:63384 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20021393AbYE1DPQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 May 2008 04:15:16 +0100
Received: by rv-out-0708.google.com with SMTP id c5so2557904rvf.24
        for <linux-mips@linux-mips.org>; Tue, 27 May 2008 20:15:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1lI4LCLH1URYbLYIUnQp9sz1tkLWcby+diGqZhCJ06Y=;
        b=G+vWWCCnYT0RQ81/+C2+3YbFt9ltM4S+jukReSZZxSuSXGnhSckSeLf/NaKSifbMcfaEl0/4nkVYkdZBv0ak78p6qzEbMMbJabReCcG/cyKQOFTphaHMh0L8FV/ymvfJubdOdia/eATaV5AwbDzeyhSVh6UJ/WUmgWwlhZrNcTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A7JQGKtwm+W76pT9vg4U2Zwov8cqI3HABWAo/X4Ph79DZBzhZEo6pYYIHun2rOpxFdwwSwKs0eah9BEc3+6SNAGgABsjgxwQVGIdLYBDpKotxNoOmMAAZ0a+WN6dhb8JDAR0aUeeiDOBrj8jmlru4mF9l1lTfvd/lFZ9+erpp+0=
Received: by 10.142.87.7 with SMTP id k7mr818068wfb.167.1211944513237;
        Tue, 27 May 2008 20:15:13 -0700 (PDT)
Received: by 10.143.42.1 with HTTP; Tue, 27 May 2008 20:15:12 -0700 (PDT)
Message-ID: <dcf6addc0805272015w1f60457bic919ee3acc79d0fb@mail.gmail.com>
Date:	Wed, 28 May 2008 11:15:12 +0800
From:	"Jun Ma" <sync.jma@gmail.com>
To:	"Manuel Lauss" <mano@roarinelk.homelinux.net>
Subject: Re: MIPS kernel hangs: Warning: unable to open an initial console. /sbin/init
Cc:	abhiruchi.g@vaultinfo.com, linux-kernel@vger.kernel.org,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	kernel-testers <kernel-testers@vger.kernel.org>
In-Reply-To: <20080515133855.GA20300@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <55815.192.168.1.71.1210856139.webmail@192.168.1.71>
	 <20080515133855.GA20300@roarinelk.homelinux.net>
Return-Path: <sync.jma@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sync.jma@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, May 15, 2008 at 9:38 PM, Manuel Lauss
<mano@roarinelk.homelinux.net> wrote:
> On Thu, May 15, 2008 at 08:55:39AM -0400, abhiruchi.g@vaultinfo.com wrote:
>> Hi,
>>
>> My kernel hangs by initializing the system. My target is Alchemy DB1200. I use crosstool-ng to build MIPS cross toolchain and ptxdist to build ext2 filesystem.
>> kernel version:linux-2.6.22
>
> Try and add "console=ttyS0,115200" to the kernel commandline (either in
> yamon or kernel config).
>
>

And you must have a tty node in your /dev directory, e.g. /dev/ttyS0


-- 
FIXME if it is wrong.
