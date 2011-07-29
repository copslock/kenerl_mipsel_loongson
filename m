Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2011 08:32:18 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:40414 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490989Ab1G2GcM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jul 2011 08:32:12 +0200
Received: by qyg14 with SMTP id 14so3116537qyg.15
        for <multiple recipients>; Thu, 28 Jul 2011 23:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=G4EQQVOW2eNEtwKYqUrxNukflR0qNTTbikvfLejRC90=;
        b=xTY2UITi7nECIMenYp6KGRktGtPmHtlHwrRZ5Anpw/DPRN/0/UGjiT5Y1dUdOZ9Uv2
         OiPS95T9bw4tpZW3uZzTuq5AuKuE7Zo9OR6uaII4FI71oIG1zt2xSfEsPNkDote6OsCI
         A/sGVM8TnBttT83RncqePPzljUuBN+5Z4ftpY=
MIME-Version: 1.0
Received: by 10.229.127.144 with SMTP id g16mr726122qcs.13.1311921126509; Thu,
 28 Jul 2011 23:32:06 -0700 (PDT)
Received: by 10.229.192.8 with HTTP; Thu, 28 Jul 2011 23:32:06 -0700 (PDT)
In-Reply-To: <20110728115330.GA29899@linux-mips.org>
References: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
        <1311852512-7340-2-git-send-email-dengcheng.zhu@gmail.com>
        <20110728115330.GA29899@linux-mips.org>
Date:   Fri, 29 Jul 2011 14:32:06 +0800
Message-ID: <CAOfQC9-Z31SSv8agzxZ_hvPOOLY8p0F6yc1=o-QPbDwbNxavTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: make pci_claim_resource() work with conflict
 resources as appropriate
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     jbarnes@virtuousgeek.org, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21420

I noticed that at 79896cf42f Linus changed the function from insert_resource()
to request_resource() (and later evolved into request_resource_conflict()) and
he explained the reason. So, in the NIC's case, the problem is that in
pci_claim_resource() the function pci_find_parent_resource() returns the root
(0x0-0xffffff) rather than the MSC PCI I/O (0x1000-0xffffff). So
request_resource_conflict() for PCI quirks (0x1000-0x103f and 0x1100-0x110f)
will simply return an error, coz these 2 regions 'conflict' with MSC PCI I/O.
Instead, insert_resource_conflict() will also find the collisions but register
quirks as children of MSC PCI I/O (is this supposed to be correct?) and return
a success.


Deng-Cheng

2011/7/28 Ralf Baechle <ralf@linux-mips.org>
>
> On Thu, Jul 28, 2011 at 07:28:31PM +0800, Deng-Cheng Zhu wrote:
>
> > In resolving a network driver issue with the MIPS Malta platform, the root
> > cause was traced into pci_claim_resource():
> >
> > MIPS System Controller's PCI I/O resources stay in 0x1000-0xffffff. When
> > PCI quirks start claiming resources using request_resource_conflict(),
> > collisions happen and -EBUSY is returned, thereby rendering the onboard AMD
> > PCnet32 NIC unaware of quirks' region and preventing the NIC from functioning.
> > For PCI quirks, PIIX4 ACPI is expected to claim 0x1000-0x103f, and PIIX4 SMB to
> > claim 0x1100-0x110f, both of which fall into the MSC I/O range. Certainly, we
> > can increase the start point of this range in arch/mips/mti-malta/malta-pci.c to
> > avoid the collisions. But a fix in here looks more justified, though it seems to
> > have a wider impact. Using insert_xxx as opposed to request_xxx will register
> > PCI quirks' resources as children of MSC I/O and return OK, instead of seeing
> > collisions which are actually resolvable.
>
> This used to work in the past; do you know which commit broke the resource
> handling for the NIC?
>
>  Ralf
