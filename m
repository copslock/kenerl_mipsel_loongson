Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 17:30:24 +0200 (CEST)
Received: from mail-ia0-f180.google.com ([209.85.210.180]:50286 "EHLO
        mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816383Ab3DRPaWp7S6C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Apr 2013 17:30:22 +0200
Received: by mail-ia0-f180.google.com with SMTP id p22so1486825iad.39
        for <linux-mips@linux-mips.org>; Thu, 18 Apr 2013 08:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=nrhdVaH5uElJtbRrUDP7zxMCJN/dfyGZT7rH6KSwIo4=;
        b=gIHDKVm4l+hxInqVKNhWwuKMHd0TkAdk9rHrVoEI3NfSv56gIPz4Mrfeb0iOgBrW0l
         UHG+ro7k+Laf0nmwsruyTl+SQi7hTi5AYWXpMzatiZWvWPj1H6CmUGIwR75038VagDae
         6Kd1k63lA49fr9s84SFBTeTDSwfWFWrmTtl78E+FApZREzXtattpVONCBInFyC2oRsoo
         XG6OG8CxbagGTMchZVmEojYwbxKK2ShK2UC19PnVognDqS5hRSWQxUOM5JM6xAnrDOOF
         fnzADiY5QQrQVwbq+geZ4MUkrcn+vvqjOFDrM+KGpzNgrW+5NsZ9Q7IgG0v3fUg6Pru+
         PR0Q==
X-Received: by 10.50.164.164 with SMTP id yr4mr13063219igb.4.1366299016036;
 Thu, 18 Apr 2013 08:30:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.71 with HTTP; Thu, 18 Apr 2013 08:29:54 -0700 (PDT)
In-Reply-To: <20130418142434.GA18881@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-3-git-send-email-Andrew.Murray@arm.com> <20130418134401.84AEE3E1319@localhost>
 <20130418142434.GA18881@arm.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 18 Apr 2013 16:29:54 +0100
X-Google-Sender-Auth: 2B9lGxf9_ZjS2JD_xULn2jk1ziM
Message-ID: <CACxGe6u7yoecyTR2r-EzpcRxLuSw-p9KC7jA12wEQZs4of3vFA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] of/pci: Provide support for parsing PCI DT ranges property
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
        "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        "jg1.han@samsung.com" <jg1.han@samsung.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "thomas.petazzoni@free-electrons.com" 
        <thomas.petazzoni@free-electrons.com>,
        "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
        "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQkH3xU/+TigPDIzuP3KABoEAOlH3m5zdsIHF3mxpk7uskwbEHFKrbViEnFWd0gl6iZ7fi+D
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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

On Thu, Apr 18, 2013 at 3:24 PM, Andrew Murray <andrew.murray@arm.com> wrote:
> On Thu, Apr 18, 2013 at 02:44:01PM +0100, Grant Likely wrote:
>> On Tue, 16 Apr 2013 11:18:27 +0100, Andrew Murray <Andrew.Murray@arm.com> wrote:
>> >             /* Act based on address space type */
>> >             res = NULL;
>> > -           switch ((pci_space >> 24) & 0x3) {
>> > -           case 1:         /* PCI IO space */
>> > +           res_type = range.flags & IORESOURCE_TYPE_BITS;
>> > +           if (res_type == IORESOURCE_IO) {
>>
>> Why the change from switch() to an if/else if sequence?
>
> Russell King suggested this change - see
> https://patchwork.kernel.org/patch/2323941/

Umm, that isn't what that link shows. That link shows the patch
already changing to an if/else if construct, and rmk is commenting on
that.

g.
