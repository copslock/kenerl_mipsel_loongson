Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Apr 2016 00:54:23 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34367 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027356AbcDWWyVg9CaH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Apr 2016 00:54:21 +0200
Received: by mail-oi0-f67.google.com with SMTP id b10so18800251oig.1
        for <linux-mips@linux-mips.org>; Sat, 23 Apr 2016 15:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=O9AnsMruC7CL6s6Po3ZnrhxTlgk3QBPH2DArvlUIhbI=;
        b=i6CUw1Koe0vI6lBHRAJDGx/gqLXv7fEFYf7Oua64J5c0xuest+KNGTH8z1yuNYVDva
         E8S1d8gCa6LsRVSuw0z25RSUc82KIyydsYdT+1SgWUojgBhDOjBCTt/V5NIHMtkUsSDL
         aME8dxDbfpjxG8D4vlDApNSPj2Runm7txRAaaVIcPcgqSr9B48pzypIb3nk0w7Mb2FK9
         Zm4D66m49jhP5aGrDHFTI4pXy2xxieMRYpYGiQDGJP9tNW+FvqmNnWufkX8xdXYJQVyR
         0kPjv3CO8onJSxYlIn3LYncGkgIyrTHiTHCRm88Z5lj/hpMCJB+dKUPrsH/bF9AQ5bG3
         UW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=O9AnsMruC7CL6s6Po3ZnrhxTlgk3QBPH2DArvlUIhbI=;
        b=mJpcgK5+NrVCV0CdOE4yUrnrPwLstSBUpDd9C9kVdH5O1pFjfIAgfJDdOxIeWJYX17
         tmutSJ58OMnf1FAtNFvhryMMkBSHBxsQN/wtTVNQRbdN2GJKIcD8QYxetntonnyqpIPt
         Ti/femF4uV/1nCMRWLTDp69ruLCYuZfChvP8tTVooxNVXWLfN3o+LYJ4rCx1tR4AWMxP
         5JZj7F6LYOHCL2Z1tT7nIXdHr/rocyzg2sDivh4gK+c/tMz7ZhAcu4JzGrShvEDxZgIu
         ge1v8h2JMkO8YUaTGVEFSbns3nqee4Oc9QzPETOci3wSrVTbZ52DOcDlDouabyK6xl4N
         Cq9g==
X-Gm-Message-State: AOPr4FXUAxOA5f3ClNPfOp9ZbUH3FQT2i+ypI9y6lB0/HBvgw55bOLt5In8wtn3VCUgQYpu5qy/BhZrlhLIdig==
MIME-Version: 1.0
X-Received: by 10.157.34.14 with SMTP id o14mr12836995ota.63.1461452055689;
 Sat, 23 Apr 2016 15:54:15 -0700 (PDT)
Received: by 10.157.44.130 with HTTP; Sat, 23 Apr 2016 15:54:15 -0700 (PDT)
In-Reply-To: <20160422130705.GD7202@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
        <20160420182909.GB4044@potion>
        <20160421132958.0e9292d5@bahia.huguette.org>
        <20160421152916.GA30356@potion>
        <CANRm+Cwh__btdC4e4t+jYqHsafL6xff6t4eukxT=EmwVLYvrMA@mail.gmail.com>
        <20160422130705.GD7202@potion>
Date:   Sun, 24 Apr 2016 06:54:15 +0800
Message-ID: <CANRm+CxBUps+pKARfXse-s09Qrsc6pERNjBgVOjUBVCV+B2XPw@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
From:   Wanpeng Li <kernellwp@gmail.com>
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Greg Kurz <gkurz@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        kvm <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <kernellwp@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kernellwp@gmail.com
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

2016-04-22 21:07 GMT+08:00 Radim Krčmář <rkrcmar@redhat.com>:
> 2016-04-22 09:40+0800, Wanpeng Li:
>> 2016-04-21 23:29 GMT+08:00 Radim Krčmář <rkrcmar@redhat.com>:
>>> x86 vcpu_id encodes APIC ID and APIC ID encodes CPU topology by
>>> reserving blocks of bits for socket/core/thread, so if core or thread
>>> count isn't a power of two, then the set of valid APIC IDs is sparse,
>>
>>              ^^^^^^^^^^^^^^^^^^^
>>              ^^^^^^^
>> Is this the root reason why recommand max vCPUs per vm is 160 and the
>> KVM_MAX_VCPUS is 255 instead of due to perforamnce concern?
>
> No, the recommended amout of VCPUs is 160 because I didn't bump it after
> PLE stopped killing big guests. :/
>
> You can get full 255 VCPU guest with a proper configuration, e.g.
> "-smp 255" or "-smp 255,cores=8" and the only problem is scalability,
> but I don't know of anything that doesn't scale to that point.
>
> (Scaling up to 2^32 is harder, because you don't want O(N) search, nor
>  full allocation on smaller guests.  Neither is a big problem now.)

I see, thanks Radim.

Regards,
Wanpeng Li
