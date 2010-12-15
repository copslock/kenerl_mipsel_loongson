Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2010 20:12:51 +0100 (CET)
Received: from mail-fx0-f42.google.com ([209.85.161.42]:49808 "EHLO
        mail-fx0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491110Ab0LOTMr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Dec 2010 20:12:47 +0100
Received: by fxm11 with SMTP id 11so2254214fxm.29
        for <linux-mips@linux-mips.org>; Wed, 15 Dec 2010 11:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=sh8qxYDDBIVlflyHatAxFsNIKo5Ia6iEq/WqOYJ5yXw=;
        b=C0GjguFnvNFXrFjPbAcO60iTgQGZbt8iXSNzoZF5msVIeLHkZ8VCI7oKYs/U/G8KTe
         +nf6doVQxuZ1i1Dql/didX7nQRQS8rVAHqjqnbqNN0QZHyQCku3G75mcda8ZovO4fiuZ
         icTXCe3d1TeeeS5rQ9D3LJObooNEwSuAwSct0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Y5e+/1qDB80uIAbzXrv8oIVKfUeDjgg9ybRoCPsMWNRskqWSsphPU1LLtgDzIrGUBR
         +nKPKeu0h8KfumCo7Vx38menj7U0cuYSBIaOzjIhXW5zpIOKJzK/rWNARiEUWK5Fdc/J
         RLxzdTl26XtFvL74GqZwFMhimjLjDykgl05Kg=
Received: by 10.223.109.203 with SMTP id k11mr7939403fap.136.1292440360365;
        Wed, 15 Dec 2010 11:12:40 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id n7sm589956fam.11.2010.12.15.11.12.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 11:12:39 -0800 (PST)
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
In-Reply-To: <4D07B859.2020805@paralogos.com>
References: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
         <4D012560.6020003@paralogos.com>
         <A7DEA48C84FD0B48AAAE33F328C020140595CEB0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
         <4D07B859.2020805@paralogos.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 16 Dec 2010 00:48:58 +0530
Message-ID: <1292440738.27399.33.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2010-12-14 at 10:32 -0800, Kevin D. Kissell wrote:
> Between your mailer and mine (Thunderbird 3.1 on Ubuntu), the quoting
> has become something of a dogs breakfast, so let me just lay things out
> here as best I can.

I am sorry for that. With evolution it will be better I hope.

> 
> I can't comment on your tweak to 2.6.24.7 without seeing it as a patch
> diff.

http://patchwork.linux-mips.org/patch/804/ I was speaking about this
patch. Since my timer is connected through a cascaded CIC , It is
required to check TI bit of cause register in order to ensure a timer
interrupt. With above mentioned patch I was able to boot a 2.6.24-stable
SMTC kernel. ( Not tested fully though )

> The recommended procedure was, and remains, to isolate clock
> propagation problems by using command line options "maxtcs="
> and "maxvpes=".
> 
> First, boot your SMTC kernel with maxtcs=1 and maxvpes=1,
> a virtual uniprocessor.  If that doesn't run, you've got some fundamental
> problem with support for your platform, or someone has really fundamentally
> broken the SMTC build somewhere.  Next, try booting with maxtcs=2
> and maxvpes=1, then with no constraint on maxtcs and maxvpes=1.
> If those fail, your problem is probably in the interrupt mask
> management algorithms I described

Even with command line maxtcs=1 and maxvpes=1 I am seeing same hung. The
register dump is copied below.


> Your dump below looks as if it comes from 2 TCs running on
> 2 VPEs, and that the interrupt mask issues I alluded to earlier
> are neither relevant nor manifest.  It looks instead as if the
> initialization of "CPU 1" (VPE1/TC1) may not have been done
> properly.  Under normal operation, it would be pretty rare to
> catch TC 1 in the exception vector dispatch code, so the first
> hypothesis that comes to mind is that something isn't right in
> the vector/handler setup, and TC 1 is stuck in an infinite exception
> loop, unable to handshake with TC 0 and thus locking up the
> system.  But that's just my best guess based on limited data.
> 
>              Regards,
> 
>              Kevin K.
> 

I have tested few stable tags in git and isolated the code brake.

2.6.24-stable + patch[1] = SMTC boot success
2.6.29-stable + patch[1] = SMTC boot success
2.6.31-stable + patch[1] = SMTC boot success
2.6.32-stable + patch[1] = SMTC boot success
2.6.33-stable		 = SMTC boot failed
2.6.35-stable 		 = SMTC boot failed

So it looks like SMTC support got broke between 2.6.32 and 2.6.33 .

Thanks and Regards,
Anoop

patch[1] : http://patchwork.linux-mips.org/patch/804/


#############################Log###########################
    0.000000] Calibrating delay loop... === MIPS MT State Dump ===
[    0.000000] -- Global State --
[    0.000000]    MVPControl Passed: 00000000
[    0.000000]    MVPControl Read: 00000000
[    0.000000]    MVPConf0 : a8008406
[    0.000000] -- per-VPE State --
[    0.000000]   VPE 0
[    0.000000]    VPEControl : 00000000
[    0.000000]    VPEConf0 : 800f0003
[    0.000000]    VPE0.Status : 11004001
[    0.000000]    VPE0.EPC : 80100000 _stext+0x0/0x10
[    0.000000]    VPE0.Cause : 50804000
[    0.000000]    VPE0.Config7 : 00010000
[    0.000000]   VPE 1
[    0.000000]    VPEControl : 00060000
[    0.000000]    VPEConf0 : 800f0000
[    0.000000]    VPE1.Status : 00408305
[    0.000000]    VPE1.EPC : 80100380 name_to_dev_t+0x50/0x430
[    0.000000]    VPE1.Cause : 50000200
[    0.000000]    VPE1.Config7 : 00010000
[    0.000000] -- per-TC State --
[    0.000000]   TC 0 (current TC with VPE EPC above)
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00000000
[    0.000000]    TCRestart : 8010d860 mips_mt_regdump+0x2f0/0x3c4
[    0.000000]    TCHalt : 00000000
[    0.000000]    TCContext : 00000000
[    0.000000]   TC 1
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00200001
[    0.000000]    TCRestart : 8f800020 0x8f800020
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00140000
[    0.000000]   TC 2
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00400001
[    0.000000]    TCRestart : 8f800020 0x8f800020
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00280000
[    0.000000]   TC 3
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00600001
[    0.000000]    TCRestart : 8f800020 0x8f800020
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 003c0000
[    0.000000]   TC 4
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00800001
[    0.000000]    TCRestart : 80100380 name_to_dev_t+0x50/0x430
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00500000
[    0.000000]   TC 5
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00a00001
[    0.000000]    TCRestart : 80100380 name_to_dev_t+0x50/0x430
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00640000
[    0.000000]   TC 6
[    0.000000]    TCStatus : 00000000
[    0.000000]    TCBind : 00c00001
[    0.000000]    TCRestart : 80268e00 aes_encrypt+0x10e4/0x164c
[    0.000000]    TCHalt : 00000001
[    0.000000]    TCContext : 00780000
[    0.000000] Counter Interrupts taken per CPU (TC)
[    0.000000] 0: 0
[    0.000000] 1: 0
[    0.000000] 2: 0
[    0.000000] 3: 0
[    0.000000] 4: 0
[    0.000000] 5: 0
[    0.000000] 6: 0
[    0.000000] 7: 0
[    0.000000] Self-IPI invocations:
[    0.000000] 0: 0
[    0.000000] 1: 0
[    0.000000] 2: 0
[    0.000000] 3: 0
[    0.000000] 4: 0
[    0.000000] 5: 0
[    0.000000] 6: 0
[    0.000000] 7: 0
[    0.000000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
[    0.000000] 0 Recoveries of "stolen" FPU
[    0.000000] ===========================
[    0.000000] In platform cic dispatch cic_mask=0x22000 stat=0x2402000f
pend=0x20000
[    0.010000] === MIPS MT State Dump ===
[    0.010000] -- Global State --
[    0.010000]    MVPControl Passed: 00000000
[    0.010000]    MVPControl Read: 00000000
[    0.010000]    MVPConf0 : a8008406
[    0.010000] -- per-VPE State --
[    0.010000]   VPE 0
[    0.010000]    VPEControl : 00000000
[    0.010000]    VPEConf0 : 800f0003
[    0.010000]    VPE0.Status : 18004000
[    0.010000]    VPE0.EPC : 8010d900 mips_mt_regdump+0x390/0x3c4
[    0.010000]    VPE0.Cause : 40804000
[    0.010000]    VPE0.Config7 : 00010000
[    0.010000]   VPE 1
[    0.010000]    VPEControl : 00060000
[    0.010000]    VPEConf0 : 800f0000
[    0.010000]    VPE1.Status : 00408305
[    0.010000]    VPE1.EPC : 80100380 name_to_dev_t+0x50/0x430
[    0.010000]    VPE1.Cause : 50000200
[    0.010000]    VPE1.Config7 : 00010000
[    0.010000] -- per-TC State --
[    0.010000]   TC 0 (current TC with VPE EPC above)
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00000000
[    0.010000]    TCRestart : 803f791c printk+0xc/0x30
[    0.010000]    TCHalt : 00000000
[    0.010000]    TCContext : 00000000
[    0.010000]   TC 1
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00200001
[    0.010000]    TCRestart : 8f800020 0x8f800020
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00140000
[    0.010000]   TC 2
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00400001
[    0.010000]    TCRestart : 8f800020 0x8f800020
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00280000
[    0.010000]   TC 3
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00600001
[    0.010000]    TCRestart : 8f800020 0x8f800020
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 003c0000
[    0.010000]   TC 4
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00800001
[    0.010000]    TCRestart : 80100380 name_to_dev_t+0x50/0x430
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00500000
[    0.010000]   TC 5
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00a00001
[    0.010000]    TCRestart : 80100380 name_to_dev_t+0x50/0x430
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00640000
[    0.010000]   TC 6
[    0.010000]    TCStatus : 00000000
[    0.010000]    TCBind : 00c00001
[    0.010000]    TCRestart : 80268e00 aes_encrypt+0x10e4/0x164c
[    0.010000]    TCHalt : 00000001
[    0.010000]    TCContext : 00780000
[    0.010000] Counter Interrupts taken per CPU (TC)
[    0.010000] 0: 0
[    0.010000] 1: 0
[    0.010000] 2: 0
[    0.010000] 3: 0
[    0.010000] 4: 0
[    0.010000] 5: 0
[    0.010000] 6: 0
[    0.010000] 7: 0
[    0.010000] Self-IPI invocations:
[    0.010000] 0: 0
[    0.010000] 1: 0
[    0.010000] 2: 0
[    0.010000] 3: 0
[    0.010000] 4: 0
[    0.010000] 5: 0
[    0.010000] 6: 0
[    0.010000] 7: 0
[    0.010000] IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
[    0.010000] 0 Recoveries of "stolen" FPU
[    0.010000] ===========================
