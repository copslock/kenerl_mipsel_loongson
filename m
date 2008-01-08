Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 22:02:17 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.182]:4988 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024307AbYAHWCJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jan 2008 22:02:09 +0000
Received: by wa-out-1112.google.com with SMTP id m16so12278679waf.20
        for <linux-mips@linux-mips.org>; Tue, 08 Jan 2008 14:02:08 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7qAlExXd1KhfKHKRNSZvqy1YAyvY8ymWnmaYZdNPbaY=;
        b=vWTClYSr5nJfry0Vyu/YOU1K7UZRfpG6aQyoRC/5tIY3MO4Ke8E30bg7dYjYTVYoqc7DhIpGy0HThl3kj64T79o4pwUO2CDeIo4uJP6Jcy22qXMfNP0bQERL+tj7wHJtbdW414eH+NPMge5Pa/CoNUW4l1yD9w3HlYUEB7WADhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=llkWI/yJOR5N9Km/THJdlRsj0GnLLr0seSqfZ2xeRKXGFMbJyoD7AaaiOpZ0V2koUF08+fM1n23rjJG0OZvmAcDya2ag/L4SxFXqDBL8G/U1sgoOqwnIGDXxoVf8qN0y0XIbWmlfCPbJS5ikVDBJnjnf/arWgAYcWOUO84ia778=
Received: by 10.114.192.1 with SMTP id p1mr6602702waf.47.1199829727954;
        Tue, 08 Jan 2008 14:02:07 -0800 (PST)
Received: by 10.115.110.5 with HTTP; Tue, 8 Jan 2008 14:02:07 -0800 (PST)
Message-ID: <24f397b0801081402j24f7000cr841090ba5ab9bcc1@mail.gmail.com>
Date:	Tue, 8 Jan 2008 17:02:07 -0500
From:	"Mark Lin" <lin.mark@gmail.com>
To:	"Jorgen Lundman" <lundman@lundman.net>
Subject: Re: MIPS 4KEc with 2.6.15
Cc:	linux-mips@linux-mips.org
In-Reply-To: <47824ACF.7050003@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <478174C1.2090708@lundman.net> <47824ACF.7050003@avtrex.com>
Return-Path: <lin.mark@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lin.mark@gmail.com
Precedence: bulk
X-list: linux-mips

Jorgen,

You should not be using the atlas definition.  Try the tangox one instead.

With the flush_cache_page changes, FUSE works fine for me using 2.6.15
and Sigma's tango2 board.

Mark Lin

On Jan 7, 2008 10:52 AM, David Daney <ddaney@avtrex.com> wrote:
> Jorgen Lundman wrote:
> >
> > Hello list,
> >
> > I have an embedded device running 2.6.15 kernel on a MIPS 4KEc 300MHz
> > CPU. It was configured for Sigma's tango2 board, which I know nothing
> > about, so I picked a mips-board by random, "atlas", and found I can
> > produce working kernel module compiles.
> >
> > However, when I compiled FUSE kernel module, it behaves erratically in
> > a way making the FUSE developer think I may have come across the cache
> > coherency bug in arm and mips, fixed sometime around 2.6.17.
> >
> > Since I can not change the kernel that is running, I was looking for
> > alternate solutions. FUSE itself has a work around, that calls
> > flush_cache_page(), but I found that mips-board atlas does not have
> > this defined:
> >
> > fuse: Unknown symbol flush_cache_page
>
> There are cache coherency issues on the 8634.  You should be using the
> vendor's very most recent kernels.  For me they seem to have resolved
> the cache issues.
>
> Also as noted by others, you need the exact kernel sources if you are
> going to build working modules.
>
> David Daney
>
>
