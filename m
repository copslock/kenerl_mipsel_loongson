Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 22:28:17 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:34425
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993961AbdFZU2KU9VcH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jun 2017 22:28:10 +0200
Received: by mail-pg0-x244.google.com with SMTP id j186so1506594pge.1
        for <linux-mips@linux-mips.org>; Mon, 26 Jun 2017 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to:to
         :to:to:to:to:subject:date:message-id:in-reply-to:references;
        bh=oQ186FrAwZwHrcWrwkdpQr3XHDp0umhRYR0YnvbrXmw=;
        b=tqLOCXxM3lwCRGWA/Z/ZU3X0gmrx3XuaCXaAb+fiXfT3SjaknjmKg+V5yLZSeHiy5H
         LiwwjYckC/5ap0nToDS2GDzKjzZGzzj9P6CmPxmGTPBwWMVryTDQSV8rKtPo7mZ7IhNU
         pgADJMxfiMS/IhSUgXzQMvaIJRCLALZPbMk0yTfBoNp5Clw5E2IJWeVq/o+RoYIlFvbq
         N2fFLIcIn8OeAXD5AmwqGnOZXL5c1xGL5MGLACyfiQuOvGHeMA29fHjYRAhU7AJInVEg
         3qBqIzbLpP1dQlLMyeTm3GLITErzFsrxdPOOAZeqpGxYSRGn1uVi+wJEe65mDLuyN0Ly
         d5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:to
         :to:to:to:to:to:to:to:to:to:to:to:subject:date:message-id
         :in-reply-to:references;
        bh=oQ186FrAwZwHrcWrwkdpQr3XHDp0umhRYR0YnvbrXmw=;
        b=IjlUoa04vC/pw1dy1HZ3p8fRi6OANsI0J1utdKuvnNssQXjA0raZKmTEp4mjVUL1b1
         LSs4lK6GLJFmDws4/a/DTR4Rb++O10lsoXXmzKjqmg2IANUFufTEYrYVT/Sccd/TCBie
         wf1oKTQcoRMaTZEf7/3+h8e+44rax+NPu0udKoAxH7xyBjOdEZoaL8RD1YWI5t6vbCPi
         SSxhf96rVAeiF7hlD9P7ZbLAQhSqFO0s6lHjSpInzPmiwS+7/o3oksZuX/kwkSp708Ri
         6PUKrV/MO+EhvVGQRMO0PCcQyhWrFkQcly96zr0sYKbKh1lN+P1Z1pV2xxYpHL8PuQVE
         nHXw==
X-Gm-Message-State: AKS2vOxder7FW8/UwSxfJ9dt2tNgJF5Oh7fZCxDJCZ9DsckgSxvmXW2d
        /6oxhm64Vgq1ow0j
X-Received: by 10.98.236.67 with SMTP id k64mr1802553pfh.236.1498508884434;
        Mon, 26 Jun 2017 13:28:04 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id c22sm1702012pfl.97.2017.06.26.13.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 13:28:03 -0700 (PDT)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rth@twiddle.net
To:     ink@jurassic.park.msu.ru
To:     mattst88@gmail.com
To:     vgupta@synopsys.com
To:     linux@armlinux.org.uk
To:     catalin.marinas@arm.com
To:     will.deacon@arm.com
To:     geert@linux-m68k.org
To:     ralf@linux-mips.org
To:     ysato@users.sourceforge.jp
To:     dalias@libc.org
To:     davem@davemloft.net
To:     cmetcalf@mellanox.com
To:     gxt@mprc.pku.edu.cn
To:     bhelgaas@google.com
To:     viro@zeniv.linux.org.uk
To:     james.hogan@imgtec.com
To:     linux-alpha@vger.kernel.org
To:     linux-kernel@vger.kernel.org
To:     linux-snps-arc@lists.infradead.org
To:     linux-m68k@lists.linux-m68k.org
To:     linux-mips@linux-mips.org
To:     linux-sh@vger.kernel.org
To:     sparclinux@vger.kernel.org
To:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Add and use PCI_GENERIC_SETUP Kconfig entry
Date:   Mon, 26 Jun 2017 13:27:55 -0700
Message-Id: <20170626202756.22220-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <CAMuHMdXSrfbSX2de2q35Hj6vQwi+sr23M1LEg82JL+FyLq4OJw@mail.gmail.com>
References: <CAMuHMdXSrfbSX2de2q35Hj6vQwi+sr23M1LEg82JL+FyLq4OJw@mail.gmail.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@dabbelt.com
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

>On Mon, Jun 26, 2017 at 7:39 AM, kbuild test robot <lkp@intel.com> wrote:
>> [auto build test WARNING on linus/master]
>> [also build test WARNING on v4.12-rc6]
>> [cannot apply to next-20170623]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Palmer-Dabbelt/pci-Add-and-use-PCI_GENERIC_SETUP-Kconfig-entry/20170626-043558
>> config: m68k-allnoconfig (attached as .config)
>> compiler: m68k-linux-gcc (GCC) 4.9.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=m68k
>>
>> All warnings (new ones prefixed by >>):
>>
>> warning: (M68K) selects PCI_GENERIC_SETUP which has unmet direct dependencies (MMU)
>
>I can't seem to find this dependency of PCI_GENERIC_SETUP on MMU?

It looks like M68K only includes the PCI Kconfig entry when MMU is enabled.  I
moved the select around a bit and it builds the config that was failing for me.

The updated patch is threaded.
