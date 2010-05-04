Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 13:50:46 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:57383 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492500Ab0EDLul (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 13:50:41 +0200
Received: by pvg4 with SMTP id 4so1522144pvg.36
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=dZZL4iaaVYu7UVisQf+P3bWjoITH8qsuE8D5kEqUeJw=;
        b=i+pXyunh7GA7DG6gCJNa6BQCmdWBdGpFeCLID7stCG2DOXfC8kq/gM3dksNmwSsoy+
         Vm5HLR+eNRQ8UUTcpJi7MgKy3T7b9dr/BP6It+j6sHTZ5VOikwjkj6FdTD0TVMkeSEHD
         AU1bmMrfSAy8LBvrfJJlRgGWTrRd4Ez938E+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=rkEc6LVckym/Ll+qfJXVZu9ENxDPUQ7cR9ehOAKRqKRh+DbWNzxEW0So6CfQtjRUNI
         GgRmMb+VoVD0IJRfj1qeDr/AVme/zC0qsC3FAeCm6PV0ZgGJM4Yk2PQyg2zEL/8zaUdf
         xxVGUUVP6tAQ+HZRsqVK9FNxqJbYNEP0wed4k=
Received: by 10.115.102.20 with SMTP id e20mr1318212wam.194.1272973834237;
        Tue, 04 May 2010 04:50:34 -0700 (PDT)
Received: from [192.168.2.214] ([202.201.14.140])
        by mx.google.com with ESMTPS id b6sm29238559wam.21.2010.05.04.04.50.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 04:50:33 -0700 (PDT)
Subject: Re: [PATCH 0/12] add basic gdium support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Arnaud Patard <apatard@mandriva.com>
Cc:     yajin <yajinzhou@vm-kernel.org>, linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>
In-Reply-To: <m34oinx60z.fsf@anduin.mandriva.com>
References: <z2l180e2c241005040254y895e5456sf37194c97f3f739f@mail.gmail.com>
         <m34oinx60z.fsf@anduin.mandriva.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 04 May 2010 19:50:18 +0800
Message-ID: <1272973818.9547.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Arnaud

On Tue, 2010-05-04 at 13:25 +0200, Arnaud Patard wrote:
> yajin <yajinzhou@vm-kernel.org> writes:
> 
> Hi,
> 
> > Gdium is a netbook based on loongson2f CPU and sm502 SOC. It does NOT
> > have a south bridge. The sm502 SOC is used for LCD controller and
> > audio output. This series of patches are adding gdium support to
> > ralf's linux-mips repository.
> 
> what's wrong with you ? I told you I was going to send patches and now
> you're sending yours (judging by a quick look) which:
> - are incomplete and/or broken
> - no respect of patch authorship
> 
> The gpio patch is even a dup of a patch I sent last week...
> 
> What's the aim here ? Sending your patches before mines to annoy me ?
> 

Seems Yajin was sending the patches for the first time, I guess he was
not intended. Perhaps you two can cooperate with each other to add the
gdium support ;)

Best Regards,
	Wu Zhangjin
