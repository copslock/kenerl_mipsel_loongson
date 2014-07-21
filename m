Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 01:18:14 +0200 (CEST)
Received: from mail-oa0-f54.google.com ([209.85.219.54]:60373 "EHLO
        mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861530AbaGUXQ3f-0WF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Jul 2014 01:16:29 +0200
Received: by mail-oa0-f54.google.com with SMTP id n16so8471529oag.13
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SzOT+iQlpjk8w8gwT1esquiLBb4iw9KcX3RMvBksSZg=;
        b=orzUt+PesGSxHs/XaZp7aFUa/m9k05k9r/lxz9Rxrt3QOZpg9Ye5+NZC1/VIyhApsN
         tDjxuW8iRkEMLH3kDdblTEhBzbejigbCHPuN3iibnDHEtpeg3qyVpK8k88T4Z30d4iot
         Smtl7dkUIgrg1xV+ucrDgRtBA+6O/g2BAtEsVevlcqv+qursZmDnl67A+WO7XifDV2gg
         c7qn+YbZzF/Vs9PjYa4ff13A49tLR4J8R0wpEkrXZ8+K66Pu9UsKdSa4UcmgKPBoErx1
         F6z4/l8fKEbY9jWEmaKiC4NCiwIzHHeuCT+JyqRMWVzgkgCSMnF1IHYQo1UXdG3IsSh2
         jurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=SzOT+iQlpjk8w8gwT1esquiLBb4iw9KcX3RMvBksSZg=;
        b=C6Yy5ZDkHvpWQ72JhUrRH6cB1TLMYMvGagJiwfUHXdB3DTc73FAwxSPYrJYPGJC2nF
         VVP0Z92j8R2nl6eN340UzuoJHVu4S5CHLvr6CZq/xkUqJu8XB4LM745INLjjmn03nPmM
         nF08HWrq9FwDz3U7tyZwjCDExodJXxjts7IP7W9Jn3Z3z6WFMxXCarWQjWF9G5nvPJg4
         xXC4m/TC4XGC5LnryyCFkVkCnwEles3hCYgfaEv0OuoLAzwHwu6wbrrEE1ZtNscBr6sI
         GXu3K7CAJxurLLxD+aoq2mTcC1LJ6Vd11eD+YZ3WaQmqoX8BsmvYynh3PbBVhJiO8jf2
         wI3A==
X-Gm-Message-State: ALoCoQn9xcvI0vLNkSU46/xVax18Vjch7SwbwSc8/WPxob7sa9Xv/UtmiTwOyJL4a+/tDUcuE7Vj
X-Received: by 10.182.18.69 with SMTP id u5mr41695471obd.54.1405984583313;
 Mon, 21 Jul 2014 16:16:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.120.196 with HTTP; Mon, 21 Jul 2014 16:16:03 -0700 (PDT)
In-Reply-To: <1405709421.30262.8.camel@dabdike.int.hansenpartnership.com>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
 <20140718162213.GC31114@tuxdriver.com> <20140718164340.GA24960@kroah.com>
 <1405702472.30262.1.camel@dabdike.int.hansenpartnership.com>
 <20140718181759.GB2193@kroah.com> <1405709421.30262.8.camel@dabdike.int.hansenpartnership.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 21 Jul 2014 17:16:03 -0600
Message-ID: <CAErSpo7svKg0HiL=g8wWAHWUN3vs0UgCvVhvd84DM6nVDmT=FQ@mail.gmail.com>
Subject: Re: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Greg KH <greg@kroah.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Benoit Taine <benoit.taine@lip6.fr>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-fbdev@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ath5k-devel@venema.h4ckr.net, linux-acenic@sunsite.dk,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        ath10k@lists.infradead.org, linux-hippi@sunsite.dk,
        industrypack-devel@lists.sourceforge.net,
        linux-mmc <linux-mmc@vger.kernel.org>,
        MPT-FusionLinux.pdl@avagotech.com,
        virtualization@lists.linux-foundation.org,
        ath9k-devel@venema.h4ckr.net, wil6210@qca.qualcomm.com,
        linux-pcmcia@lists.infradead.org, linux-can@vger.kernel.org,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        platform-driver-x86@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        users@rt2x00.serialmonkey.com,
        "e1000-devel@lists.sourceforge.net" 
        <e1000-devel@lists.sourceforge.net>, linux-crypto@vger.kernel.org,
        devel@linuxdriverproject.org, Jingoo Han <jg1.han@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41403
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

[+cc Jingoo]

On Fri, Jul 18, 2014 at 12:50 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Fri, 2014-07-18 at 11:17 -0700, Greg KH wrote:
>> On Fri, Jul 18, 2014 at 09:54:32AM -0700, James Bottomley wrote:
>> > On Fri, 2014-07-18 at 09:43 -0700, Greg KH wrote:
>> > > On Fri, Jul 18, 2014 at 12:22:13PM -0400, John W. Linville wrote:
>> > > > On Fri, Jul 18, 2014 at 05:26:47PM +0200, Benoit Taine wrote:
>> > > > > We should prefer `const struct pci_device_id` over
>> > > > > `DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
>> > > > > This issue was reported by checkpatch.
>> > > >
>> > > > Honestly, I prefer the macro -- it stands-out more.  Maybe the style
>> > > > guidelines and/or checkpatch should change instead?
>> > >
>> > > The macro is horrid, no other bus has this type of thing just to save a
>> > > few characters in typing
>> >
>> > OK, so this is the macro:
>> >
>> > #define DEFINE_PCI_DEVICE_TABLE(_table) \
>> >     const struct pci_device_id _table[]
>> >
>> > Could you explain what's so horrible?
>> >
>> > The reason it's useful today is that people forget the const (and
>> > sometimes the [] making it a true table instead of a pointer).  If you
>> > use the DEFINE_PCI_DEVICE_TABLE macro, the compile breaks if you use it
>> > wrongly (good) and you automatically get the correct annotations.
>>
>> We have almost 1000 more uses of the non-macro version than the "macro"
>> version in the kernel today:
>> $ git grep -w DEFINE_PCI_DEVICE_TABLE | wc -l
>> 262
>> $ git grep "const struct pci_device_id" | wc -l
>> 1254
>>
>> My big complaint is that we need to be consistant, either pick one or
>> the other and stick to it.  As the macro is the least used, it's easiest
>> to fix up, and it also is more consistant with all other kernel
>> subsystems which do not have such a macro.
>
> I've a weak preference for consistency, but not at the expense of
> hundreds of patches churning the kernel to remove an innocuous macro.
> Churn costs time and effort.
>
>> As there is no need for the __init macro mess anymore, there's no real
>> need for the DEFINE_PCI_DEVICE_TABLE macro either.  I think checkpatch
>> will catch the use of non-const users for the id table already today, it
>> catches lots of other uses like this already.
>>
>> > > , so why should PCI be "special" in this regard
>> > > anymore?
>> >
>> > I think the PCI usage dwarfs most other bus types now, so you could turn
>> > the question around.  However, I don't think majority voting is a good
>> > guide to best practise; lets debate the merits for their own sake.
>>
>> Not really "dwarf", USB is close with over 700 such structures:
>> $ git grep "const struct usb_device_id" | wc -l
>> 725
>>
>> And i2c is almost just as big as PCI:
>> $ git grep "const struct i2c_device_id" | wc -l
>> 1223
>>
>> So again, this macro is not consistent with the majority of PCI drivers,
>> nor with any other type of "device id" declaration in the kernel, which
>> is why I feel it should be removed.
>>
>> And finally, the PCI documentation itself says to not use this macro, so
>> this isn't a "new" thing.  From Documentation/PCI/pci.txt:
>>
>>       The ID table is an array of struct pci_device_id entries ending with an
>>       all-zero entry.  Definitions with static const are generally preferred.
>>       Use of the deprecated macro DEFINE_PCI_DEVICE_TABLE should be avoided.
>>
>> That wording went into the file last December, when we last talked about
>> this and everyone in that discussion agreed to remove the macro for the
>> above reasons.
>>
>> Consistency matters.
>
> In this case, I don't think it does that much ... a cut and paste either
> way (from a macro or non-macro based driver) yields correct code.  Since
> there's no bug here and no apparent way to misuse the macro, why bother?
>
> Anyway, it's PCI code ... let the PCI maintainer decide.  However, if he
> does want this do it as one big bang patch via either the PCI or Trivial
> tree (latter because Jiří has experience doing this, but the former
> might be useful so the decider feels the pain ...)

I don't feel strongly either way, so I guess I'm OK with this, and in
the spirit of feeling the pain, I'm willing to handle it.  Jingoo
proposed similar patches, so it might be nice to give him some credit.

Benoit, how about if you wait until about half-way through the merge
window after v3.16 releases, generate an up-to-date single patch, and
post that?  Then we can try to get it in before v3.17-rc1 to minimize
merge hassles.

Bjorn
