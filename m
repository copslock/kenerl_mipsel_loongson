Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 19:45:04 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33848 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903458Ab2HQRo5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 19:44:57 +0200
Received: by lbbgf7 with SMTP id gf7so2143649lbb.36
        for <linux-mips@linux-mips.org>; Fri, 17 Aug 2012 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=Kd/JZBXbIX5coJ5LazkbyZsbv8yCIzO8HtCqcIW595o=;
        b=f7BQXw29TubVrXg9kZjvyX2ystKMqiz4hk2MTjXOvRy+mQWsxS6QWwZ3aAmsBKGk+e
         aaP7mJm6ief0eweFAab8jDy0mqEb5JWh66XOeSDb/rZyBRkKUkg4Cfp/sbwWDRq8x2Tc
         UMikdsI7RIxqRCKju+QW9IavU8MKZOp6nT2sHF1M7AGMm6IIKwg2WDBZbFPSE8WlUL2f
         ix1ta69qqfB+QvGoF8vacyuGcqperEkyEYVBt8hX/z2NlY6yM9Ot5RadeVat7Kktt3Fi
         MEzW10HUmCk0045xasLSncywlvgee+KBdIhF6ag+3kki4GR4q8qJc6F/8z6jvAt0MM+x
         yd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=Kd/JZBXbIX5coJ5LazkbyZsbv8yCIzO8HtCqcIW595o=;
        b=M8KzRzyyPGRGBP4/SxLTKHyC5dmV+Y62cYHwNvStrjLMp/g3aP/6kimP/xbNos/yfE
         06FrBBCOjM/BCIkiupe2eKMVXViVDyT7jhDu9NHmPwAketFohfHCc/5P3GBh6XJj0fXO
         KovwKZfpeZAl7nFWp1Pz1+KvJtLL1oKq1k4/NliXMpz/K0+fbYHRemZF9ijy9AfM0cnu
         Ra49z8nxMezNK48ZGpwB56Xi6vF9oGwGN3BreDslZmTNUbTd1i5za9n/ksHLOe5pZYUG
         2w18KMSZNgfYJyDEUhKROvd0RZRWwVOQ98PW5XVJ8QIHhKdwQTyLSDeKDXZrB7ZfbWEI
         0Whw==
Received: by 10.112.39.135 with SMTP id p7mr2599183lbk.78.1345225491486;
        Fri, 17 Aug 2012 10:44:51 -0700 (PDT)
Received: by 10.112.39.135 with SMTP id p7mr2599171lbk.78.1345225491315; Fri,
 17 Aug 2012 10:44:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.128.68 with HTTP; Fri, 17 Aug 2012 10:44:31 -0700 (PDT)
In-Reply-To: <502E8115.90507@gmail.com>
References: <502E8115.90507@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 17 Aug 2012 11:44:31 -0600
Message-ID: <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Thierry Reding <thierry.reding@avionic-design.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmLyigWnaMkt2amaLLn1xdG6b1NwcPRaqt4FfU+EUCo/il2yQaEv7fOal3uCYpZmdkU+p4tPEJDnkFbDJkChNSLsWNHdrfmkB4mFZFd444m/K6b25v6aS31O0k/vCTFkFVYpvcepAOWI9+EfPUAN49MZUWcpZM345NMVCvpXqGJc51wpbFI6TtYeivm+RDXd89ryJnPiZsbZNg//J1kr2YDl5wVCg==
X-archive-position: 34256
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fixup_irqs()
> around after init) causes:
>
> WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference from the
> function pci_fixup_irqs() to the function .init.text:pcibios_update_irq()
>
> The MIPS implementation of pcibios_update_irq() is __init, so there is
> conflict with the removal of __init from pci_fixup_irqs() and
> pdev_fixup_irq().
>
> Can you guys either remove the patch from linux-next, or improve it to also
> fix up any architecture implementations of pdev_update_irq()?

Crap, there are lots of arches with this issue.  I'll fix it up.
Thanks for pointing it out!

Bjorn
