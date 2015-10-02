Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2015 18:04:14 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36279 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008665AbbJBQENTWn7U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Oct 2015 18:04:13 +0200
Received: by pablk4 with SMTP id lk4so109409445pab.3
        for <linux-mips@linux-mips.org>; Fri, 02 Oct 2015 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=gmUI/1dd2ylRyzt6/Efb++jqfLYbjt97pfOxk2J9gUs=;
        b=dCpTGaVas/5eJ9bhyawak9pPBvme7pkjZP5v+3OLMBlVDyS9kOdQGRFDn/RSBBXjph
         wk5Zf35Ym8n0kmWbz/ydodRNx4+B4+LZMo+Eyi5ef5Coq6Q89zEfZlP8WdLuO/ibjGc1
         Ghw/HM1zLFBwUL7IRUq5uC/BMWbHmw9K6O9XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gmUI/1dd2ylRyzt6/Efb++jqfLYbjt97pfOxk2J9gUs=;
        b=PhgfxmLLOAd42OwFqKNrPyqNf3yvE47eMiYKy6RQaTg9Q2OgCPJ8e8ncVEkaPYCW7D
         982bt6+NFj0QJHxZIE+IRvAYk5PGijQYDkZHRKxXwNvZO7Wf3EKcDEqGLjkOqYVYebPd
         VG5iJhAFcTr0aBmGx01oX6p25xVHDwJmk6EkK9vf/N2TjJhMIfUtnfJCxAcZSqVdbHCi
         CGtDjsZE2mjByKo5/VegubUUd/VljbSzcCEoqtVXflqBTDB/GkG05X40KCuZRhcbPbba
         TYVl/ORAtUnW/1nxTOYH9C4AX+rkankjeDuJx9GOcqVmlY+7Sdsg7v6OUyyCHXXQ3Z/g
         Qqbg==
X-Gm-Message-State: ALoCoQm4g0uKcfYWkx+mcX6UeoZcsUlgmIPtgmE3SCyLHiP4TFEWAKxGgRHX4nrz2EgyxgvnTPkF
X-Received: by 10.69.11.196 with SMTP id ek4mr21118653pbd.148.1443801844551;
        Fri, 02 Oct 2015 09:04:04 -0700 (PDT)
Received: from [192.168.1.121] ([174.51.92.64])
        by smtp.googlemail.com with ESMTPSA id yi8sm12767580pab.22.2015.10.02.09.04.03
        for <linux-mips@linux-mips.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Oct 2015 09:04:03 -0700 (PDT)
Subject: Fwd: Re: [PATCH net-next 3/5] net: Refactor path selection in
 __ip_route_output_key
References: <201510021431.hGNWKbMp%fengguang.wu@intel.com>
To:     linux-mips@linux-mips.org
From:   David Ahern <dsa@cumulusnetworks.com>
X-Forwarded-Message-Id: <201510021431.hGNWKbMp%fengguang.wu@intel.com>
Message-ID: <560EAAF3.3040509@cumulusnetworks.com>
Date:   Fri, 2 Oct 2015 10:04:03 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <201510021431.hGNWKbMp%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dsa@cumulusnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dsa@cumulusnetworks.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello:

I could use some help understanding a message from a kbuild robot. I 
submitted this patch:
     https://patchwork.ozlabs.org/patch/525102/

Which moves existing code into a function that is exported for modules. 
The kbuild robot found this warning:

-----

config: mips-nlm_xlp_defconfig (attached as .config)
reproduce:
         wget 
https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross 
-O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # save the attached .config to linux build tree
         make.cross ARCH=mips

All warnings (new ones prefixed by >>):

>> mips-linux-gnu-ld: net/ipv4/.tmp_fib_semantics.o: warning: Inconsistent ISA between e_flags and .MIPS.abiflags

-----

I have no idea what that message means. I tried googling and found this 
recent thread:
     http://www.linux-mips.org/archives/linux-mips/2015-05/msg00156.html
and accompanying one:
     https://sourceware.org/bugzilla/show_bug.cgi?id=18401

Can someone shed light on what the message means, why my patch generated 
the message and better yet how to fix it?

Thanks,
David
