Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2009 02:23:52 +0100 (BST)
Received: from mail-qy0-f103.google.com ([209.85.221.103]:39886 "EHLO
	mail-qy0-f103.google.com") by ftp.linux-mips.org with ESMTP
	id S20031333AbZDQBXo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Apr 2009 02:23:44 +0100
Received: by qyk1 with SMTP id 1so1488798qyk.22
        for <multiple recipients>; Thu, 16 Apr 2009 18:23:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=YW6Pdxt0ERo1zcDoHMIC8LsRs5n6sppgGqWPcJbY2Lw=;
        b=law/CMeRDydUNYhfqbb5CpBGAMa0TYdYk7QeoSdmWpFai7HI9ltzFIJbsQjBc6cmgO
         Gn+SKvilTY8SFdSs+X45izcSElOJQTKoqQ2+QVtAtCuueSmQy5N8u4cQu6nRj4FGhKJZ
         oc1cHjQMOP0hz7i4raWd4u4q4FviBpWFhFm0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=jB27auqdAZ6Ph0kNROFiisv6jZS+rYx8136tAte976J+gGtbrJvxWG9oS9MJWqneGZ
         cFAPP7XEA+5BxhfD6+kGxtD9mravNTTjfjZdqIPxU6/rfqoaW+hrfW4uS3r0WaihDupv
         tloBv1gouE+4pzgmWQeaIZ37sYiH/XkDaoPTg=
MIME-Version: 1.0
Received: by 10.224.89.76 with SMTP id d12mr2709744qam.378.1239931415159; Thu, 
	16 Apr 2009 18:23:35 -0700 (PDT)
In-Reply-To: <1239033288-3086-1-git-send-email-anemo@mba.ocn.ne.jp>
References: <1239033288-3086-1-git-send-email-anemo@mba.ocn.ne.jp>
Date:	Thu, 16 Apr 2009 18:23:35 -0700
X-Google-Sender-Auth: 4b97977ee1523b34
Message-ID: <e9c3a7c20904161823j2cce3a6fpea95ba79ccf871a3@mail.gmail.com>
Subject: Re: [PATCH] DMA: TXx9 Soc DMA Controller driver (v2)
From:	Dan Williams <dan.j.williams@intel.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dan.j.williams@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.j.williams@intel.com
Precedence: bulk
X-list: linux-mips

On Mon, Apr 6, 2009 at 8:54 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> This patch adds support for the integrated DMAC of the TXx9 family.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---

Just so you know I have not forgotten about this...  I have pulled
this version and integrated it into my cross-compile environment, so
far so good.  I will try to get you an Acked-by by tomorrow.

Ralf, I think I will leave the merge up to you.  As long as NET_DMA=n
and ASYNC_TX_DMA=n the chance for a regression is low, but it's your
call.

Regards,
Dan
