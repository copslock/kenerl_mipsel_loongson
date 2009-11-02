Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 12:43:32 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:52643 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493838AbZKBLn0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 2 Nov 2009 12:43:26 +0100
Received: by bwz21 with SMTP id 21so6142656bwz.24
        for <multiple recipients>; Mon, 02 Nov 2009 03:43:21 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=3zhy4PTl+VqzfJXPMsuBbS7WFVbrU6XimSyYW9G6r8A=;
        b=VhnOvkPuvRuoS1EqNB363nHPu2dyw3/8UljcFwPkaKTSLz4Q/KHjvx5LJLqDEc+XMN
         ETFQN0iUF0MydhHFOhvtUWqC/p0rxbXYnJiZBLCp/7yEkdHv77IOJh709MM/OKDMU+u1
         5THKD8WjAeteuYH/kkDaGA9Ugi/KNEn9J1zso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Zy+34hCOKQmFUoH/PQ3o5HdNthCkErUCbuvRhEPr7i6sp5wxUeAUbItJ35CKNUi7IA
         S8kN5NJPq/8xoLxbDNtCEalEdOdA0/5Vhvzk5BmWCNVbKWvO2egFhu5h2LkhKN5h6gxi
         tP3oLg60IEIIuZARh0t7XdvbvbZQGi6AVpyUM=
MIME-Version: 1.0
Received: by 10.223.20.85 with SMTP id e21mr743846fab.25.1257162200693; Mon, 
	02 Nov 2009 03:43:20 -0800 (PST)
In-Reply-To: <20091102112955.GA2821@linux-mips.org>
References: <200910181604.11732.florian@openwrt.org>
	 <f861ec6f0910190412i3910246dgcdf6b8b56a8ed5b3@mail.gmail.com>
	 <20091102112955.GA2821@linux-mips.org>
Date:	Mon, 2 Nov 2009 12:43:20 +0100
Message-ID: <f861ec6f0911020343v69c8d82q16ad1af7691471af@mail.gmail.com>
Subject: Re: [PATCH 1/2] alchemy: fix warnings in db1x00/pb1000/pb1550 board 
	setup code
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Mon, Nov 2, 2009 at 12:29 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Oct 19, 2009 at 01:12:15PM +0200, Manuel Lauss wrote:
>
>> I like it, thank you!
>
> Except that it a) does things the comments don't mention and b) doesn't

It does eliminate all the "variable may be unused"-type warnings...


> apply on top of master or -queue ...

It did apply against -queue when Floarian initally sent it.  If he doesn't
resurface in the next few days I'll send an update version.

Manuel
