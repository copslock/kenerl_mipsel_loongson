Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 04:06:28 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:47768 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854784AbaEVCG0aKaeX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 May 2014 04:06:26 +0200
Received: by mail-pd0-f177.google.com with SMTP id g10so1942833pdj.22
        for <multiple recipients>; Wed, 21 May 2014 19:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LlKU5CbWHh3W05HbzZUMrAkh1ix8ha2lHEI7CwBNaBU=;
        b=ppmyHEfoVMkzMb5qIfkuAzygg5x+HQgVkO4TyGIpLjBkNAbnqDtVF0Jb9OmPvRxw5s
         BkB3pAzTdY+9y4U0s915ykYjQgf6/W5/NcfdsvW9WcBInjI/2n24YuCXd1vmiBc1XjIA
         PG7uLpBHTIOrORWUTHAq6JY0gPNLwNEaBs/sHSNrvQE0O6jsasfEwgNI9+dgd2LzRf8m
         iNUPWpfNP/KwzChmdBal/pKYcSjD5/4lAWV/654YFDTLwRSTLbBiRZ4nxht6CsRYXNOc
         GLh2IcoDEXAK2zDk0DPALnzgrZDMNcHHcgdwBsonBgBfpXVPbsbQXrxyE/j9dTcscbKI
         mwKA==
X-Received: by 10.66.139.168 with SMTP id qz8mr62823250pab.3.1400724379727;
        Wed, 21 May 2014 19:06:19 -0700 (PDT)
Received: from localhost ([1.202.252.122])
        by mx.google.com with ESMTPSA id px10sm112544276pac.41.2014.05.21.19.06.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 19:06:18 -0700 (PDT)
Date:   Thu, 22 May 2014 10:06:11 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Yong Zhang <yong.zhang@windriver.com>, linux-mips@linux-mips.org,
        huawei.libin@huawei.com
Subject: Re: [PATCH] MIPS: change type of asid_cache to unsigned long
Message-ID: <20140522020611.GA6813@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <1400573344-5035-1-git-send-email-yong.zhang0@gmail.com>
 <20140521053853.GC19655@pek-yzhang-d1>
 <20140521112936.GC17197@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140521112936.GC17197@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <yong.zhang0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
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

On Wed, May 21, 2014 at 01:29:36PM +0200, Ralf Baechle wrote:
> On Wed, May 21, 2014 at 01:38:53PM +0800, Yong Zhang wrote:
> 
> > Please check the V2 in which I add the reporter.
> > And thanks libin for reporting it :)
> 
> The bug was introduced in 5636919b5c909fee54a6ef5226475ecae012ad02
> [MIPS: Outline udelay and fix a few issues.] in 2009 btw.  I think
> the intension was to avoid holes in the structure and minimize
> the bloat.  I instead applied aptch

Could you please show the patch?

> which also moves another member
> of the struct arond such that no hole will be created in the struct.
> This is important because the strcture it accessed fairly frequently
> so we want to fit the most important members into as few cache
> lines as possible.

I have tried to move the struct member around, but I found that the
hole cann't be avoided completely because for exampe struct cache_desc
is a bit special.

Thanks,
Yong


> 
> Thanks,
> 
>   Ralf
