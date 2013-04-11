Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 19:35:45 +0200 (CEST)
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36519 "EHLO
        mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825884Ab3DKRfkjXH6T convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Apr 2013 19:35:40 +0200
Received: by mail-ob0-f175.google.com with SMTP id va7so1596347obc.20
        for <linux-mips@linux-mips.org>; Thu, 11 Apr 2013 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=git+IJd5xrFCgYAOM5u0RtfBIrwTLnKkM3aPC1wsFDY=;
        b=aAPn6VSASKyGii9hOhNCJFIh++eGCGnlsXat8Q1Rv9wEDGm7mXZvjW1n+VdSeFhsg/
         jpc8JOGYygRekw3lLbnjo3Xv1gdC7apEqpLu8Xgy6AlFT7hRv+n5iThgDYN74+wm7uxm
         N357fDc3VOZGVtjAS9gqeulNkAgRk8pcy6r08qx6e0WjXNITY82BZfepPK9lmnntcwl7
         /+klgtyEYvFHCoWT/BhT1SuqazcPr88eujyw4Ak1yGJ6EmrT0iMOPJKWeivVwOfou0r5
         Paj07w05ejIMnCf49W47JIwcCXyYEtOlqUbMj7pyMWvVhty6+db7Mq04hJ/EeB9vRtAb
         Udqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=git+IJd5xrFCgYAOM5u0RtfBIrwTLnKkM3aPC1wsFDY=;
        b=hXMQtlYYAsjT4sUko5KM6ADqrC+2zng1FqzRj375pCglGr328e+E1sQ9IwHCYqJ3WA
         2CqYlfVC5dHePSSU9E4HCTO0Nex76jw3LjyUYpJKX3nHbhDDO6LNvt8ndGUPXtPZv8hk
         +HDI8ToH30hCUW54J1DFtzb4TWq93SPrrXRb3lgvRmbR4Nyj5q5Q4MxyAnU9666gXhaL
         KuOfbSNIBFIvRUF5m5GEERXuvKrEFJfMxbwNaQn6SXOO2mtznioWL6ugcDwfOZdVXQQg
         K/5c5D2KHLIlhtsTcVA571kqtQKQQgYOfoGOqopydI+iPTXhlN2+6tNYXf5BKpUp/hkT
         vj7A==
X-Received: by 10.60.123.116 with SMTP id lz20mr2645778oeb.94.1365701734293;
 Thu, 11 Apr 2013 10:35:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.73.163 with HTTP; Thu, 11 Apr 2013 10:35:14 -0700 (PDT)
In-Reply-To: <5166F39C.1050907@openwrt.org>
References: <1365098483-26821-1-git-send-email-juhosg@openwrt.org>
 <1365098483-26821-2-git-send-email-juhosg@openwrt.org> <CAErSpo4ih-Kgp4LxX1MDodac-eoPo=Mu1d6ex8oNnaEEc_GQnw@mail.gmail.com>
 <5166F39C.1050907@openwrt.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 11 Apr 2013 11:35:14 -0600
Message-ID: <CAErSpo454_bkXa1Uy70_dv9SSnofxYNPyxR=W7X-QmaxxGNO5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: implement pcibios_get_phb_of_node
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Gm-Message-State: ALoCoQlSmNfIUJPp6shHsCDIdsQ+l10X6keO2u2F2uUDzov8c6zb6nf7ZPfZUVEG4Sh3Lcb5Z0zzFBaBUzWumyErWmS9Y+Fx1P3ULR7LUrwYSiM1dzqc9S6OmqQsO6DX+UbDUc0vgiGKhqeu8tc9f5BRnFmC4CKCy9HgsxxqvXUE2CzMxRHqf7ZB+HPN85DEp4+pLTvQQMeGWzM6kaDcbZxqUoaLMurdGw==
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36081
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

On Thu, Apr 11, 2013 at 11:32 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
> 2013.04.10. 18:31 keltezéssel, Bjorn Helgaas írta:
>> On Thu, Apr 4, 2013 at 12:01 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
>>> The of_node field of the device assigned to a
>>> PCI bus is used during scanning of the PCI bus.
>>> However on MIPS, the of_node field is assigned
>>> only after the bus has been scanned.
>>>
>>> Implement the architecture specific version of
>>> 'pcibios_get_phb_of_node'. Which ensures that the
>>> PCI driver core will initialize the of_node field
>>> before starting the scan.
>>>
>>> Also remove the local assignment of bus->dev.of_node,
>>> it is not needed after the patch.
>>>
>>> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
>>
>> I removed the __weak annotation from include/linux/pci.h and applied
>> this patch to my pci/gabor-get-of-node.
>
> Thank you!
>
>> Give it a try and make sure
>> it solves your problem.  If so, and Ralph approves, I can push both
>> for v3.10.  It should appear at
>> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/gabor-get-of-node
>> soon.
>
> I have tried your patch on top of 3.9-rc6. The resulting kernel uses the
> architecture specific implementation, and it runs fine.
>
>   $ mipsel-openwrt-linux-readelf -s arch/mips/pci/built-in.o \
>     drivers/pci/built-in.o vmlinux.o | grep pcibios_get_phb_of_node
>       93: 0000046c    12 FUNC    GLOBAL DEFAULT    2 pcibios_get_phb_of_node
>     1433: 00012a2c   104 FUNC    WEAK   DEFAULT    2 pcibios_get_phb_of_node
>    31863: 001d4dbc    12 FUNC    GLOBAL DEFAULT    2 pcibios_get_phb_of_node
>   $
>
> For completeness, I have compiled it for X64 and for powerpc as well. I did not
> try to run these kernels, but the output of readelf seems to be ok:
>
>   $ readelf -s arch/x86/kernel/built-in.o drivers/pci/built-in.o vmlinux.o | \
>     grep pcibios_get_phb_of_node
>     2761: 000273a0    86 FUNC    GLOBAL DEFAULT    1 pcibios_get_phb_of_node
>     1705: 00018770    77 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
>    60364: 000278a0    86 FUNC    GLOBAL DEFAULT    1 pcibios_get_phb_of_node
>   $
>
>   $ powerpc-openwrt-linux-readelf -s arch/powerpc/kernel/built-in.o \
>     drivers/pci/built-in.o  vmlinux.o | grep pcibios_get_phb_of_node
>     1002: 0000ca28    12 FUNC    GLOBAL DEFAULT    1 pcibios_get_phb_of_node
>     1485: 0001453c    88 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
>    28959: 0000d598    12 FUNC    GLOBAL DEFAULT    1 pcibios_get_phb_of_node
>   $
>
>> Or if you prefer, you can take them through the MIPS tree.
>
> Either is fine.

Thanks for checking these out!  I put them in my "next" branch and
pushed it, so they should appear in v3.10.

Bjorn
