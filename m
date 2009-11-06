Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 17:22:23 +0100 (CET)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:39101 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492939AbZKFQWQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 17:22:16 +0100
Received: by fxm3 with SMTP id 3so278496fxm.24
        for <linux-mips@linux-mips.org>; Fri, 06 Nov 2009 08:22:10 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=YeQAqqaOaKnkNMfC0SaJexwgro96aJYQuuHbPxGXw98=;
        b=V68LcFI2VzyqCaFf49uOMbBGkAm3Ft9wWFBLVWSejEzvuqCNin3fzffGKtoLwkcivd
         +b7CyHX4yq9oJUusoZyoOWyVl9nDLDg1WpaD3egvoBx9fZ3DRymGTcyInVnPbsORZ3Ib
         hBgrGkMzBGK04kOIQTsccqTpNJ6QA5XMtxWHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=O46i4MdQ3ypgzREBfS7yeKa86OOaMabXJQC8WHWzW5O24vH4X4payrMozTaioq9tGQ
         +MXQyEbx8wnptqEah02XlFI+mcgVWVVvLRg6XWl1j/PsDcuaBjLcjRTSxhz4WHBuJskX
         x8mR6kdJq6GEw/0QjArilx6g2tzmHOBCuJUVg=
MIME-Version: 1.0
Received: by 10.223.164.75 with SMTP id d11mr696322fay.17.1257524529753; Fri, 
	06 Nov 2009 08:22:09 -0800 (PST)
In-Reply-To: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
Date:	Fri, 6 Nov 2009 18:22:09 +0200
Message-ID: <90edad820911060822g40233a8ft28001d68186b989e@mail.gmail.com>
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Nov 6, 2009 at 6:08 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Recently COMMAND_LINE_SIZE (CL_SIZE) was extended to 4096 from 512.
> (commit 22242681 "MIPS: Extend COMMAND_LINE_SIZE")
>
> This cause warning if something like buf[CL_SIZE] was declared as a
> local variable, for example in prom_init_cmdline() on some platforms.
>
> And since many Makefiles in arch/mips enables -Werror, this cause
> build failure.
>
> How can we avoid this error?
>
> - do not use local array? (but dynamic allocation cannot be used in
>  such an early stage.  static array?)

Maybe a static array marked with __initdata?

Dmitri
