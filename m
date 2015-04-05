Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Apr 2015 05:25:29 +0200 (CEST)
Received: from mail-qc0-f169.google.com ([209.85.216.169]:34832 "EHLO
        mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007518AbbDEDZ2OMg2a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Apr 2015 05:25:28 +0200
Received: by qcbii10 with SMTP id ii10so1838610qcb.2
        for <linux-mips@linux-mips.org>; Sat, 04 Apr 2015 20:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YhDwjwGA710R3SHmXiXEGOpwkBb693PSYEbv6rVth/4=;
        b=Cs4yyWgF+1aExIclB698M4ow0Do83zZoKUgoc/OSblRqCoq0tr7+0PvMXffXvFELFF
         EzUkzj/0eEnW1OthahXxTG3t/C9MyGC8IV44KNTirq2cwnl/E/MpW/gY0KBdRNL8OLeC
         l1dAl7X6fHIZrG+vmI4veBIUbsYzot7RS3ZcNYocQy9emQhUip3ni2ZaYjVz7jh+wLrR
         sJ2f9mk8CXrR7tH1a7fHZfcw7c4y7xs1JANfSu0xNdaqF1y3tHtYpfvky2c8r5lpl4iP
         VF/K6FZ5i/1qiz8BLtG06sDsRB7cIh5nVLnzmfwRi8Fkur2nsutI6JENq3nLLm/MDFRe
         fzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=YhDwjwGA710R3SHmXiXEGOpwkBb693PSYEbv6rVth/4=;
        b=ZaV13WurjnFdKYBDw7ESljvDXLavIHFdI1oyLB1DSrPc8DDLRwAASe5KFahBlrcs81
         a8rYwoaFOr6G0AjCVw8U5r61NZexhnh6aU/hixY71z+++6z25Tvdm7LV4INApwrNGEvc
         rQrkadZvZVU6595Gsoj93H2snzttoDgWFX9LzTiqY99TqPp0J/GB4AAX1FYMjZhJkUAs
         TZdO99+P4X0kPz6+HgPuyyFdLOOhFyGG4lSAX0Y+dQ+qDU86EAkS6mP6nWZFAsTRYEpi
         lX5PkZsrMWkXNPuAdojnIlHiA1Qte3eammnPYZotUsJmkMA8xQEs/ozOyzdbxjhwwk9C
         0Zuw==
X-Gm-Message-State: ALoCoQnKtYUiDjba4ttPnTxlPmFn2W6Agxxx1BFhW5Api1+gK9gGi46z1WqWXkbLe1kCqroztrKu
X-Received: by 10.140.18.175 with SMTP id 44mr10327092qgf.80.1428204323541;
 Sat, 04 Apr 2015 20:25:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.163.78 with HTTP; Sat, 4 Apr 2015 20:25:03 -0700 (PDT)
In-Reply-To: <CAL_JsqJyH==8OtkcU8_P4_47U6qe6FYqj-WUZ20_Y+iC_OF4_w@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org> <20150403193234.GD10892@google.com>
 <20150403205201.GF10892@google.com> <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
 <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com> <CAL_JsqJyH==8OtkcU8_P4_47U6qe6FYqj-WUZ20_Y+iC_OF4_w@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat, 4 Apr 2015 22:25:03 -0500
Message-ID: <CAErSpo4cw2MSPmrur_QFMwnH01qf0XMfBEAyZ2f+HrUOGEXyjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
To:     Rob Herring <robherring2@gmail.com>
Cc:     Yinghai Lu <yinghai@kernel.org>,
        David Ahern <david.ahern@oracle.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Miller <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46782
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

On Sat, Apr 4, 2015 at 2:48 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Sat, Apr 4, 2015 at 7:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>> I think there's still an unresolved question about the OF parsing code.
>
> Got a pointer to what that is? I'll take a guess. Generally, we make
> the parsing code independent of the kernel addr sizes and use u64
> types. The DT sizes and kernel sizes are not always aligned. For
> example, an LPAE capable platform running a non-LPAE kernel build.

Yep: http://lkml.kernel.org/r/1427857069-6789-3-git-send-email-yinghai@kernel.org

Yinghai made a change to the sparc OF parsing code.  The question is
whether a similar change should be made to clones of that code (two
others in arch/sparc, one in arch/powerpc, and one in drivers/of).

Bjorn
