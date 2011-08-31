Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2011 15:48:44 +0200 (CEST)
Received: from smtp-out.google.com ([216.239.44.51]:4332 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491863Ab1HaNsj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2011 15:48:39 +0200
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
        by smtp-out.google.com with ESMTP id p7VDmbh6028633
        for <linux-mips@linux-mips.org>; Wed, 31 Aug 2011 06:48:37 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1314798518; bh=8/lJBc/hoXHxmEuLi6nMt6HZKas=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type:Content-Transfer-Encoding;
        b=w1nfgkoob83VvV9yAHk5oXfUiyGHr6MZkQF+Zys5IhAlLi59/SbKQTrBD7MCvxOU7
         TyL0UBALmEoDq1yUrqWEA==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:
        content-transfer-encoding:x-system-of-record;
        b=gkv/aiwSMz5xDx50TXFWA8HSQOJ2DGyD4v8G8HKKERsGSotU2Gbv8bonowI763fSn
        MZdVfaxg49XiaD7hWL+Tg==
Received: from gxk27 (gxk27.prod.google.com [10.202.11.27])
        by wpaz33.hot.corp.google.com with ESMTP id p7VDlGiC028838
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 31 Aug 2011 06:48:36 -0700
Received: by gxk27 with SMTP id 27so531891gxk.15
        for <linux-mips@linux-mips.org>; Wed, 31 Aug 2011 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZrCz11e5i1iVUoGW7conRypgoled8TkV6Tat4Kf0Q30=;
        b=OOuACS6T+PjSzG0iBbS7FeIsg8M0qoUm2A+BgCoF+v/tOHeKT4VEYAYl7CMy+aiSEq
         V8G9853cdviwf8X8sEBQ==
Received: by 10.151.25.6 with SMTP id c6mr310855ybj.213.1314798516252;
        Wed, 31 Aug 2011 06:48:36 -0700 (PDT)
Received: by 10.151.25.6 with SMTP id c6mr310841ybj.213.1314798516112; Wed, 31
 Aug 2011 06:48:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.48.2 with HTTP; Wed, 31 Aug 2011 06:48:16 -0700 (PDT)
In-Reply-To: <4E5DBDB0.4070505@mips.com>
References: <1314349633-13155-1-git-send-email-dczhu@mips.com>
 <CAErSpo5PgXs4tuihh_JZCePzD8FWWzwp=-VHxFGCCuRKRKOYFQ@mail.gmail.com>
 <CAErSpo506Mz3QSxxdpbxyCUuZvqMTNL+fT5R81ivoj7cDTFyJg@mail.gmail.com> <4E5DBDB0.4070505@mips.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 31 Aug 2011 07:48:16 -0600
Message-ID: <CAErSpo69wROKy-4jtFteeSTUSWXiX+qk7YQTvcotstCL=cjUdA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Pass resources to pci_create_bus() and fix MIPS
 PCI resources
To:     Deng-Cheng Zhu <dczhu@mips.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        dengcheng.zhu@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-System-Of-Record: true
X-archive-position: 31019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 23343

On Tue, Aug 30, 2011 at 10:50 PM, Deng-Cheng Zhu <dczhu@mips.com> wrote:
> Hi, Bjorn
>
>
> Thanks for your constructive review.
>
>> One logistical issue here is that the first patch touches several
>> architectures at once, which puts Jesse in a bit of a pinch.  If he
>> applies it, there's always the possibility that an arch patch will
>> conflict with it, which makes merging harder.
>
> In case the conflicts happen, the effort to resolve them should be
> trivial (a matter of an extra NULL argument), I suppose. Also, the odds
> of other incoming arch patches making a reference to pci_create_bus()
> should not be great.
>
>> It might be easier if, instead of changing the pci_create_bus()
>> interface, you added a new one (it could call pci_create_bus() then
>> replace the resources, so the implementation could still be mostly
>> shared.)  We already have a plethora of "create bus" methods
>> (pci_create_bus(), pci_scan_bus_parented(), pci_scan_bus()), but if
>> you added a pci_create_root_bus() or something similar, maybe we could
>> try to converge on it and obsolete the others.
>>
>> Then the first patch would touch only the PCI core, and the second
>> would touch only MIPS, which would make merging more straightforward.
>>
>
> Hmm.. Adding a wrapper of pci_create_bus() does leave other
> architectures alone for this merging. But before all of them converge on
> it (a long way to go), the wrapper is adding naming confusion to the
> PCI core. Personally I think the current low-level transparent change to
> pci_create_bus() is appropriate enough. Does anybody have comments?
>
>
> Deng-Cheng

Just to be clear, I'm fine with it either way, as long as Jesse and
the arch maintainers are OK with it.
