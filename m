Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jul 2013 17:41:24 +0200 (CEST)
Received: from mail-ob0-f182.google.com ([209.85.214.182]:39338 "EHLO
        mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823081Ab3GFPlVzPhA9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jul 2013 17:41:21 +0200
Received: by mail-ob0-f182.google.com with SMTP id va7so4042116obc.27
        for <linux-mips@linux-mips.org>; Sat, 06 Jul 2013 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/uyHRuK5L8fmDukxCJcyPWToHS124B0Q3+hrMl4YGUM=;
        b=OnAPippALWPuszXthIIJTvFQMyvO9v4N81IgbLwCiEMR4xQdgi/qTaWzhUVS0e+eOT
         MsR/sUXwoe0f/a3K56nx4vVVBN1PwQgkEn/sLMe83zGjxSlO7wjJBPn9pcnDC282arY5
         TA4r2zvnOJEp6IpalnJ5UGws8mOepVtTD6E7zq/DpphJdngpqXFNNLzVm/Bh1jCoVD2I
         YLpwQoj6zZn6XMIhIEwSWoSGpsN1rShQS9HeJrQil/GbJsZSF3E4Jt1ZURxOt7dMaLom
         m+kgW+IEbDThdyrgyf4MJCwqLtzD0FdphOyZ9NnEEbbgnFNtyybfqif6ByO7XeqNka7L
         918g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=/uyHRuK5L8fmDukxCJcyPWToHS124B0Q3+hrMl4YGUM=;
        b=IyTdDTmzsynlzUQGl/KYEepumtspBE/vVM2CCxO6bYxceMaWjvY1vabHmQ0gpvfT8Y
         w/bHPaEr3M6/3eT1YiXau3+5vLR+HokKbQljNfHmetERsSSEPKTS1HM0gKvbJUqjuldb
         JPbR8xPsvAa5PDtH42tM11uHgl4Mmr8EhBW31RHiymLuUzuqshHIjIEZPib+vbjkyPrQ
         zkMr0J4imuWQ4PY7kEkA4PGN3GOPhoyWSung8qxwNjPgyDLqOW2ajyGhuuViM8y/5PJ0
         zsKZKTRgt+SK/m6oqxDu8ciNch0TitXZUIr2vaGZNZaRHgaPHS880/NFVbU2cnNAX/Aw
         iK+Q==
X-Received: by 10.182.87.170 with SMTP id az10mr15589798obb.10.1373125275397;
 Sat, 06 Jul 2013 08:41:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.75.99 with HTTP; Sat, 6 Jul 2013 08:40:55 -0700 (PDT)
In-Reply-To: <20130706135433.GL2569@titan.lakedaemon.net>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo73iSBg+SYwZLea0qdXD1uVc3+Vacd8Tg4CU92vLG=2AQ@mail.gmail.com>
 <20130705234501.1341f52e@skate> <20130706135433.GL2569@titan.lakedaemon.net>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat, 6 Jul 2013 09:40:55 -0600
Message-ID: <CAErSpo4uN2MifYHbFiUfQ+6TE-hBkbWYdnAvabj8jCTOd5g+1A@mail.gmail.com>
Subject: Re: [PATCHv4 03/11] pci: remove ARCH_SUPPORTS_MSI kconfig option
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rob Herring <rob.herring@calxeda.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maen Suleiman <maen@marvell.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQl4saGmYFgdAlF7y6LJjtOVD9SexV2iUjGxDxJbZZhK8HrsFqV6eFAHl2WJre8aKz10358qKLz6WZo2eQlewxOsVz30dySb9Oy4b8ypl4PGnR2k+XewcwOVV6saqEFaHD1YkR+P5+5lr70ynjwgLm61Nzh1uhfnWrE7s6FFFRpO+EsU6dXL3TF2+BDx5YVUsRwHfCWZ7XCzTM0Hg8MiKwQQUcLCYg==
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Sat, Jul 6, 2013 at 7:54 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Jul 05, 2013 at 11:45:01PM +0200, Thomas Petazzoni wrote:
>> Dear Bjorn Helgaas,
>>
>> On Fri, 5 Jul 2013 15:37:33 -0600, Bjorn Helgaas wrote:
>>
>> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> >
>> > Again, please update the subject line to "PCI: Remove ..."
>> >
>> > I doubt that you'll get explicit acks from all the arches you touched,
>> > but I think it's reasonable to put at least patches 2 & 3 in -next
>> > soon after v3.11-rc1, so we should have time to shake out issues.
>>
>> Sure. Which merge strategy do you suggest for this patch series, which
>> touches a number of different areas, and has some build-time
>> dependencies between the patches (if needed, I can detail those build
>> time dependencies to help figuring out the best strategy).
>
> If we end up handling this the same as the of/pci & mvebu-pcie series
> (whole series through mvebu -> arm-soc) I can have it up in -next within
> a few days of -rc1.  Just let me know.

That sounds fine with me.  I don't think it's worth trying to split
out the drivers/pci stuff and trying to coordinate it going through
different trees.
