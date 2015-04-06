Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2015 15:06:02 +0200 (CEST)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33464 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008039AbbDFNGANcfQs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2015 15:06:00 +0200
Received: by wgin8 with SMTP id n8so26398582wgi.0;
        Mon, 06 Apr 2015 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HeWZv6QtjuZUmwl0oJpqsD8L/xg5t4tabUuuyZn4iYQ=;
        b=AQ2usgN/9Drg8bqlickWIdetfE0NvhxbJd9yCD7N0sy/gE/1HbCAxnCm74ul3R2hgB
         wGR6wBnJrzOGniTUU9tsTlk9y2+iFx3okCaYhWGZr7IwaqdavXLoSuUsvNErjYhdDtEU
         1mLorJciyhht/65536VDNeXwkJXOjAviLqhJELIqYHpONd26oLNg7V9Sh7TVQLLlexYX
         ZYxItEmDWqTqGfRsqqRebXP1qh2Lw3/lpWslEA+9nfaswcPNDY6g33u16N4OfY0p/L06
         n1csamcZDAbwLUfYX+NoIARwxvCNXDKqK7xec18tZvQ/p/U0xoVicvQ6TubmOkNniGWu
         pvtA==
X-Received: by 10.180.74.238 with SMTP id x14mr37594610wiv.81.1428325553836;
 Mon, 06 Apr 2015 06:05:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.139.21 with HTTP; Mon, 6 Apr 2015 06:05:33 -0700 (PDT)
In-Reply-To: <CAErSpo4cw2MSPmrur_QFMwnH01qf0XMfBEAyZ2f+HrUOGEXyjw@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org> <20150403193234.GD10892@google.com>
 <20150403205201.GF10892@google.com> <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
 <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com>
 <CAL_JsqJyH==8OtkcU8_P4_47U6qe6FYqj-WUZ20_Y+iC_OF4_w@mail.gmail.com> <CAErSpo4cw2MSPmrur_QFMwnH01qf0XMfBEAyZ2f+HrUOGEXyjw@mail.gmail.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Mon, 6 Apr 2015 08:05:33 -0500
Message-ID: <CAL_JsqLhteW8p1B7DrRzWzC_0UNYOKAU-yu2UhWRcb8PZ9AEnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
To:     Bjorn Helgaas <bhelgaas@google.com>
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
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On Sat, Apr 4, 2015 at 10:25 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Apr 4, 2015 at 2:48 PM, Rob Herring <robherring2@gmail.com> wrote:
>> On Sat, Apr 4, 2015 at 7:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>>> I think there's still an unresolved question about the OF parsing code.
>>
>> Got a pointer to what that is? I'll take a guess. Generally, we make
>> the parsing code independent of the kernel addr sizes and use u64
>> types. The DT sizes and kernel sizes are not always aligned. For
>> example, an LPAE capable platform running a non-LPAE kernel build.
>
> Yep: http://lkml.kernel.org/r/1427857069-6789-3-git-send-email-yinghai@kernel.org
>
> Yinghai made a change to the sparc OF parsing code.  The question is
> whether a similar change should be made to clones of that code (two
> others in arch/sparc, one in arch/powerpc, and one in drivers/of).

Yes, it appears to me that is needed. At least the drivers/of/ code
does not distinguish 32 and 64 bit ATM.

Rob
