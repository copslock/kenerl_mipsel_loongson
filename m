Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2011 23:04:57 +0200 (CEST)
Received: from smtp-out.google.com ([74.125.121.67]:29799 "EHLO
        smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491753Ab1JJVEt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Oct 2011 23:04:49 +0200
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
        by smtp-out.google.com with ESMTP id p9AL4h1w009239
        for <linux-mips@linux-mips.org>; Mon, 10 Oct 2011 14:04:43 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
        t=1318280689; bh=Dwn+kl1Tk6Bf88ymwpRNAT6hxmw=;
        h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=LSoh9nbvTCl59gYlRyrIg6kZHrf+LNU5VvAxt1rEdo7VCMuMF3Q9vCrqIm4igE6sM
         baUAzNhZ89D2/6PnSC2Ig==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
        h=dkim-signature:mime-version:in-reply-to:references:from:date:
        message-id:subject:to:cc:content-type:x-system-of-record;
        b=uLZtfZzHecsL4YNJSFoWi65OSfxRKSbFAJBhJeD/1uSJ/XNegnAAEF2+sYQcmWH+h
        FrrEq48bZy099FXyg9K5g==
Received: from gyd8 (gyd8.prod.google.com [10.243.49.200])
        by wpaz21.hot.corp.google.com with ESMTP id p9AL1ILm025305
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 10 Oct 2011 14:04:42 -0700
Received: by gyd8 with SMTP id 8so9848386gyd.11
        for <linux-mips@linux-mips.org>; Mon, 10 Oct 2011 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IpgDZtq0dWRgFvKP1adf+T78a5+sXS5C1Q3chCXse8U=;
        b=sQN4sv3WuabhbKVuirZgGh+l8vxHqDMgyYPEoM3ASRw38jvo0hCb6gKXXAtC15hPL9
         R+bjQDhkhBGMECFK6B6w==
Received: by 10.150.244.20 with SMTP id r20mr7874847ybh.50.1318280681335;
        Mon, 10 Oct 2011 14:04:41 -0700 (PDT)
Received: by 10.150.244.20 with SMTP id r20mr7874813ybh.50.1318280681112; Mon,
 10 Oct 2011 14:04:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.198.8 with HTTP; Mon, 10 Oct 2011 14:04:21 -0700 (PDT)
In-Reply-To: <CAErSpo5py82G1=6BOTG4RSAj6_SRzN4fng6sECU2sS+u9quixw@mail.gmail.com>
References: <1314845309-3277-1-git-send-email-dczhu@mips.com> <CAErSpo5py82G1=6BOTG4RSAj6_SRzN4fng6sECU2sS+u9quixw@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 10 Oct 2011 15:04:21 -0600
Message-ID: <CAErSpo5HNKi7NSKBbyL3o39Ow+Xkncyccrj5PQNaoeMdLHJsFQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/2] Pass resources to pci_create_bus() and fix
 MIPS PCI resources
To:     Deng-Cheng Zhu <dczhu@mips.com>
Cc:     jbarnes@virtuousgeek.org, ralf@linux-mips.org, monstr@monstr.eu,
        benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        eyal@mips.com, zenon@mips.com, dengcheng.zhu@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-archive-position: 31216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6640

On Fri, Oct 7, 2011 at 3:50 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Aug 31, 2011 at 8:48 PM, Deng-Cheng Zhu <dczhu@mips.com> wrote:
>> (Resending the patch set to include more arch maintainers.)
>>
>> Change the pci_create_bus() interface to pass in available resources to get them
>> settled down early. This is to avoid possible resource conflicts while doing
>> pci_scan_slot() in pci_scan_child_bus(). Note that pcibios_fixup_bus() can get
>> rid of such conflicts, but it's done AFTER scanning slots.
>>
>> In addition, MIPS PCI resources are now fixed using this new interface.
>
> Jesse, I assume these are headed for the 3.2 merge window, right?

I tried to build on these patches to convert x86 to using the new
pci_create_bus() interface, but I couldn't figure out a nice way to
handle an arbitrary number of resources.

We made pci_create_bus() take a "struct pci_bus_resource *"
(https://lkml.org/lkml/2011/8/26/88):

    struct pci_bus *pci_create_bus(struct device *parent, int bus,
			       struct pci_ops *ops, void *sysdata,
			       struct pci_bus_resource *bus_res);

Where pci_bus_resource looks like this:

    struct pci_bus_resource {
        struct list_head list;
        struct resource *res;
        unsigned int flags;
    };

Conceptually, we're passing a list of resources to pci_create_bus(),
which I think is the right thing.  But I think the best way to do that
is by passing a pointer to a struct list_head, not a pointer to a
pci_bus_resource.

If we pass a pci_bus_resource, we're basically using that as a
container for a list (as per include/linux/list.h), but it's not a
well-formed list.  Normally a list contains one list_head per element,
plus an extra list_head for the head of the list.  There's a nice
drawing on page 296 of http://lwn.net/images/pdf/LDD3/ch11.pdf.

The list built in your MIPS patch (https://lkml.org/lkml/2011/8/26/89)
consists of two pci_bus_resource structs (each with a list_head), but
there's no third list_head for the head of the list.  I think if you
tried to use list_for_each_entry() to iterate through the list, it
would not work correctly.

I'll post a slightly modified series to show what I mean.  Take a look
and see if it makes sense to you.

Bjorn
