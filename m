Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 02:22:21 +0100 (CET)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:42891 "EHLO
        mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492637Ab0CKBWS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 02:22:18 +0100
Received: by ewy24 with SMTP id 24so1823947ewy.27
        for <multiple recipients>; Wed, 10 Mar 2010 17:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=2XSk2EvzL9AEe5yNzUbOSYU+LP28vFmq+b97BY+/mZg=;
        b=Arj8BoDdUi2/5TCqW8DbxVpgkik1962ZgjoxGKPUfVJLH/+qkDBfAWi/sYQW40X6jG
         pfvxqufslHdYSSGJM7pL2DRQuMd8TdKZa36wR9hFG9SF+SQ0/sjuDFEVzHnaZDCj+q95
         SGfJ7wJhnhIyy98pZ2fxhDUReRg0rlEznPYdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=KWQHwAx6kYzcCEjddZ50sYw9vLPl2MgXeVVkq6T/PGtq9DPKK6sj0vvmIlqvQsAVmN
         Zy4QKqAiDvgFuaM9b01ok6MSbmvEP4PwOyv5IqbSmHK7EBJw9BEBsX2OkZMQ57vKTFzc
         FjbybnUsnUv/g5/iucn4cljC0oAnPiPgUXiVw=
Received: by 10.213.51.195 with SMTP id e3mr4787836ebg.96.1268270531994;
        Wed, 10 Mar 2010 17:22:11 -0800 (PST)
Received: from [202.201.12.142] ([202.201.12.142])
        by mx.google.com with ESMTPS id 14sm4333853ewy.10.2010.03.10.17.22.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 17:22:10 -0800 (PST)
Subject: Re: [PATCH] Loongson: Lemote-2F: Fixup of _rdmsr and _wrmsr
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <4B98369F.2060907@caviumnetworks.com>
References: <7c2dec50764082fafa83895b740f644fc592afa4.1268235182.git.wuzhangjin@gmail.com>
         <4B98369F.2060907@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 11 Mar 2010 09:15:41 +0800
Message-ID: <1268270141.12056.7.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-03-10 at 16:17 -0800, David Daney wrote:
> On 03/10/2010 07:41 AM, Wu Zhangjin wrote:
> > From: Wu Zhangjin<wuzhangjin@gmail.com>
> >
> > The _rdmsr, _wrmsr operation must be atomic to ensure the accessing to msr
> > address is what we want.
> >
> > Without this patch, in some cases, the reboot operation(fs2f_reboot) defined in
> > arch/mips/loongson/lemote-2f/reset.c may fail for it called _rdmsr, _wrmsr but
> > may be interrupted/preempted by the other related operations and make the
> > _rdmsr get the wrong value or make the _wrmsr write a wrong value to an
> > unexpected target.
> >
> > Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
> > ---
> >   arch/mips/pci/ops-loongson2.c |    9 +++++++++
> >   1 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/mips/pci/ops-loongson2.c b/arch/mips/pci/ops-loongson2.c
> > index 2bb4057..1f93dfb 100644
> > --- a/arch/mips/pci/ops-loongson2.c
> > +++ b/arch/mips/pci/ops-loongson2.c
> > @@ -180,15 +180,20 @@ struct pci_ops loongson_pci_ops = {
> >   };
> >
> >   #ifdef CONFIG_CS5536
> > +DEFINE_SPINLOCK(msr_lock);
> 
> 
> Should this be DEFINE_RAW_SPINLOCK instead?
> 

It should be, thanks!

Regards,
	Wu Zhangjin
