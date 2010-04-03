Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Apr 2010 03:50:05 +0200 (CEST)
Received: from mail-yw0-f189.google.com ([209.85.211.189]:60347 "EHLO
        mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492194Ab0DCBt7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Apr 2010 03:49:59 +0200
Received: by ywh27 with SMTP id 27so1659038ywh.22
        for <multiple recipients>; Fri, 02 Apr 2010 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=TqmLzh3tk62OgCfAHtx9d5B4mj7XQafF2uQTwtkvbAs=;
        b=C4P0ig7W81zYLeKumGD1pluL3RhLtS0hu+aW7l0BvL0M6NYxkgwS1A1msEPlo2YyG+
         4SN/Tr2MO9fYJyHIEJGpCxOwQneAG74q1JtkVAzhLNLFDra3sMnlisGXSe1DBj8C9BFO
         r4S1R+pn5/l1Ld9KYglTHgrtoqhPTB9SxnsSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=jiYhPpX8zhIt+NIjBjrHx6tYZh4zZxmqj+GDVANFRdkPJ9kbDdUt0Nr42hcSkYgZTC
         CCuxQVyk9H9U04Bt1ORr5IJN8zHz35Fo123CALMlZF4vcVTtvEY13cr4k6XMi84y0inu
         AhV0XcKDUpQ0u66MnogmuAVqosOMk5Pz4h+P8=
Received: by 10.101.142.37 with SMTP id u37mr6906396ann.79.1270259391431;
        Fri, 02 Apr 2010 18:49:51 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm426796iwn.12.2010.04.02.18.49.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Apr 2010 18:49:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] Loongson-2F: Flush the branch target history
 such as BTB and RAS
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Andreas Barth <aba@not.so.argh.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20100402145401.GS27216@mails.so.argh.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
         <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com>
         <20100402145401.GS27216@mails.so.argh.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 03 Apr 2010 09:42:55 +0800
Message-ID: <1270258975.23702.18.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2010-04-02 at 16:54 +0200, Andreas Barth wrote:
> * Wu Zhangjin (wuzhangjin@gmail.com) [100313 05:45]:
> > This patch did clear BTB(branch target buffer), forbid RAS(return
> > address stack) via Loongson-2F's 64bit diagnostic register.
> 
> Unfortunatly the Loongson 2F here still fails with this patch,
> compiled with the new binutils and both options enabled.
> 
> Testcase: plain debian unstable chroot, build binutils in that chroot.
> 
> More ideas, codes, whatever welcome.

Hi,

This patch is not enough, please use the kernel(>=2.6.32) from
http://dev.lemote.com/code/rt4ls or
http://dev.lemote.com/code/linux-loongson-community

Regards,
	Wu Zhangjin
