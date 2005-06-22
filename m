Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 09:54:23 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.204]:7996 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8225400AbVFVIyH> convert rfc822-to-8bit;
	Wed, 22 Jun 2005 09:54:07 +0100
Received: by zproxy.gmail.com with SMTP id 13so154892nzp
        for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 01:52:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tLoAkWL1a8PksBaXaPQ/uqZ/kMRAbL+pDYHNjqc1DdWfSEhEwa+BXKa98gEUYeFUxwV2Q6U+8YBi84Ia7HFgBKtw46OzFw0Ztj+KNcbTzIffOhWFmlH2m4sSm8IBZt+yBnGM9+tKNSctF4JmLhotejz61EEFWQpKdrDjl0qdiyA=
Received: by 10.36.146.1 with SMTP id t1mr399819nzd;
        Wed, 22 Jun 2005 01:52:55 -0700 (PDT)
Received: by 10.36.68.6 with HTTP; Wed, 22 Jun 2005 01:52:55 -0700 (PDT)
Message-ID: <6097c49050622015238fd892d@mail.gmail.com>
Date:	Wed, 22 Jun 2005 12:52:55 +0400
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: strace n64 support
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050621175936.GN6461@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <6097c4905062110482288b0a8@mail.gmail.com>
	 <20050621175936.GN6461@linux-mips.org>
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

Any estimation for it? Probably I will be able to spend some time on
strace, and do not want to duplicate efforts.

Maxim

On 6/21/05, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jun 21, 2005 at 09:48:55PM +0400, Maxim Osipov wrote:
> 
> > I was looking at strace-4.5.12 and noticed, that
> > linux/mips/syscallent.h has syscall numbers only for o32. Are n32 and
> > n64 supported? Google doesn't help ;(
> 
> Strace is currently somewhat broken anyway.  I'm looking into getting it
> going, so thanks for letting me know.
> 
>   Ralf
>
