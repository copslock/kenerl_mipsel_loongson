Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 00:36:44 +0200 (CEST)
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33554 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034973AbcFIWgmxpMBr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2016 00:36:42 +0200
Received: by mail-vk0-f65.google.com with SMTP id z65so8634924vka.0
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uzhfRY6wmIeGAgc7fm0h+K3W90FAiccozhvWM7hWYL8=;
        b=ZVxmQxPgSWVr+YPwENH2TjXInN1R2cSmopjsZS/UavLm+O7RL8bDGwoS1OpD+I0ce8
         RVOUZWcQAK0k4BgNbQuIVLxHeHWHMUrdTqF8WOrtGk0wPfJNlsoM7djZLvjRTfZKiiVv
         9Qw5RdT8F4P08ScHnzMR84G79Vw1peszTUmUyxUBFkhRiqMelRMgChwqlu+ElM99RXYX
         0iwW+eryaQjHaU/nX8BvE7p1lPboHw3iXQVcvkxZrp3hyPYXzVCSGQ55sdAxKDlwso8D
         yN1Vy1jzWJoehJZxnh6fBz4v/iqNlmTRj3bjR2HZ6f+jAK4Hi5jJrOIeNsPzaoa3iJP0
         jmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uzhfRY6wmIeGAgc7fm0h+K3W90FAiccozhvWM7hWYL8=;
        b=XTEzu5sLd8hytVzrI1HuhzDJrMc//XuAFnd8wrZmQa2147Cyp+XrMxv3R5gTE3MNwA
         hX5KM96+dvxFhXhePuaCqQ1sOw3nIcEk17j60BAaScqwA9esAe+ZKhqVrkjjEDnjrOOg
         NGGof3p51QaQEXtybwiNhkyiQjghz/Zby3/W2gUwR78KITsfHOtitTCeG0/wt++dcoUm
         0keicRSxnmuWhvO4trH2YXkUHLJ+U6GH34RuvAflXgeXUzA+/vuq4qwbhbpCkbEUEmuu
         22c8dlPpwD5IHk9G74xPre0pZPoOEvGOUZebdbpDkDeYIjT9VnrXQnksH1Z5KO/ynD4k
         WFVw==
X-Gm-Message-State: ALyK8tJZ2CwAKES47jcwRXpPK/fQPHkbZmuGWEkaPiS68wytxCrfPMgIKWGrD5wviGZRyw214Mdaxq6M0r883w==
X-Received: by 10.176.0.145 with SMTP id 17mr5382649uaj.103.1465511796956;
 Thu, 09 Jun 2016 15:36:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.81.11 with HTTP; Thu, 9 Jun 2016 15:36:35 -0700 (PDT)
In-Reply-To: <CAE9FiQWw0pUB=1iDrX_1qyMFAUGQidSaV7CPc0aNb2CzPB-fZw@mail.gmail.com>
References: <20160604000642.28162-1-yinghai@kernel.org> <20160604000642.28162-2-yinghai@kernel.org>
 <20160608210322.GA4248@localhost> <CAE9FiQXPmG6UYYGHG52_i8vaBJ5yPm6Z4Zfx_BhQxVhyWC5fnw@mail.gmail.com>
 <CAE9FiQWw0pUB=1iDrX_1qyMFAUGQidSaV7CPc0aNb2CzPB-fZw@mail.gmail.com>
From:   Yinghai Lu <yinghai@kernel.org>
Date:   Thu, 9 Jun 2016 15:36:35 -0700
X-Google-Sender-Auth: aUhhfSGFzPGPBgpOiPGl2btal5k
Message-ID: <CAE9FiQUNZ9xShfCHFvKobOJQ4zBfOrq_s=uYQAcR+YguigNjrQ@mail.gmail.com>
Subject: Re: [PATCH v12 01/15] PCI: Let pci_mmap_page_range() take extra
 resource pointer
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-cris-kernel@axis.com,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sh@vger.kernel.org,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <yhlu.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yinghai@kernel.org
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

On Wed, Jun 8, 2016 at 5:00 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jun 8, 2016 at 3:35 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
>> At the same time, can you kill __pci_mmap_set_pgprot() for powerpc.
>
> Can you please put your two patches and this attached one into to pci/next?
>
> Then I could send updated PCI: Let pci_mmap_page_range() take resource address.

Thanks for putting those patches in pci/resource branch.

I just re post updated for second patch.

[v12.update2,02/15] PCI: Let pci_mmap_page_range() take resource address
http://patchwork.ozlabs.org/patch/633399/

And the [v12 01/15] is not needed anymore.

patch3 to patch15 should still can be applied to pci/resource without problem.

Thanks

Yinghai
