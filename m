Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 21:47:07 +0200 (CEST)
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36682 "EHLO
        mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010590AbbDGTrD4Mfdq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Apr 2015 21:47:03 +0200
Received: by qgeb100 with SMTP id b100so25955078qge.3
        for <linux-mips@linux-mips.org>; Tue, 07 Apr 2015 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VfgYgkp38OFu8YZ4kjeBaftLIFesDZINLmOzvKWrpns=;
        b=EyMr6BF8X8QcIUhgqSRMWtakzJ6xydsj4Dq3wfBdNmJesMnBjennOEafIVUCrshQNo
         9k+RWjcJCA9NYUgAKOwIjdkiTingA6Wpz8WMZk3nAfgSASGYg+eLg1J8QVLmGK+qFQUA
         7630uQGsWUCFJ3SvSQW9lT4LejL/gGvt3UZIdoqr/XflOrBaINLxqTNQ6NFe6hfoPfuS
         xl9C2ejFzTDKWppoMExI4N7CxvjJlOlxmyHjoSQ6XC8BJYmauvzIBC973FIGh8wWwMhP
         v13EddyETZncv2ka+asQy9G5JK9PAbzQcBfn/DElnuK8BI1hxBXrE7Se0oIFElNTlxqV
         MTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=VfgYgkp38OFu8YZ4kjeBaftLIFesDZINLmOzvKWrpns=;
        b=G+t9M4894Z2ze02KzGafG4Ql6a6X7KHE35NPpq+Pst4sM5twIVyIIYbw4vZ8qm6M/p
         Ae0d5MGJ5+kYtCB99XnD2pghFXFAoD6L6MdkPdgED1Kr5oeasF7GcP76po7355vMxu0R
         0UmgjU58s5Idg1pf4/vbNoEPokevkLwx+F7PH+ufppsYSe/4kNXQL6FFk1qn2I+Ls8jH
         4wrCHRaDetdU3ZEpk3GNcIZGKLfEH+GUFrOOPgxZI9MAflmZXj3KtMY821jA9VCIv677
         Rh1Xw+W0CmD/eiiyQAycVB3Gb+n04C95VquLmQlm66AMgx3jvPWSUgv1enEO72+wnwcz
         tvlg==
X-Gm-Message-State: ALoCoQmLtagRHRMJZQA6IHJsL8xNGGXuvQ120yBgE8KLdVfcSrJ86p/lf7vK1gFwzHwAJZRTrsQ+
X-Received: by 10.229.214.199 with SMTP id hb7mr26556775qcb.12.1428436019528;
 Tue, 07 Apr 2015 12:46:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.163.78 with HTTP; Tue, 7 Apr 2015 12:46:38 -0700 (PDT)
In-Reply-To: <CACna6ryiajzYAW+SJkJ-9ETpUe1+VDt99yKw9C39u_Na2q2kTQ@mail.gmail.com>
References: <CACna6ryiajzYAW+SJkJ-9ETpUe1+VDt99yKw9C39u_Na2q2kTQ@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 7 Apr 2015 14:46:38 -0500
Message-ID: <CAErSpo6wObVZUwkBoUfi3bqfJ-BtQwX0=WEkWqoTsNXhs5dHVA@mail.gmail.com>
Subject: Re: Preventing PCI from assigning mem (for MMIO) to bridge device
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Felix Fietkau <nbd@openwrt.org>,
        =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        Larry Finger <larry.finger@lwfinger.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46816
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

Hi Rafał,

On Tue, Apr 7, 2015 at 4:51 AM, Rafał Miłecki <zajec5@gmail.com> wrote:
> Hello,
>
> I own a home router Linksys WRT300N v1.0 with CardBus slot on PCB and
> wireless card attached.
>
> This is MIPS SoC BCM4704 using following code for PCI controller:
> 1) register_pci_controller
> http://lxr.free-electrons.com/source/arch/mips/pci/pci.c?v=3.18#L167
> 2) ssb_pcicore_init_hostmode
> http://lxr.free-electrons.com/source/drivers/ssb/driver_pcicore.c?v=3.18#L317
>
> There are two PCI devices discoverable:
> 1) 0000:00:00.0 (bridge)
> 14e4:472d / class 0x068000 / hdr_type 0
> 2) 0000:00:01.0 (wireless device)
> 14e4:4329 / class 0x028000 / hdr_type 0
>
> My problem is that PCI subsystem assigns memory to the bridge device:
> pci 0000:00:00.0: BAR 1: assigned [mem 0x40000000-0x47ffffff pref]
> pci 0000:00:01.0: BAR 0: assigned [mem 0x48000000-0x48003fff]
> pci 0000:00:00.0: BAR 0: assigned [mem 0x48004000-0x48005fff]
>
> This ancient & simple PCI controller allows assigning resources to the
> wireless device only (slot 1). Trying to assign resources to the
> bridge device (writing to slot 0 to registers PCI_BASE_ADDRESS_[0-5])
> results in overwriting wireless device (slot 0) configuration!
> As you can guess from the above log, the last assignment (targeting
> slot 0) will break (overwrite) wireless device (slot 1) configuration.
> Trying to access any MMIO register of wireless device will cause "Data
> bus error".
> For more details please see my comment in OpenWrt Trac:
> https://dev.openwrt.org/ticket/12682#comment:11 (there is a nice
> configuration dump after every assignment).
>
> So I'm looking for a way to stop PCI subsystem from assigning any
> memory to the bridge device (slot 0). I still need it to assign memory
> for wireless device (slot 1) as its driver requires MMIO access.
>
> I'm wondering what is the best way to achieve that?
>
> MIPS arch code seems to respect PCI_PROBE_ONLY but this will stop
> assigning memory to wireless device (slot 1) too.
>
> I was considering modifying my "struct pci_ops" write callback to
> include something like this:
> if (extpci_core->cardbusmode && dev == 0 &&
>     off >= PCI_BASE_ADDRESS_0 &&
>     off <= PCI_BASE_ADDRESS_5)
>         return -ENOTSUPP;
> It seems to be working fine, all I get with above change is:
> pci 0000:00:01.0: BAR 0: assigned [mem 0x40000000-0x40003fff]
> , but I need an opinion if this is a correct solution.

I'd have to understand the problem better to give you a good opinion.
It sounds like you think there's a hardware defect in the bridge?  If
that's the case, we can often write a quirk to work around it.

Could you open a report at bugzilla.kernel.org against drivers/PCI,
and attach a complete dmesg log and output of "lspci -vv"?  The newer
the kernel you can try, the better.

Bjorn
