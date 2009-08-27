Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 14:50:00 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:35912 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492415AbZH0Mty convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Aug 2009 14:49:54 +0200
Received: by bwz4 with SMTP id 4so1162458bwz.0
        for <multiple recipients>; Thu, 27 Aug 2009 05:49:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oiSvMLcaDijXlimguMTDVMe3HEVvsCylxl29SI2h9MM=;
        b=UDlVWWHPyXDf9MtnWl9obDmbsIy4ukPQiBQjbGO7JYxJWySJbfpcRHI6RcNuX/u66w
         ggoDRToX+btdrzOne9LYH5hVQtrXG82Bzr1phrYvS29GjgEfpqxwWgetSbYre+lKrzuo
         H/VRkbq9OMpksrUccXwwSjkVcHZclebXHNL5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EWOuC5oYUf8hiwispUfvhge3g7um0pYoVthPrxwsw90AiNpa2vXRMASUvWzAJGG4zN
         Tti88Uu7fEPQPyEeUaCvNWXXkeXvzR+zyLre0/ommpfuysoHSu1VYet18ge8F+4f2Qqu
         k1lxyEnoEexXoddBEsl/wPAvogOPLAd07aXCI=
MIME-Version: 1.0
Received: by 10.223.14.215 with SMTP id h23mr6707449faa.59.1251377386531; Thu, 
	27 Aug 2009 05:49:46 -0700 (PDT)
In-Reply-To: <20090827114751.GC29984@linux-mips.org>
References: <1250957401-14447-1-git-send-email-manuel.lauss@gmail.com>
	 <1250957401-14447-2-git-send-email-manuel.lauss@gmail.com>
	 <1250957401-14447-3-git-send-email-manuel.lauss@gmail.com>
	 <20090827114751.GC29984@linux-mips.org>
Date:	Thu, 27 Aug 2009 14:49:44 +0200
Message-ID: <f861ec6f0908270549r2b98596u493c881ce9514b49@mail.gmail.com>
Subject: Re: [PATCH 2/2] Alchemy: timer: support multiple SYS_BASE addresses
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 27, 2009 at 1:47 PM, Ralf Baechle<ralf@linux-mips.org> wrote:
> On Sat, Aug 22, 2009 at 06:10:01PM +0200, Manuel Lauss wrote:
>
> I had a a large reject on arch/mips/alchemy/common/time.c when applying
> this.  I fixed it up but could you verify that things are ok?  Patch is
> now also in the queue.  Thanks!

Oh, sorry about that!  The result looks okay.
I was hoping someone with an Au1300 could give this a spin and verify that the
basic idea works.

Thanks!
     Manuel Lauss
