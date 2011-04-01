Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2011 19:39:53 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:43934 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491820Ab1DARju (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Apr 2011 19:39:50 +0200
Received: by fxm14 with SMTP id 14so3476288fxm.36
        for <multiple recipients>; Fri, 01 Apr 2011 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/0MopB6npfGyCIIV+OXd0IFXS0quGBU7+0s0bLzeNkE=;
        b=Siuq+Ti0V/1gch32JrM91FVBFPqoFRC4Iot4SfAXXh/2YHVSxBB2WsZitfUdWetGvU
         wcmKhPnTXDxwOmnn9l8hBkJNSvmA6mQuxdWDDh+Bjpa2lZIkAMOwPnQHTA+7t0G7vGZH
         IwyxY5cV9f7hwZm5wj87jIaQngNXfuHbS2sqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MlqwM0ubKJnoNeh8vO9pILfiLZ+soduk9YweDrizIrd/X/Jv77q/LkIoNA6b4izsMU
         lZxf2q/9+4S3/hKX2aCRy6iyK4dPibEf3UDmbtNui5pKOik6TICWQQEtW+tPGoSCmamk
         QDGtHt5yZLmd2rMt1dT0lCJk7rJmahIAl2Yw0=
MIME-Version: 1.0
Received: by 10.223.64.201 with SMTP id f9mr4541348fai.102.1301679117055; Fri,
 01 Apr 2011 10:31:57 -0700 (PDT)
Received: by 10.223.145.131 with HTTP; Fri, 1 Apr 2011 10:31:57 -0700 (PDT)
In-Reply-To: <4D9603D8.2010709@caviumnetworks.com>
References: <c300b67a7a723369872c0b9a023d0b2e@localhost>
        <4D9603D8.2010709@caviumnetworks.com>
Date:   Fri, 1 Apr 2011 10:31:57 -0700
Message-ID: <AANLkTimcCuhtEguCZsVmfAaCDYrGOeJB7+O=EziJ59rR@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Kernel crashes on boot with SPARSEMEM + HIGHMEM enabled
From:   Kevin Cernekee <cernekee@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Michael Sundius <msundius@cisco.com>,
        David VomLehn <dvomlehn@cisco.com>,
        Dave Hansen <dave@linux.vnet.ibm.com>,
        Andy Whitcroft <apw@shadowen.org>,
        Jon Fraser <jfraser@broadcom.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Apr 1, 2011 at 9:56 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> I think this may do the same thing as my patch:
>
> http://patchwork.linux-mips.org/patch/1988/
>
> Although my patch had different motivations, and changes some other things
> around too.

I noticed that some of the other architectures have started using the
<linux/memblock.h> APIs for memory setup.  Do you think this would be
useful on MIPS, as part of a larger refactoring of bootmem_init() ?

What I liked about Michael's fix was that it is simple and
straightforward enough to meet the stable tree criteria.  Long term it
would probably be a good idea to clean up the memory init code and get
rid of the cut&paste "for" loops.
